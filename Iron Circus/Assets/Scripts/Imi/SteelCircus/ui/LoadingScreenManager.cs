// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.UI.LoadingScreenManager
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Game;
using Rewired;
using SteelCircus.Core.Services;
using SteelCircus.UI;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Imi.SteelCircus.UI
{
  public class LoadingScreenManager : MonoBehaviour
  {
    [Header("Object References")]
    [SerializeField]
    private List<string> loadingTips;
    [SerializeField]
    private float timeToNextTip = 8f;
    [SerializeField]
    private GameObject loadingPanel;
    [SerializeField]
    private Text infoText;
    [SerializeField]
    private TextMeshProUGUI loadingTipTxt;
    [SerializeField]
    private TextMeshProUGUI skipTipTxt;
    [SerializeField]
    private TextMeshProUGUI playersDoneLoadingTxt;
    [SerializeField]
    private Image progressBar;
    [SerializeField]
    private Image buttonIcon;
    [SerializeField]
    private Image loadingScreenBackground;
    [SerializeField]
    private TextMeshProUGUI loadingScreenFactionNameText;
    [SerializeField]
    private GameObject controllerGo;
    [SerializeField]
    private GameObject keyboardGo;
    [SerializeField]
    private RawImage leftPanel;
    [SerializeField]
    private RawImage rightPanel;
    [SerializeField]
    private LoadingScreenConfig[] loadingScreenConfigs;
    private List<IEnumerator> loadingScreenTasks;
    private int completedTasks;
    private Coroutine loadingScreenTipsCoroutine;
    private List<string> loadingTipsPool;

    private void Start()
    {
      this.loadingScreenTasks = new List<IEnumerator>();
      this.completedTasks = 0;
      ImiServices.Instance.LoadingScreenService.OnShowLoadingScreen += new LoadingScreenService.OnShowLoadingScreenEventHandler(this.OnShowLoadingScreen);
      ImiServices.Instance.LoadingScreenService.OnHideLoadingScreen += new LoadingScreenService.OnHideLoadingScreenEventHandler(this.OnHideLoadingScreen);
      ImiServices.Instance.LoadingScreenService.OnAddTaskToLoadingScreen += new LoadingScreenService.OnAddTaskToLoadingScreenEventHandler(this.OnAddTaskToLoadingScreen);
      ImiServices.Instance.LoadingScreenService.OnSetLoadingScreenTaskCompleted += new LoadingScreenService.OnSetLoadingScreenTaskCompletedEventHandler(this.OnSetLoadingScreenTaskCompleted);
      ImiServices.Instance.LoadingScreenService.OnSetSceneLoadedCompleted += new LoadingScreenService.OnSetSceneLoadingCompletedEventHandler(this.StartLoadingScreenSecondaryTasks);
      this.RemoveLoadingTipCoroutine();
      this.AddTipsToPool();
      ReInput.controllers.AddLastActiveControllerChangedDelegate(new ActiveControllerChangedDelegate(this.ControllerChangedDelegate));
      this.ControllerChangedDelegate(ReInput.controllers.GetLastActiveController());
    }

    private void OnDestroy()
    {
      ImiServices.Instance.LoadingScreenService.OnShowLoadingScreen -= new LoadingScreenService.OnShowLoadingScreenEventHandler(this.OnShowLoadingScreen);
      ImiServices.Instance.LoadingScreenService.OnHideLoadingScreen -= new LoadingScreenService.OnHideLoadingScreenEventHandler(this.OnHideLoadingScreen);
      ImiServices.Instance.LoadingScreenService.OnSetSceneLoadedCompleted -= new LoadingScreenService.OnSetSceneLoadingCompletedEventHandler(this.StartLoadingScreenSecondaryTasks);
      if (!ReInput.isReady)
        return;
      ReInput.controllers.RemoveLastActiveControllerChangedDelegate(new ActiveControllerChangedDelegate(this.ControllerChangedDelegate));
    }

    private void ControllerChangedDelegate(Controller controller) => this.buttonIcon.sprite = PromtSwitchResourcesManager.GetAllSpritesForController(controller).ProfileSprite;

    private void AddTipsToPool()
    {
      this.loadingTipsPool = new List<string>();
      this.loadingTipsPool.AddRange((IEnumerable<string>) this.loadingTips);
    }

    private void OnHideLoadingScreen()
    {
      this.loadingScreenTasks = new List<IEnumerator>();
      Log.Debug("Loading Screen: Hide was called.");
      this.RemoveLoadingTipCoroutine();
      this.loadingPanel.SetActive(false);
    }

    private void OnShowLoadingScreen(LoadingScreenService.LoadingScreenIntent intent)
    {
      Log.Debug("Loading Screen: Show was called. Intent: " + (object) intent);
      this.loadingPanel.SetActive(true);
      this.completedTasks = 0;
      this.GetAndApplyRandomLoadingScreen();
      this.loadingScreenTipsCoroutine = this.StartCoroutine(this.LoadingTipCoroutine());
    }

    private void OnAddTaskToLoadingScreen(IEnumerator task) => this.loadingScreenTasks.Add(task);

    private void OnSetLoadingScreenTaskCompleted() => ++this.completedTasks;

    private void StartLoadingScreenSecondaryTasks(string sceneName)
    {
      Log.Debug("Scene " + sceneName + " has been loaded. Starting secondary loading tasks.");
      this.StartCoroutine(this.WaitForLoadingScreenTasks());
    }

    private IEnumerator WaitForLoadingScreenTasks()
    {
      LoadingScreenManager loadingScreenManager = this;
      foreach (IEnumerator loadingScreenTask in loadingScreenManager.loadingScreenTasks)
        loadingScreenManager.StartCoroutine(loadingScreenTask);
      while (loadingScreenManager.completedTasks < loadingScreenManager.loadingScreenTasks.Count)
        yield return (object) null;
      Log.Debug("Loading Screen secondary tasks complete. Hiding Loading screen.");
      ImiServices.Instance.LoadingScreenService.HideLoadingScreen();
    }

    private void GetAndApplyRandomLoadingScreen()
    {
      LoadingScreenConfig loadingScreenOld = LoadingScreenManager.GetRandomLoadingScreenOld(this.loadingScreenConfigs);
      if (!((Object) loadingScreenOld != (Object) null))
        return;
      this.loadingScreenBackground.sprite = loadingScreenOld.loadingScreenTexture;
      this.loadingScreenBackground.preserveAspect = true;
      if (loadingScreenOld.champion.championType == ChampionType.Invalid)
      {
        this.loadingScreenFactionNameText.gameObject.SetActive(false);
      }
      else
      {
        this.loadingScreenFactionNameText.gameObject.SetActive(true);
        this.loadingScreenFactionNameText.text = ImiServices.Instance.LocaService.GetLocalizedValue(loadingScreenOld.champion.faction.factionLocaString).ToUpper();
      }
      this.leftPanel.color = new Color(loadingScreenOld.leftColor.r, loadingScreenOld.leftColor.g, loadingScreenOld.leftColor.b, 1f);
      this.rightPanel.color = new Color(loadingScreenOld.rightColor.r, loadingScreenOld.rightColor.g, loadingScreenOld.rightColor.b, 1f);
    }

    private IEnumerator LoadingTipCoroutine()
    {
      this.DisplayRandomLoadingTip();
      yield return (object) new WaitForSeconds(this.timeToNextTip / 2f);
      yield return (object) new WaitForSeconds(this.timeToNextTip / 2f);
      this.StartNextLoadingTipCoroutine();
    }

    private void DisplayRandomLoadingTip()
    {
      this.skipTipTxt.gameObject.SetActive(false);
      if (this.loadingTipsPool.Count == 0)
        this.AddTipsToPool();
      int index = Random.Range(0, this.loadingTipsPool.Count);
      this.loadingTipTxt.text = ImiServices.Instance.LocaService.GetLocalizedValue(this.loadingTipsPool[index]);
      this.loadingTipsPool.RemoveAt(index);
    }

    private void StartNextLoadingTipCoroutine()
    {
      this.RemoveLoadingTipCoroutine();
      this.loadingScreenTipsCoroutine = this.StartCoroutine(this.LoadingTipCoroutine());
    }

    private void RemoveLoadingTipCoroutine()
    {
      if (this.loadingScreenTipsCoroutine == null)
        return;
      this.StopCoroutine(this.loadingScreenTipsCoroutine);
      this.loadingScreenTipsCoroutine = (Coroutine) null;
    }

    private static LoadingScreenConfig GetRandomLoadingScreenOld(
      LoadingScreenConfig[] loadingScreenConfigs)
    {
      int index = Random.Range(0, loadingScreenConfigs.Length);
      return loadingScreenConfigs[index];
    }
  }
}
