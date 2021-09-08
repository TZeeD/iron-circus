// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.GameElements.Player
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas.Unity;
using Imi.Game;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.ScEntitas;
using Imi.SteelCircus.JitterUnity;
using Imi.SteelCircus.ScriptableObjects;
using Imi.SteelCircus.UI.Floor;
using Imi.SteelCircus.Utils;
using Imi.SteelCircus.Utils.Extensions;
using Imi.Utils.Common;
using Imi.Utils.Extensions;
using SharedWithServer.ScEvents;
using SteelCircus.Core;
using SteelCircus.FX;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace Imi.SteelCircus.GameElements
{
  [RequireComponent(typeof (AudioSource))]
  public class Player : MonoBehaviour
  {
    private Transform ballHoldTransform;
    [SerializeField]
    private GameObject stunnedEffectPrefab;
    [SerializeField]
    private GameObject gainHealthEffectPrefab;
    [SerializeField]
    private GameObject gainRechargeEffectPrefab;
    [SerializeField]
    private GameObject gainSprintEffectPrefab;
    [SerializeField]
    private GameObject dodgeEffectPrefab;
    [SerializeField]
    private GameObject viewContainer;
    [SerializeField]
    private AudioSource playerAudioSource;
    [SerializeField]
    private Material deathMat;
    [SerializeField]
    private MaterialManager materialManager;
    [SerializeField]
    private float deathDuration = 1.5f;
    private GameObject boostEffect;
    private GameObject stunnedEffect;
    private GameObject dodgeEffect;
    private GameObject gainHealthEffect;
    private GameObject gainRechargeEffect;
    private GameObject[] gainSprintEffect;
    private int sprintFxIndex;
    private PlayerFloorUI floorUI;
    private GameEntity gameEntity;
    private ulong playerId = ulong.MaxValue;
    private CharacterGlowFX glowFX;
    [SerializeField]
    [Readonly]
    private List<Transform> aimBones = new List<Transform>();
    public static Action<Player> onPlayerStart;
    public static Action<Player> onPlayerDestroy;
    public static List<Player> playerViews = new List<Player>();
    private bool hasBall;
    private bool wasPlayStunFx;
    private bool wasScrambled;
    private float currentAngle;

    public Transform BallHoldTransform => this.ballHoldTransform;

    [HideInInspector]
    public GameObject ViewContainer => this.viewContainer;

    [HideInInspector]
    public PlayerFloorUI FloorUI => this.floorUI;

    public GameEntity GameEntity
    {
      get
      {
        if (this.gameEntity == null)
          this.gameEntity = (GameEntity) this.GetComponent<EntityLink>().entity;
        return this.gameEntity;
      }
    }

    public ulong PlayerId
    {
      get
      {
        if (this.playerId == ulong.MaxValue)
          this.playerId = this.GameEntity.playerId.value;
        return this.playerId;
      }
    }

    public ChampionConfig Config => this.GameEntity.championConfig.value;

    public int MaxHealth => this.Config.maxHealth;

    public int CurrentHealth => this.GameEntity.playerHealth.value;

    public Team PlayerTeam => this.GameEntity.playerTeam.value;

    public Transform ViewTransform => this.viewContainer.transform;

    public MaterialManager MatManager => this.materialManager;

    public Vector3 CurrentVelocity => this.GameEntity.velocityOverride.value.ToVector3();

    private void Start()
    {
      this.materialManager = this.gameObject.AddComponent<MaterialManager>();
      this.stunnedEffect = UnityEngine.Object.Instantiate<GameObject>(this.stunnedEffectPrefab, this.ViewTransform, false);
      this.stunnedEffect.SetActive(false);
      this.dodgeEffect = UnityEngine.Object.Instantiate<GameObject>(this.dodgeEffectPrefab, this.ViewTransform, false);
      this.dodgeEffect.SetActive(false);
      this.gainHealthEffect = UnityEngine.Object.Instantiate<GameObject>(this.gainHealthEffectPrefab, this.ViewTransform, false);
      this.gainHealthEffect.SetActive(false);
      this.gainRechargeEffect = UnityEngine.Object.Instantiate<GameObject>(this.gainRechargeEffectPrefab, this.ViewTransform, false);
      this.gainRechargeEffect.SetActive(false);
      this.gainSprintEffect = new GameObject[3];
      for (int index = 0; index < this.gainSprintEffect.Length; ++index)
      {
        this.gainSprintEffect[index] = UnityEngine.Object.Instantiate<GameObject>(this.gainSprintEffectPrefab, this.ViewTransform, false);
        this.gainSprintEffect[index].SetActive(false);
      }
      Events.Global.OnEventPlayerHealthChanged += new Events.EventPlayerHealthChanged(this.OnPlayerHealthChanged);
      Events.Global.OnEventShowHidePlayerUi += new Events.EventShowHidePlayerUi(this.OnShowHideUiEvent);
      Action<Player> onPlayerStart = Player.onPlayerStart;
      if (onPlayerStart != null)
        onPlayerStart(this);
      Player.playerViews.Add(this);
      Transform deepChild1 = this.transform.FindDeepChild(this.Config.ballHoldHandName);
      this.ballHoldTransform = new GameObject("ball_hold_node").transform;
      this.ballHoldTransform.SetParent(deepChild1);
      this.ballHoldTransform.localPosition = this.Config.ballHoldOffsetFromHand;
      GameObject gameObject = UnityEngine.Object.Instantiate<GameObject>(Resources.Load<GameObject>("Prefabs/UI/PlayerFloorUI/PlayerFloorUI"), this.gameObject.transform);
      gameObject.transform.localRotation = Quaternion.identity;
      MatchObjectsParent.FloorRenderer.AddEmissive(gameObject.transform);
      gameObject.GetComponent<LinkLocalSpace>().linkedTransform = this.viewContainer.transform;
      this.floorUI = gameObject.GetComponent<PlayerFloorUI>();
      this.floorUI.SetPlayer(this);
      this.floorUI.gameObject.name = this.name;
      this.glowFX = this.gameObject.AddComponent<CharacterGlowFX>();
      this.glowFX.SetGlowingMaterialsList(this.materialManager.GetOriginalMaterials().Values.ToList<Material[]>());
      foreach (string aimRotationBone in this.gameEntity.championConfig.value.aimRotationBones)
      {
        Transform deepChild2 = this.transform.FindDeepChild(aimRotationBone);
        if ((bool) (UnityEngine.Object) deepChild2)
          this.aimBones.Add(deepChild2);
      }
    }

    private void UpdateBallOwnership()
    {
      GameEntity ballEntity = Contexts.sharedInstance.game.ballEntity;
      if (!this.hasBall && ballEntity.hasBallOwner && ballEntity.ballOwner.IsOwner(this.gameEntity))
      {
        this.hasBall = true;
        this.PlayBallPickupFXTrigger();
        this.glowFX.SetGlow(SingletonScriptableObject<ColorsConfig>.Instance.characterHoldBallGlow, SingletonScriptableObject<ColorsConfig>.Instance.characterHoldBallGlowIntensity);
        RazerChromaHelper.ShowBallCarry();
      }
      else
      {
        if (!this.hasBall || ballEntity.hasBallOwner && ballEntity.ballOwner.IsOwner(this.gameEntity))
          return;
        this.hasBall = false;
        this.glowFX.ClearGlow();
        if (this.gameEntity.hasPlayerTeam)
          RazerChromaHelper.ExecuteRazerAnimationForTeam(this.gameEntity.playerTeam.value);
        else
          RazerChromaHelper.ExecuteRazerAnimationForTeam(Team.None);
      }
    }

    public void OnDestroy()
    {
      Action<Player> onPlayerDestroy = Player.onPlayerDestroy;
      if (onPlayerDestroy != null)
        onPlayerDestroy(this);
      Player.playerViews.Remove(this);
      UnityEngine.Object.Destroy((UnityEngine.Object) this.floorUI.gameObject);
      Events.Global.OnEventPlayerHealthChanged -= new Events.EventPlayerHealthChanged(this.OnPlayerHealthChanged);
      Events.Global.OnEventShowHidePlayerUi -= new Events.EventShowHidePlayerUi(this.OnShowHideUiEvent);
    }

    private void OnShowHideUiEvent(ulong inPlayerId, bool showFloorUi, bool showOverhead)
    {
      if ((long) inPlayerId != (long) this.PlayerId)
        return;
      this.floorUI.gameObject.SetActive(showFloorUi);
    }

    private void OnPlayerHealthChanged(
      ulong inPlayerId,
      int oldHealth,
      int currentHealth,
      int maxHealth,
      bool isDead)
    {
      if ((long) inPlayerId != (long) this.PlayerId)
        return;
      if (this.viewContainer.gameObject.activeInHierarchy == isDead)
      {
        if (isDead)
        {
          this.StartCoroutine(this.PlayDeathEffect());
          this.floorUI.gameObject.SetActive(false);
        }
        else
        {
          this.viewContainer.gameObject.SetActive(true);
          this.floorUI.gameObject.SetActive(true);
          this.StartCoroutine(this.PlaySpawnFX());
        }
      }
      else if (currentHealth > oldHealth)
      {
        this.PlayHealthGainFXTrigger();
      }
      else
      {
        if (currentHealth >= oldHealth)
          return;
        this.PlayDamageFXTrigger();
      }
    }

    private IEnumerator ShowRazerChromaEffect(int r, int g, int b)
    {
      RazerChromaHelper.ShowPickupEffectWithColor(r, g, b);
      yield return (object) new WaitForSeconds(2f);
      RazerChromaHelper.ExecuteRazerAnimationForTeam(Contexts.sharedInstance.game.GetFirstLocalEntity().playerChampionData.value.team);
    }

    public IEnumerator PlaySpawnFX()
    {
      // ISSUE: reference to a compiler-generated field
      int num = this.\u003C\u003E1__state;
      Player player = this;
      if (num != 0)
      {
        if (num != 1)
          return false;
        // ISSUE: reference to a compiler-generated field
        this.\u003C\u003E1__state = -1;
        player.gameObject.GetComponent<PlayerSpawnView>().RespawnPlayerEffect();
        return false;
      }
      // ISSUE: reference to a compiler-generated field
      this.\u003C\u003E1__state = -1;
      // ISSUE: reference to a compiler-generated field
      this.\u003C\u003E2__current = (object) null;
      // ISSUE: reference to a compiler-generated field
      this.\u003C\u003E1__state = 1;
      return true;
    }

    public void PlayDamageFXTrigger()
    {
      this.glowFX.Flash(SingletonScriptableObject<ColorsConfig>.Instance.characterFlashDamage, 0.4f);
      ControllerRumble.RumbleController(this.playerId, 0.5f, 0.5f);
    }

    public void PlayHealthGainFXTrigger()
    {
      this.StartCoroutine(this.PlayHealthGainFX());
      if (!this.gameEntity.isLocalEntity)
        return;
      this.StartCoroutine(this.ShowRazerChromaEffect(0, (int) byte.MaxValue, 0));
    }

    public void PlaySkillRefreshFXTrigger()
    {
      this.StartCoroutine(this.PlaySkillRefreshFx());
      if (!this.gameEntity.isLocalEntity)
        return;
      this.StartCoroutine(this.ShowRazerChromaEffect(74, 0, 110));
    }

    public void PlaySprintRefreshFXTrigger()
    {
      this.StartCoroutine(this.PlaySprintRefreshFx(this.sprintFxIndex % 3));
      ++this.sprintFxIndex;
      if (!this.gameEntity.isLocalEntity)
        return;
      this.StartCoroutine(this.ShowRazerChromaEffect(74, 0, 110));
    }

    public void PlayBallPickupFXTrigger() => this.glowFX.Flash(SingletonScriptableObject<ColorsConfig>.Instance.characterFlashBallPickup, 0.4f);

    private IEnumerator PlayHealthGainFX()
    {
      this.glowFX.Flash(SingletonScriptableObject<ColorsConfig>.Instance.characterFlashHeal);
      float t = 0.0f;
      this.gainHealthEffect.SetActive(true);
      ControllerRumble.RumbleController(this.playerId, 0.5f, 0.5f);
      while ((double) t < 2.0)
      {
        t += Time.deltaTime;
        yield return (object) null;
      }
      this.gainHealthEffect.SetActive(false);
    }

    private IEnumerator PlaySkillRefreshFx()
    {
      this.glowFX.Flash(SingletonScriptableObject<ColorsConfig>.Instance.characterFlashSkillPickup);
      float t = 0.0f;
      this.gainRechargeEffect.SetActive(true);
      ControllerRumble.RumbleController(this.playerId, 0.5f, 0.5f);
      while ((double) t < 2.0)
      {
        t += Time.deltaTime;
        yield return (object) null;
      }
      this.gainRechargeEffect.SetActive(false);
    }

    private IEnumerator PlaySprintRefreshFx(int index)
    {
      this.glowFX.Flash(SingletonScriptableObject<ColorsConfig>.Instance.characterFlashSprintPickup);
      float t = 0.0f;
      this.gainSprintEffect[index].SetActive(true);
      ControllerRumble.RumbleController(this.playerId, 0.5f, 0.5f);
      while ((double) t < 1.0)
      {
        t += Time.deltaTime;
        yield return (object) null;
      }
      this.gainSprintEffect[index].SetActive(false);
    }

    private IEnumerator PlayDeathEffect()
    {
      Player player = this;
      player.stunnedEffect.SetActive(false);
      MaterialEffectDescriptor mat = player.materialManager.AddMaterialToStack(player.deathMat);
      float t = 0.0f;
      string audioID = "";
      switch (player.Config.championType)
      {
        case ChampionType.Servitor:
          audioID = "Capx02VoiceDie";
          break;
        case ChampionType.Bagpipes:
          audioID = "LochlanVoiceDie";
          break;
        case ChampionType.Li:
          audioID = "SchroederVoiceDie";
          break;
        case ChampionType.Mali:
          audioID = "ShaniVoiceDie";
          break;
        case ChampionType.Hildegard:
          audioID = "EllikaVoiceDie";
          break;
        case ChampionType.Acrid:
          audioID = "AcridVoiceDie";
          break;
        case ChampionType.Galena:
          audioID = "GalenaVoiceDie";
          break;
        case ChampionType.Kenny:
          audioID = "KennyVoiceDie";
          break;
      }
      AudioController.Play(audioID, player.transform);
      while ((double) t < (double) player.deathDuration && player.GameEntity.playerHealth.value <= 0)
      {
        player.materialManager.SetCurrentSharedMaterialAlpha((float) (1.0 - (double) t / (double) player.deathDuration));
        t += Time.deltaTime;
        yield return (object) null;
      }
      if (!player.GameEntity.hasDeath && player.GameEntity.isLocalEntity || !player.GameEntity.IsDead())
      {
        if (player.GameEntity.isPlayerRespawning)
        {
          player.materialManager.RemoveMaterialFromStack(mat);
        }
        else
        {
          player.viewContainer.gameObject.SetActive(false);
          player.materialManager.RemoveMaterialFromStack(mat);
          player.GameEntity.isPlayerRespawning = true;
          player.viewContainer.gameObject.SetActive(true);
          player.floorUI.gameObject.SetActive(true);
          player.StartCoroutine(player.PlaySpawnFX());
        }
      }
      else
      {
        player.viewContainer.gameObject.SetActive(false);
        player.materialManager.RemoveMaterialFromStack(mat);
      }
    }

    private void OnStunnedEnter()
    {
      this.stunnedEffect.SetActive(true);
      ControllerRumble.StartLocalPlayerRumble(this.PlayerId, 0.6f);
      AudioController.Play("TackleGetHit", this.transform);
      if (this.CurrentHealth <= 0)
        return;
      if ((double) UnityEngine.Random.Range(0.0f, 1f) > 0.200000002980232)
        AudioController.Play("PlayerTackledCrowd");
      string audioID = "";
      switch (this.Config.championType)
      {
        case ChampionType.Servitor:
          audioID = "Capx02VoiceGetHit";
          break;
        case ChampionType.Bagpipes:
          audioID = "LochlanVoiceGetHit";
          break;
        case ChampionType.Li:
          audioID = "SchroederVoiceGetHit";
          break;
        case ChampionType.Mali:
          audioID = "ShaniVoiceGetHit";
          break;
        case ChampionType.Hildegard:
          audioID = "EllikaVoiceGetHit";
          break;
        case ChampionType.Acrid:
          audioID = "AcridVoiceGetHit";
          break;
        case ChampionType.Galena:
          audioID = "GalenaVoiceGetHit";
          break;
        case ChampionType.Kenny:
          audioID = "KennyVoiceGetHit";
          break;
      }
      AudioController.Play(audioID, this.transform);
    }

    private void OnStunnedExit()
    {
      this.stunnedEffect.SetActive(false);
      ControllerRumble.StopLocalPlayerRumble();
    }

    private void Update()
    {
      this.UpdateBallOwnership();
      bool flag1 = this.gameEntity.IsStunned() || this.gameEntity.IsPushed();
      if (flag1 != this.wasPlayStunFx)
      {
        this.wasPlayStunFx = flag1;
        if (flag1)
          this.OnStunnedEnter();
        else
          this.OnStunnedExit();
      }
      bool flag2 = this.gameEntity.IsScrambled();
      if (this.wasScrambled != flag2)
      {
        this.wasScrambled = flag2;
        this.FloorUI.SetState(flag2 ? FloorUiVisibilityState.Scrambled : FloorUiVisibilityState.Normal);
      }
      this.viewContainer.transform.localRotation = Quaternion.identity;
      if (!this.gameEntity.hasVelocityOverride || this.gameEntity.velocityOverride.value.IsNearlyZero() || this.gameEntity.IsMoveBlocked())
        return;
      this.viewContainer.transform.rotation = Quaternion.LookRotation(this.gameEntity.velocityOverride.value.Normalized().ToVector3(), Vector3.up);
    }

    private void LateUpdate()
    {
      GameContext game = Contexts.sharedInstance.game;
      Vector3 forward = this.viewContainer.transform.forward;
      Vector3 zero = Vector3.zero;
      if ((game.matchState.value != Imi.SharedWithServer.Game.MatchState.PointInProgress ? 1 : (this.gameEntity.animationState.HasType(AnimationStateType.DontTurnHead) ? 1 : 0)) != 0)
        return;
      Vector3 vector3;
      if (this.gameEntity.IsBallOwner(game) || this.gameEntity.animationState.HasType(AnimationStateType.TurnHeadToAim))
      {
        int tick = game.globalTime.currentTick;
        if (!this.gameEntity.isLocalEntity)
          tick = game.globalTime.lastServerTick;
        vector3 = this.gameEntity.input.GetInput(tick).aimDir.ToVector3();
      }
      else
        vector3 = Vector3.Normalize(game.ballEntity.transform.Position2D.ToVector3() - this.transform.position);
      ChampionConfig championConfig = this.gameEntity.championConfig.value;
      float num = (double) Vector3.Dot(vector3, this.viewContainer.transform.right) > 0.0 ? 1f : -1f;
      float v1 = Mathf.Clamp(Vector3.Angle(forward, vector3), 0.0f, championConfig.maxAimRotation) * num;
      float t = Mathf.Clamp01(championConfig.aimAnimRotationSpeed * Time.deltaTime / Mathf.Abs(v1 - this.currentAngle));
      this.currentAngle = Imi.SharedWithServer.Utils.Extensions.MathExtensions.Interpolate(this.currentAngle, v1, t);
      RigUtils.AddRotation(this.aimBones, this.currentAngle);
    }

    public bool OwnsBall()
    {
      GameContext game = Contexts.sharedInstance.game;
      return game.ballEntity != null && game.ballEntity.hasBallOwner && (long) game.ballEntity.ballOwner.playerId == (long) this.GameEntity.playerId.value;
    }
  }
}
