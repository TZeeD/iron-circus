// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.UI.Floor.PlayerFloorUI
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.ScEntitas;
using Imi.SteelCircus.JitterUnity;
using Imi.SteelCircus.ScriptableObjects;
using Imi.SteelCircus.UI.Floor.Player;
using Imi.SteelCircus.Utils;
using Imi.SteelCircus.Utils.Extensions;
using Jitter.LinearMath;
using SteelCircus;
using System;
using System.Collections.Generic;
using UnityEngine;

namespace Imi.SteelCircus.UI.Floor
{
  public class PlayerFloorUI : MonoBehaviour
  {
    protected static readonly int _MinAngle = Shader.PropertyToID(nameof (_MinAngle));
    protected static readonly int _MaxAngle = Shader.PropertyToID(nameof (_MaxAngle));
    private Imi.SteelCircus.GameElements.Player player;
    private GameContext context;
    private Goal enemyGoal;
    public ColorsConfig colorsConfig;
    public float switchChargeDisplayDuration = 1f;
    public AnimationCurve switchChargeDisplayCurve = AnimationCurve.Linear(0.0f, 0.0f, 1f, 1f);
    public float skillDisplayScaleWhenCharging = 0.7f;
    public float playerDirectionArrowOffset = 0.55f;
    public float playerDirectionArrowHeight = 1.3f;
    [Header("Main Containers")]
    [SerializeField]
    private GameObject regularDisplayParent;
    [SerializeField]
    private GameObject minimizedDisplayParent;
    [SerializeField]
    private GameObject scrambledDisplayParent;
    [Header("Active Displays")]
    [SerializeField]
    private PlayerFloorSkillDisplay skillDisplay;
    [SerializeField]
    private PlayerFloorHealthDisplay healthDisplay;
    [SerializeField]
    private PlayerFloorOuterRingDisplay outerRingDisplay;
    [SerializeField]
    private PlayerFloorBallCatchDisplay ballCatchDisplay;
    [SerializeField]
    private PlayerFloorPingDisplay pingDisplay;
    [Header("Elements managed by this behaviour")]
    [SerializeField]
    private SpriteRenderer playerDirectionArrow;
    [SerializeField]
    private Transform ballDirectionArrow;
    [SerializeField]
    private Transform playerDirection;
    [SerializeField]
    private Transform chargeRingParent;
    [SerializeField]
    private Renderer chargeRing;
    [SerializeField]
    private SpriteRenderer ballThrowDistanceArrow;
    [SerializeField]
    private Transform goalDirection;
    [SerializeField]
    private Renderer goalDirectionRenderer;
    [SerializeField]
    private Renderer outerCircleDark;
    [SerializeField]
    private Renderer outerCircleLight;
    [SerializeField]
    private Renderer innerCircleRegular;
    [SerializeField]
    private Renderer innerCircleMinimized;
    [SerializeField]
    private Renderer mainCircleBG;
    [SerializeField]
    private Renderer skillDisplayCircleBG;
    [SerializeField]
    private Transform[] rotatingWithPlayer;
    [Header("Direction Lines to other players")]
    [SerializeField]
    private GameObject directionToOthersPrefab;
    [SerializeField]
    private Transform directionsToOthers;
    private Dictionary<ulong, PlayerDirectionToOthersIndicator> playerIDsToDirections = new Dictionary<ulong, PlayerDirectionToOthersIndicator>();
    [SerializeField]
    private int MaxLineThicknessAtDistanceToOthers = 7;
    [SerializeField]
    private int MinLineThicknessAtDistanceToOthers = 14;
    [Header("Debug")]
    [Range(0.0f, 1f)]
    public float debugCharge;
    private bool isCharging;
    private float chargeCounter;
    private SkillVar<JVector> aimDirVar;
    private FloorUiVisibilityState state;
    private bool prevPlayerOwnedBall;
    private bool prevPingState;

    public void SetPlayer(Imi.SteelCircus.GameElements.Player player)
    {
      this.player = player;
      foreach (SkillGraph skillGraph in player.GameEntity.skillGraph.skillGraphs)
      {
        if (skillGraph.GetConfig() is ThrowBallConfig)
          this.aimDirVar = skillGraph.GetVar<JVector>("AimDir");
      }
    }

    public void SetState(FloorUiVisibilityState state)
    {
      switch (state)
      {
        case FloorUiVisibilityState.Normal:
          this.regularDisplayParent.SetActive(true);
          this.minimizedDisplayParent.SetActive(false);
          this.scrambledDisplayParent.SetActive(false);
          break;
        case FloorUiVisibilityState.Minimized:
          this.regularDisplayParent.SetActive(false);
          this.minimizedDisplayParent.SetActive(true);
          this.scrambledDisplayParent.SetActive(false);
          break;
        case FloorUiVisibilityState.Hidden:
          this.regularDisplayParent.SetActive(false);
          this.minimizedDisplayParent.SetActive(false);
          this.scrambledDisplayParent.SetActive(false);
          break;
        case FloorUiVisibilityState.Scrambled:
          this.regularDisplayParent.SetActive(true);
          this.minimizedDisplayParent.SetActive(false);
          this.scrambledDisplayParent.SetActive(true);
          this.SetDisabledColors();
          break;
        default:
          throw new NotImplementedException(string.Format("Unknown visibility state '{0}'", (object) state));
      }
      if (this.state == FloorUiVisibilityState.Scrambled && this.state != state)
        this.SetTeamColors();
      this.state = state;
    }

    public FloorUiVisibilityState GetState() => this.state;

    public void Reset()
    {
      this.SetState(FloorUiVisibilityState.Normal);
      this.SetTeamColors();
      this.SetCharging(false, false);
    }

    private void Awake()
    {
      this.context = Contexts.sharedInstance.game;
      this.healthDisplay.onMaxHPChanged += new Action<PlayerFloorHealthDisplay>(this.outerRingDisplay.MaxHPChangedHandler);
      this.SetState(FloorUiVisibilityState.Normal);
    }

    private void InitializeDirectionsToOthers()
    {
      Log.Debug("PlayerFloorUI init");
      foreach (Component component in this.playerIDsToDirections.Values)
        UnityEngine.Object.Destroy((UnityEngine.Object) component.gameObject);
      this.playerIDsToDirections.Clear();
      GameEntity gameEntity1 = this.player.GameEntity;
      Team team = gameEntity1.playerTeam.value;
      HashSet<GameEntity> entitiesWithPlayerTeam = this.context.GetEntitiesWithPlayerTeam(team);
      Color c = this.colorsConfig.LightColor(team);
      foreach (GameEntity gameEntity2 in entitiesWithPlayerTeam)
      {
        if (gameEntity2 != gameEntity1)
        {
          GameObject gameObject = UnityEngine.Object.Instantiate<GameObject>(this.directionToOthersPrefab);
          gameObject.transform.parent = this.directionsToOthers;
          gameObject.transform.SetToIdentity();
          PlayerDirectionToOthersIndicator component = gameObject.GetComponent<PlayerDirectionToOthersIndicator>();
          component.SetColor(c);
          this.playerIDsToDirections[gameEntity2.playerId.value] = component;
        }
      }
    }

    private void Start()
    {
      Team team = this.GetTeam();
      this.outerRingDisplay.Setup(this.colorsConfig, team);
      this.healthDisplay.Setup(this.colorsConfig, team, this.player);
      this.ballCatchDisplay.Setup(this.colorsConfig, team);
      this.pingDisplay.Setup(this.colorsConfig, team, this.player);
      this.SetTeamColors();
      foreach (Goal goal in UnityEngine.Object.FindObjectsOfType<Goal>())
      {
        if (goal.team == team)
        {
          this.enemyGoal = goal;
          break;
        }
      }
      this.InitializeDirectionsToOthers();
    }

    private void OnDestroy()
    {
    }

    private void SetTeamColors()
    {
      Team team1 = this.GetTeam();
      Team team2 = team1 == Team.Alpha ? Team.Beta : Team.Alpha;
      this.outerCircleDark.material.color = this.colorsConfig.DarkColor(team1);
      this.outerCircleLight.material.color = this.colorsConfig.LightColor(team1);
      this.innerCircleRegular.material.color = this.colorsConfig.LightColor(team1);
      this.innerCircleMinimized.material.color = this.colorsConfig.LightColor(team1);
      this.goalDirectionRenderer.material.color = this.colorsConfig.LightColor(team2);
      this.mainCircleBG.material.color = this.colorsConfig.DarkColor(team1);
      this.skillDisplayCircleBG.material.color = this.colorsConfig.DarkColor(team1);
      this.goalDirectionRenderer.material.SetColor("_Color2", this.colorsConfig.LightColor(team2));
    }

    private void SetDisabledColors()
    {
      this.outerCircleDark.material.color = this.colorsConfig.disabledColorDark;
      this.outerCircleLight.material.color = this.colorsConfig.disabledColorLight;
      this.innerCircleRegular.material.color = this.colorsConfig.disabledColorLight;
      this.innerCircleMinimized.material.color = this.colorsConfig.disabledColorLight;
      this.mainCircleBG.material.color = this.colorsConfig.disabledColorDark;
      this.skillDisplayCircleBG.material.color = this.colorsConfig.disabledColorDark;
    }

    private void Update()
    {
      if (!Contexts.HasSharedInstance || !Contexts.sharedInstance.game.hasMatchState)
        return;
      foreach (Transform transform in this.rotatingWithPlayer)
        transform.localRotation = this.player.transform.localRotation;
      bool flag = this.player.OwnsBall();
      if (!this.prevPlayerOwnedBall & flag)
        this.ballCatchDisplay.Animate();
      bool playerPing = this.GetPlayerPing();
      if (playerPing && !this.prevPingState)
      {
        Transform pingTarget = (Transform) null;
        if (this.context.ballEntity.hasBallOwner)
        {
          ulong playerId = this.context.ballEntity.ballOwner.playerId;
          GameEntity entityWithPlayerId = this.context.GetFirstEntityWithPlayerId(playerId);
          if (entityWithPlayerId != null && (long) playerId != (long) this.player.PlayerId && entityWithPlayerId.hasPlayerTeam && entityWithPlayerId.playerTeam.value == this.GetTeam() && entityWithPlayerId.hasUnityView && (UnityEngine.Object) entityWithPlayerId.unityView.gameObject != (UnityEngine.Object) null)
            pingTarget = entityWithPlayerId.unityView.gameObject.transform;
        }
        this.pingDisplay.Animate(pingTarget);
      }
      this.SetCharging((double) this.GetPlayerCharge() != 0.0 | flag);
      this.UpdateAimDirection();
      this.UpdateCharge();
      this.UpdateBallDirection();
      this.UpdateDirectionsToOthers();
      this.UpdateVisibilityForState();
      this.prevPlayerOwnedBall = flag;
      this.prevPingState = playerPing;
    }

    private void UpdateAimDirection()
    {
      Vector3 vector3 = ((JVector) this.aimDirVar).ToVector3();
      float y = Vector2.SignedAngle(new Vector2(vector3.x, vector3.z), Vector2.up);
      this.playerDirection.eulerAngles = new Vector3(0.0f, y, 0.0f);
      this.chargeRingParent.eulerAngles = new Vector3(0.0f, y, 0.0f);
    }

    private void UpdateDirectionsToOthers()
    {
      GameEntity gameEntity1 = this.player.GameEntity;
      HashSet<GameEntity> entitiesWithPlayerTeam = this.context.GetEntitiesWithPlayerTeam(gameEntity1.playerTeam.value);
      bool flag1 = false;
      foreach (GameEntity gameEntity2 in entitiesWithPlayerTeam)
      {
        if ((long) gameEntity2.playerId.value != (long) gameEntity1.playerId.value && !this.playerIDsToDirections.ContainsKey(gameEntity2.playerId.value))
        {
          flag1 = true;
          break;
        }
      }
      foreach (ulong key in this.playerIDsToDirections.Keys)
      {
        if ((long) key != (long) gameEntity1.playerId.value)
        {
          bool flag2 = false;
          foreach (GameEntity gameEntity3 in entitiesWithPlayerTeam)
          {
            if ((long) gameEntity3.playerId.value == (long) key)
              flag2 = true;
          }
          if (!flag2)
          {
            flag1 = true;
            break;
          }
        }
      }
      if (flag1)
        this.InitializeDirectionsToOthers();
      bool flag3 = this.player.OwnsBall();
      foreach (ulong key in this.playerIDsToDirections.Keys)
      {
        PlayerDirectionToOthersIndicator playerIdsToDirection = this.playerIDsToDirections[key];
        GameEntity entityWithPlayerId = this.context.GetFirstEntityWithPlayerId(key);
        playerIdsToDirection.gameObject.SetActive(flag3 && entityWithPlayerId.unityView.gameObject.activeSelf && !entityWithPlayerId.IsDead());
        Transform transform = playerIdsToDirection.transform;
        Vector3 vector3 = entityWithPlayerId.transform.position.ToVector3();
        if (entityWithPlayerId.hasUnityView)
          vector3 = entityWithPlayerId.unityView.gameObject.transform.position;
        vector3.y = 0.0f;
        Vector3 forward = vector3 - this.player.transform.position;
        forward.y = 0.0f;
        if (forward != Vector3.zero)
          transform.localRotation = Quaternion.LookRotation(forward);
        float magnitude = forward.magnitude;
        playerIdsToDirection.SetLength(magnitude);
        playerIdsToDirection.SetThickness(Mathf.Pow(1f - Mathf.Clamp01((magnitude - (float) this.MaxLineThicknessAtDistanceToOthers) / (float) (this.MinLineThicknessAtDistanceToOthers - this.MaxLineThicknessAtDistanceToOthers)), 2f));
      }
    }

    private void UpdateVisibilityForState()
    {
      bool flag = this.player.OwnsBall();
      this.goalDirectionRenderer.gameObject.SetActive(false);
      this.outerRingDisplay.gameObject.SetActive(flag);
      this.ballDirectionArrow.gameObject.SetActive(!flag);
    }

    private void UpdateGoalDirection()
    {
      Vector2 vector2_1 = MathUtils.FlattenY(this.player.transform.position);
      Bounds bounds = this.enemyGoal.GetComponent<Collider>().bounds;
      float y = (double) bounds.center.z > 0.0 ? bounds.min.z : bounds.max.z;
      Vector2 vector2_2 = new Vector2(bounds.min.x, y);
      Vector2 vector2_3 = new Vector2(bounds.max.x, y);
      Vector2 vector2_4 = vector2_2 - vector2_1;
      Vector2 normalized1 = vector2_4.normalized;
      vector2_4 = vector2_3 - vector2_1;
      Vector2 normalized2 = vector2_4.normalized;
      vector2_4 = normalized1 + normalized2;
      Vector2 normalized3 = vector2_4.normalized;
      float num1 = Mathf.Atan2(normalized3.x, normalized3.y) * 57.29578f;
      float num2 = Vector2.Angle(normalized1, normalized3);
      float num3 = Vector2.Angle(normalized2, normalized3);
      this.goalDirection.localEulerAngles = Vector3.up * num1;
      this.goalDirectionRenderer.material.SetFloat(PlayerFloorUI._MinAngle, 180f - num2);
      this.goalDirectionRenderer.material.SetFloat(PlayerFloorUI._MaxAngle, 180f + num3);
      vector2_4 = (vector2_2 + vector2_3) * 0.5f - vector2_1;
      this.goalDirection.localScale = Vector3.one * (vector2_4.magnitude + 5f) / this.transform.localScale.x;
    }

    private void UpdateBallDirection()
    {
      Vector3 vector3 = this.context.ballEntity.transform.position.ToVector3();
      vector3.y = 0.0f;
      Vector3 forward = vector3 - this.player.transform.position;
      if (!(forward != Vector3.zero))
        return;
      this.ballDirectionArrow.localRotation = Quaternion.LookRotation(forward);
    }

    private void SetCharging(bool value, bool animate = true)
    {
      if (this.isCharging == value & animate)
        return;
      this.isCharging = value;
      if (animate)
        return;
      this.chargeCounter = this.isCharging ? 1f : 0.0f;
    }

    private void UpdateCharge()
    {
      this.chargeCounter = Mathf.Clamp01(this.chargeCounter + (float) ((double) Time.deltaTime / (double) this.switchChargeDisplayDuration * (this.isCharging ? 1.0 : -1.0)));
      float t = this.switchChargeDisplayCurve.Evaluate(this.chargeCounter);
      this.skillDisplay.Scale = Mathf.LerpUnclamped(1f, this.skillDisplayScaleWhenCharging, t);
      float x = this.playerDirectionArrow.transform.localScale.x;
      float num1 = this.playerDirectionArrowOffset * (1f - t);
      float a = this.playerDirectionArrowHeight + this.playerDirectionArrowOffset / x;
      float num2 = a - num1 / x;
      Vector3 localPosition = this.playerDirectionArrow.transform.localPosition;
      localPosition.z = num1;
      this.playerDirectionArrow.transform.localPosition = localPosition;
      Vector2 size1 = this.playerDirectionArrow.size;
      size1.y = num2;
      this.playerDirectionArrow.size = size1;
      float playerCharge = this.GetPlayerCharge();
      float num3 = Mathf.Lerp(3f, 6f, playerCharge) / this.transform.localScale.x;
      float num4 = Mathf.Lerp(10f, 180f, playerCharge);
      this.chargeRing.material.SetFloat(PlayerFloorUI._MinAngle, 180f - num4);
      this.chargeRing.material.SetFloat(PlayerFloorUI._MaxAngle, 180f + num4);
      this.ballThrowDistanceArrow.gameObject.SetActive((double) playerCharge != 0.0);
      if ((double) playerCharge != 0.0)
      {
        Vector2 size2 = this.ballThrowDistanceArrow.size;
        size2.y = Mathf.Max(a, Mathf.Lerp(a, num3 / this.ballThrowDistanceArrow.transform.localScale.x, t));
        this.ballThrowDistanceArrow.size = size2;
      }
      bool flag = this.player.OwnsBall();
      Color color1 = flag ? this.colorsConfig.floorUIChargeColorDark : this.colorsConfig.floorUIPrechargeColorDark;
      Color color2 = flag ? this.colorsConfig.floorUIChargeColorLight : this.colorsConfig.floorUIPrechargeColorLight;
      this.chargeRing.material.SetColor("_Color", color1);
      this.chargeRing.material.SetColor("_Color2", color2);
      this.ballThrowDistanceArrow.color = flag ? this.colorsConfig.floorUIChargeColorLight : this.colorsConfig.DarkColor(this.GetTeam());
      this.playerDirectionArrow.color = flag ? ((double) playerCharge != 0.0 ? this.colorsConfig.floorUIChargeColorDark : this.colorsConfig.LightColor(this.GetTeam())) : this.colorsConfig.MiddleColor(this.GetTeam());
    }

    private float GetPlayerCharge() => !this.player.GameEntity.skillUi.HasStateData(Imi.SharedWithServer.ScEntitas.Components.ButtonType.ThrowBall) ? 0.0f : this.player.GameEntity.skillUi.GetStateData(Imi.SharedWithServer.ScEntitas.Components.ButtonType.ThrowBall).fillAmount;

    private bool GetPlayerPing() => this.player.GameEntity.skillUi.HasStateData(Imi.SharedWithServer.ScEntitas.Components.ButtonType.Ping) && this.player.GameEntity.skillUi.GetStateData(Imi.SharedWithServer.ScEntitas.Components.ButtonType.Ping).active;

    private Team GetTeam() => this.player.PlayerTeam;
  }
}
