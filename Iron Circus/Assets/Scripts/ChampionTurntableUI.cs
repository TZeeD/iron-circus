// Decompiled with JetBrains decompiler
// Type: ChampionTurntableUI
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game;
using Imi.SteelCircus.ScriptableObjects;
using Imi.SteelCircus.Utils;
using Imi.SteelCircus.Utils.Extensions;
using SteelCircus.Core.Services;
using SteelCircus.ScriptableObjects;
using SteelCircus.UI.Menu;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class ChampionTurntableUI : MonoBehaviour
{
  public ChampionTurntableUI.CameraMode cameraMode;
  public Camera renderCam;
  [SerializeField]
  private CameraSetting championGalleryCameraSetting;
  [SerializeField]
  private GameObject iconPrefab;
  [SerializeField]
  private GameObject iconDisplayPlane;
  [SerializeField]
  private Vector2 sprayDisplayScale;
  public Transform championTurntablePivot;
  [SerializeField]
  private Transform[] teamMemberChampionPositions;
  [SerializeField]
  private GameObject championTurntablePrefab;
  [SerializeField]
  private Vector3 championInitialRotation;
  private Dictionary<int, ActiveChampionInfo> championInfoDict;
  private ActiveChampionInfo activeChampionInfo;
  private GameObject[] teamMemberActiveChampion;
  private ChampionTurntableUI.CameraMode currentCameraMode;
  private Dictionary<string, GameObject> teamChampionDictionary = new Dictionary<string, GameObject>();
  [SerializeField]
  private Animation lobbyFlash;
  [SerializeField]
  private GameObject galleryMenuLighting;
  private MainMenuLightingConfig lightingConfig;
  public bool playGalleryEmote;
  private IEnumerator playGalleryAnimationCoroutine;

  public ActiveChampionInfo ChampionInfo => this.activeChampionInfo;

  private void Awake()
  {
    this.championInfoDict = new Dictionary<int, ActiveChampionInfo>();
    this.teamMemberActiveChampion = new GameObject[this.teamMemberChampionPositions.Length];
    if ((Object) this.iconDisplayPlane != (Object) null)
      this.iconDisplayPlane.SetActive(false);
    this.lightingConfig = Resources.Load<MainMenuLightingConfig>("Configs/Visual/MainMenuLightingConfig");
    this.lightingConfig.OnMenuLightingChanged += new MainMenuLightingConfig.OnMenuLightingChangedEventHandler(this.updateLighting);
  }

  private void OnDestroy() => this.lightingConfig.OnMenuLightingChanged -= new MainMenuLightingConfig.OnMenuLightingChangedEventHandler(this.updateLighting);

  private void Update()
  {
    if (this.cameraMode == this.currentCameraMode)
      return;
    this.SetCameraMode(this.cameraMode);
  }

  public void updateLighting(MainMenuLightingType lightingType)
  {
    if (!((Object) this.galleryMenuLighting != (Object) null))
      return;
    if (lightingType == MainMenuLightingType.Gallery)
      this.galleryMenuLighting.SetActive(true);
    else
      this.galleryMenuLighting.SetActive(false);
  }

  public void UpdateAnimation()
  {
    if (!((Object) this.activeChampionInfo.championAnimator != (Object) null))
      return;
    this.activeChampionInfo.championAnimator.Update(Time.deltaTime);
  }

  public void SetCameraMode(int newCamMode) => this.SetCameraMode((ChampionTurntableUI.CameraMode) newCamMode);

  public void SetCameraMode(ChampionTurntableUI.CameraMode newCamMode)
  {
    this.cameraMode = newCamMode;
    this.currentCameraMode = this.cameraMode;
    this.UpdateCamera();
  }

  public void UpdateCamera()
  {
    if (this.activeChampionInfo == null || !((Object) this.activeChampionInfo.champion != (Object) null) || this.cameraMode == ChampionTurntableUI.CameraMode.None)
      return;
    CameraSetting camSetting = this.cameraMode == ChampionTurntableUI.CameraMode.Portrait ? this.activeChampionInfo.champion.cameraClose : this.activeChampionInfo.champion.cameraFar;
    if (this.cameraMode == ChampionTurntableUI.CameraMode.ChampionGallery)
      camSetting = this.championGalleryCameraSetting;
    this.UpdateCamera(camSetting);
  }

  public void UpdateCamera(CameraSetting camSetting)
  {
    this.renderCam.transform.localPosition = camSetting.position;
    this.renderCam.fieldOfView = camSetting.fov;
  }

  public void SetChampSelected()
  {
    this.HideSpraytagSprite();
    if (this.activeChampionInfo == null)
      return;
    Animator championAnimator = this.activeChampionInfo.championAnimator;
    if ((Object) championAnimator != (Object) null)
    {
      if (this.activeChampionInfo.champion.championType == ChampionType.Mali)
        championAnimator.gameObject.GetComponent<AnimationEventHandler>().SetObjectVisibility("name=spear,show=false");
      championAnimator.SetTrigger("selectedTurntable");
    }
    else
      Log.Error(string.Format("{0} with {1} has no Animator! {2}", (object) this.activeChampionInfo.champion, (object) this.activeChampionInfo.skin.fileName, (object) this.activeChampionInfo.championAnimator));
  }

  public void TriggerChampSelectedAction(int action)
  {
    if (this.activeChampionInfo == null || this.activeChampionInfo == null)
      return;
    Animator championAnimator = this.activeChampionInfo.championAnimator;
    if ((Object) championAnimator != (Object) null)
      championAnimator.SetTrigger("selectedTurntableAction");
    else
      Log.Error(string.Format("{0} with {1} has no Animator! {2}", (object) this.activeChampionInfo.champion, (object) this.activeChampionInfo.skin.fileName, (object) this.activeChampionInfo.championGameObject));
  }

  public void SetChampSubmitted()
  {
    if (this.activeChampionInfo == null || !((Object) this.activeChampionInfo.championGameObject != (Object) null))
      return;
    this.StartSubmitAnimationForChampion(this.activeChampionInfo.championGameObject);
  }

  public void SetChampSubmitted(int championPedestal) => this.StartSubmitAnimationForChampion(this.teamMemberActiveChampion[championPedestal]);

  private void StartSubmitAnimationForChampion(GameObject go)
  {
    Animator componentInChildren = go.GetComponentInChildren<Animator>();
    if ((Object) componentInChildren != (Object) null)
      componentInChildren.SetTrigger("submitTurntable");
    else
      Log.Warning(string.Format("{0} with {1} has no Animator! {2}", (object) this.activeChampionInfo.champion, (object) this.activeChampionInfo.skin.fileName, (object) this.activeChampionInfo.championGameObject));
  }

  public void ApplyCameraSettings()
  {
    if (!((Object) this.activeChampionInfo.champion != (Object) null))
      return;
    if (this.cameraMode == ChampionTurntableUI.CameraMode.Portrait)
    {
      this.activeChampionInfo.champion.cameraClose.position = this.renderCam.transform.localPosition;
      this.activeChampionInfo.champion.cameraClose.fov = this.renderCam.fieldOfView;
    }
    else
    {
      this.activeChampionInfo.champion.cameraFar.position = this.renderCam.transform.localPosition;
      this.activeChampionInfo.champion.cameraFar.fov = this.renderCam.fieldOfView;
    }
  }

  public void HideAll()
  {
    this.HideSpraytagSprite();
    foreach (Transform transform in this.championTurntablePivot)
    {
      if ((Object) transform.gameObject != (Object) this.iconDisplayPlane)
        transform.gameObject.SetActive(false);
    }
    if (this.activeChampionInfo != null && (Object) this.activeChampionInfo.championGameObject != (Object) null)
      this.activeChampionInfo.championGameObject.SetActive(false);
    this.activeChampionInfo = (ActiveChampionInfo) null;
  }

  public void Clear()
  {
    this.HideSpraytagSprite();
    foreach (Transform transform in this.championTurntablePivot)
    {
      if ((Object) transform.gameObject != (Object) this.iconDisplayPlane)
        Object.DestroyImmediate((Object) transform.gameObject);
    }
    if (this.activeChampionInfo != null && (Object) this.activeChampionInfo.championGameObject != (Object) null)
      this.activeChampionInfo.championGameObject.SetActive(false);
    this.activeChampionInfo = (ActiveChampionInfo) null;
    this.championInfoDict = new Dictionary<int, ActiveChampionInfo>();
  }

  public bool SetActiveChampion(ChampionConfig champConfig, ItemDefinition skinItem)
  {
    Log.Debug(string.Format("Set active turntable Champion to {0} with skin {1}", (object) champConfig, (object) skinItem.fileName));
    this.StopAnimationLoop();
    if (this.activeChampionInfo != null && this.activeChampionInfo.skin == skinItem)
    {
      Log.Debug("No change");
      return false;
    }
    Log.Debug(string.Format("Setting Active Turntable Champion {0}/{1}", (object) champConfig.championType, (object) skinItem.fileName));
    this.HideAll();
    if (skinItem.definitionId != -1)
      this.activeChampionInfo = !this.championInfoDict.ContainsKey(skinItem.definitionId) ? this.CreateNewChampInfo(champConfig, skinItem) : this.championInfoDict[skinItem.definitionId];
    this.activeChampionInfo.championGameObject.transform.rotation = Quaternion.Euler(this.championInitialRotation);
    this.activeChampionInfo.championGameObject.SetActive(true);
    this.UpdateCamera();
    return true;
  }

  public ActiveChampionInfo CreateNewChampInfo(
    ChampionConfig champ,
    ItemDefinition item)
  {
    GameObject turntableModel = PlayerUtils.CreateTurntableModel(this.championTurntablePrefab, champ, item.prefab as GameObject, this.championTurntablePivot);
    ActiveChampionInfo activeChampionInfo = new ActiveChampionInfo(champ, turntableModel, item);
    this.championInfoDict.Add(item.definitionId, activeChampionInfo);
    return activeChampionInfo;
  }

  public void SetActiveChampion(ChampionConfig champConfig) => this.SetActiveChampion(champConfig, ImiServices.Instance.progressManager.GetEquippedSkinForChampion(champConfig));

  public void SetTeamMemberChampionActive(
    GameEntity player,
    ulong playerId,
    ChampionConfig champConfig,
    int pickIndex,
    bool playAnimation)
  {
    GameObject prefabFromLoadout = PlayerUtils.GetSkinPrefabFromLoadout(player.playerLoadout.itemLoadouts, champConfig, player.playerChampionData.value.team);
    string key = this.GetChampionDictkey(pickIndex, playerId, champConfig, prefabFromLoadout.name);
    if (this.teamChampionDictionary.ContainsKey(key))
    {
      if (this.teamChampionDictionary[key].activeInHierarchy)
        return;
      this.SetTeamMemberChampionsInactive(pickIndex);
      this.teamMemberActiveChampion[pickIndex] = this.teamChampionDictionary[key];
      this.teamMemberActiveChampion[pickIndex].SetActive(true);
      if (playAnimation)
      {
        this.StartSubmitAnimationForChampion(this.teamMemberActiveChampion[pickIndex]);
        this.lobbyFlash.Play();
      }
      Debug.Log((object) string.Format("<color=#ff0000ff>[Setting champ {0} active]</color>", (object) this.teamMemberActiveChampion[pickIndex]), (Object) this.teamMemberActiveChampion[pickIndex]);
    }
    else
    {
      this.SetTeamMemberChampionsInactive(pickIndex);
      this.teamMemberActiveChampion[pickIndex] = this.CreateChampion(playerId, champConfig, prefabFromLoadout, out key, pickIndex);
      this.teamChampionDictionary[key] = this.teamMemberActiveChampion[pickIndex];
      if (!playAnimation)
        return;
      this.StartSubmitAnimationForChampion(this.teamMemberActiveChampion[pickIndex]);
      this.lobbyFlash.Play();
    }
  }

  public void SetTeamMemberChampionIconActive(
    ulong playerId,
    ChampionConfig champConfig,
    int pickIndex)
  {
    if ((Object) champConfig.Champion3DIconPrefab == (Object) null || this.teamMemberChampionPositions == null)
    {
      this.Clear();
      Debug.LogError((object) "Champion3DIconPrefab was null! Check the config!");
    }
    else
    {
      this.SetTeamMemberChampionsInactive(pickIndex);
      string championDictkeyForIcon = this.GetChampionDictkeyForIcon(pickIndex, playerId, champConfig);
      if (this.teamChampionDictionary.ContainsKey(championDictkeyForIcon))
      {
        if (this.teamChampionDictionary[championDictkeyForIcon].activeInHierarchy)
          return;
        this.teamMemberActiveChampion[pickIndex] = this.teamChampionDictionary[championDictkeyForIcon];
        this.teamMemberActiveChampion[pickIndex].SetActive(true);
      }
      else
      {
        string key;
        this.teamMemberActiveChampion[pickIndex] = this.CreateChampionIcon(playerId, champConfig, out key, pickIndex);
        this.teamChampionDictionary[key] = this.teamMemberActiveChampion[pickIndex];
      }
    }
  }

  public void StopAnimationLoop()
  {
    if (this.playGalleryAnimationCoroutine == null)
      return;
    this.StopAllCoroutines();
    this.SetChampSelected();
    this.playGalleryEmote = false;
  }

  public void ShowItem(ItemDefinition item)
  {
    this.HideAll();
    this.StopAnimationLoop();
    switch (item.type)
    {
      case ShopManager.ShopItemType.spray:
        this.ShowSpraytag(item.icon);
        break;
      case ShopManager.ShopItemType.skin:
        if (this.activeChampionInfo != null && this.activeChampionInfo.skin != null && this.activeChampionInfo.skin == item)
          break;
        this.SetActiveChampion(item.champion, item);
        this.SetChampSelected();
        break;
      case ShopManager.ShopItemType.emote:
        this.SetActiveChampion(item.champion, ImiServices.Instance.progressManager.GetEquippedSkinForChampion(item.champion));
        this.StartPlayingAnimationOnRepeat(item.prefab as AnimationClip, 1f);
        break;
      case ShopManager.ShopItemType.victoryPose:
        this.SetActiveChampion(item.champion, ImiServices.Instance.progressManager.GetEquippedSkinForChampion(item.champion));
        this.StartPlayingAnimationOnRepeat(item.prefab as AnimationClip, -0.4f);
        break;
      case ShopManager.ShopItemType.champion:
        if (this.activeChampionInfo != null && !((Object) this.activeChampionInfo.champion != (Object) item.champion))
          break;
        this.SetActiveChampion(item.champion);
        this.SetChampSelected();
        break;
      case ShopManager.ShopItemType.avatarIcon:
        Sprite sprite = Resources.Load<Sprite>(ItemsConfig.avatarHighResIconPath + item.fileName);
        Sprite spraytagSprite = sprite;
        Bounds bounds = sprite.bounds;
        double y = (double) bounds.size.y;
        bounds = sprite.bounds;
        double x = (double) bounds.size.x;
        double num = y / x;
        this.ShowSpraytag(spraytagSprite, (float) num);
        break;
    }
  }

  public void StartPlayingAnimationOnRepeat(AnimationClip anim, float endTimeOffset = 0.0f)
  {
    this.playGalleryAnimationCoroutine = this.PlayGalleryEmote(anim, endTimeOffset);
    this.StartCoroutine(this.playGalleryAnimationCoroutine);
  }

  private GameObject CreateChampion(
    ulong playerId,
    ChampionConfig config,
    GameObject skin,
    out string key,
    int teamMemberSpawnSlot)
  {
    GameObject gameObject = Object.Instantiate<GameObject>(this.championTurntablePrefab, this.teamMemberChampionPositions[teamMemberSpawnSlot]);
    gameObject.GetComponent<TurntableChampionContainer>().CreateChampionFromPrefab(config, skin);
    Animator componentInChildren = gameObject.GetComponentInChildren<Animator>();
    if ((Object) componentInChildren != (Object) null)
      componentInChildren.gameObject.AddComponent<AnimationEventHandler>();
    gameObject.transform.SetToIdentity();
    string championDictkey = this.GetChampionDictkey(teamMemberSpawnSlot, playerId, config, skin.name);
    key = championDictkey;
    gameObject.name = championDictkey;
    return gameObject;
  }

  private GameObject CreateChampionIcon(
    ulong playerId,
    ChampionConfig config,
    out string key,
    int pickIndex)
  {
    GameObject gameObject = Object.Instantiate<GameObject>(config.Champion3DIconPrefab, this.teamMemberChampionPositions[pickIndex]);
    gameObject.transform.SetToIdentity();
    string championDictkeyForIcon = this.GetChampionDictkeyForIcon(pickIndex, playerId, config);
    key = championDictkeyForIcon;
    gameObject.name = championDictkeyForIcon;
    return gameObject;
  }

  public void ShowSpraytag(Sprite spraytagSprite, float heightToWidthRatio = 1f)
  {
    if (this.activeChampionInfo != null && (Object) this.activeChampionInfo.championGameObject != (Object) null)
      this.activeChampionInfo.championGameObject.SetActive(false);
    if (!((Object) this.iconDisplayPlane != (Object) null))
      return;
    this.championTurntablePivot.rotation = Quaternion.Euler(new Vector3(0.0f, 180f, 0.0f));
    this.iconDisplayPlane.SetActive(true);
    SpriteRenderer component = this.iconDisplayPlane.GetComponent<SpriteRenderer>();
    component.sprite = spraytagSprite;
    component.size = new Vector2(this.sprayDisplayScale.x, this.sprayDisplayScale.y * heightToWidthRatio);
  }

  public void HideSpraytagSprite()
  {
    if (this.activeChampionInfo != null && (Object) this.activeChampionInfo.championGameObject != (Object) null)
      this.activeChampionInfo.championGameObject.SetActive(true);
    if (!((Object) this.iconDisplayPlane != (Object) null))
      return;
    this.iconDisplayPlane.SetActive(false);
  }

  public IEnumerator PlayGalleryEmote(AnimationClip anim, float endTimeOffset = 0.0f)
  {
    ChampionTurntableUI championTurntableUi = this;
    championTurntableUi.playGalleryEmote = true;
    float len = anim.length;
    Animator championAnimator = championTurntableUi.activeChampionInfo.championAnimator;
    AnimatorOverrideController overrideController = new AnimatorOverrideController(championAnimator.runtimeAnimatorController);
    List<KeyValuePair<AnimationClip, AnimationClip>> keyValuePairList = new List<KeyValuePair<AnimationClip, AnimationClip>>();
    foreach (AnimationClip animationClip in overrideController.animationClips)
    {
      if (animationClip.name.Contains("emote"))
        keyValuePairList.Add(new KeyValuePair<AnimationClip, AnimationClip>(animationClip, anim));
    }
    overrideController.ApplyOverrides((IList<KeyValuePair<AnimationClip, AnimationClip>>) keyValuePairList);
    championAnimator.runtimeAnimatorController = (RuntimeAnimatorController) overrideController;
    while (championTurntableUi.playGalleryEmote && (Object) championTurntableUi.gameObject != (Object) null && (Object) championAnimator != (Object) null && (Object) championAnimator.gameObject != (Object) null)
    {
      if (championTurntableUi.activeChampionInfo.champion.championType == ChampionType.Mali)
        championAnimator.gameObject.GetComponent<AnimationEventHandler>().SetObjectVisibility("name=spear,show=false");
      championAnimator.SetTrigger("championGalleryEmote");
      yield return (object) new WaitForSeconds(len + endTimeOffset);
    }
  }

  private void SetTeamMemberChampionsInactive(int teamMemberSpawnSlot)
  {
    foreach (Component component in this.teamMemberChampionPositions[teamMemberSpawnSlot])
      component.gameObject.SetActive(false);
  }

  private string GetChampionDictkey(
    int pickSlot,
    ulong playerId,
    ChampionConfig config,
    string skinName)
  {
    return string.Format("{0}_{1}_{2}_{3}", (object) pickSlot, (object) playerId, (object) config.displayName, (object) skinName);
  }

  private string GetChampionDictkeyForIcon(int pickSlot, ulong playerId, ChampionConfig config) => string.Format("{0}_{1}_{2}_Icon", (object) pickSlot, (object) playerId, (object) config.displayName);

  public GameObject GetActiveChampion() => this.activeChampionInfo.championGameObject;

  public enum CameraMode
  {
    FullBody,
    Portrait,
    ChampionGallery,
    None,
  }
}
