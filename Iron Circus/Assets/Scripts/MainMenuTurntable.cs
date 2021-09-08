// Decompiled with JetBrains decompiler
// Type: MainMenuTurntable
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Config;
using Imi.SteelCircus.ScriptableObjects;
using SteelCircus.ScriptableObjects;
using SteelCircus.UI.Menu;
using System;
using System.Collections;
using UnityEngine;

public class MainMenuTurntable : MonoBehaviour
{
  public Camera renderCam;
  public Transform championTurntablePivot;
  [SerializeField]
  private GameObject championTurntablePrefab;
  private ChampionConfig activeChampionConfig;
  [SerializeField]
  private MainMenuTurntableConfig mainMenuTurntableConfig;
  private Animator currentAnimator;
  [SerializeField]
  private GameObject mainMenuLighting;
  private MainMenuLightingConfig lightingConfig;

  private void Start()
  {
    this.StartCoroutine(this.WaitUntilSkinsAreLoaded());
    Resources.Load<MainMenuLightingConfig>("Configs/Visual/MainMenuLightingConfig").ApplyLightingForMainMenu();
  }

  private void OnEnable()
  {
    if ((UnityEngine.Object) this.currentAnimator != (UnityEngine.Object) null)
      this.currentAnimator.SetTrigger("selectedTurntable");
    this.lightingConfig = Resources.Load<MainMenuLightingConfig>("Configs/Visual/MainMenuLightingConfig");
    this.lightingConfig.OnMenuLightingChanged += new MainMenuLightingConfig.OnMenuLightingChangedEventHandler(this.updateLighting);
  }

  public IEnumerator WaitUntilSkinsAreLoaded()
  {
    yield return (object) new WaitUntil(new Func<bool>(SingletonScriptableObject<ItemsConfig>.Instance.AreSkinItemsLoaded));
    this.DisplayRandomChampion();
  }

  private void OnDestroy() => this.lightingConfig.OnMenuLightingChanged -= new MainMenuLightingConfig.OnMenuLightingChangedEventHandler(this.updateLighting);

  public void updateLighting(MainMenuLightingType lightingType)
  {
    if (!((UnityEngine.Object) this.mainMenuLighting != (UnityEngine.Object) null))
      return;
    if (lightingType == MainMenuLightingType.MainMenu)
      this.mainMenuLighting.SetActive(true);
    else
      this.mainMenuLighting.SetActive(false);
  }

  private GameObject CreateChampion(ItemDefinition item)
  {
    GameObject gameObject = UnityEngine.Object.Instantiate<GameObject>(this.championTurntablePrefab, this.championTurntablePivot);
    this.activeChampionConfig = item.champion;
    gameObject.GetComponent<TurntableChampionContainer>().CreateChampionFromPrefab(this.activeChampionConfig, item.prefab as GameObject);
    gameObject.name = this.name;
    return gameObject;
  }

  private void DisplayRandomChampion()
  {
    this.RemoveChampions();
    int index = UnityEngine.Random.Range(0, this.mainMenuTurntableConfig.skinIds.Count);
    ItemDefinition itemByName = SingletonScriptableObject<ItemsConfig>.Instance.GetItemByName(this.mainMenuTurntableConfig.skinIds[index], ShopManager.ShopItemType.skin);
    if (itemByName != null)
    {
      this.currentAnimator = this.CreateChampion(itemByName).GetComponentInChildren<Animator>();
      this.currentAnimator.SetTrigger("selectedTurntable");
      this.SetupCameraForChampion();
      foreach (ObjectTag componentsInChild in this.GetComponentsInChildren<ObjectTag>())
      {
        if (componentsInChild.hideInLobby)
          componentsInChild.gameObject.SetActive(false);
      }
    }
    else
      Log.Error("Skin " + this.mainMenuTurntableConfig.skinIds[index] + " does not exits");
  }

  private void SetupCameraForChampion()
  {
    this.renderCam.transform.localPosition = this.activeChampionConfig.cameraMainMenu.position;
    this.renderCam.transform.localRotation = Quaternion.Euler(this.activeChampionConfig.cameraMainMenu.rotation);
    this.renderCam.focalLength = this.activeChampionConfig.cameraMainMenu.fov;
  }

  private void RemoveChampions()
  {
    for (int index = 0; index < this.championTurntablePivot.childCount; ++index)
      UnityEngine.Object.DestroyImmediate((UnityEngine.Object) this.championTurntablePivot.GetChild(index).gameObject);
  }
}
