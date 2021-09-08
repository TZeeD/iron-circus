// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.LoadingScreenService
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections;

namespace SteelCircus.UI
{
  public class LoadingScreenService
  {
    public event LoadingScreenService.OnShowLoadingScreenEventHandler OnShowLoadingScreen;

    public event LoadingScreenService.OnHideLoadingScreenEventHandler OnHideLoadingScreen;

    public event LoadingScreenService.OnAddTaskToLoadingScreenEventHandler OnAddTaskToLoadingScreen;

    public event LoadingScreenService.OnSetLoadingScreenTaskCompletedEventHandler OnSetLoadingScreenTaskCompleted;

    public event LoadingScreenService.OnSetSceneLoadingCompletedEventHandler OnSetSceneLoadedCompleted;

    public void ShowLoadingScreen(LoadingScreenService.LoadingScreenIntent intent)
    {
      LoadingScreenService.OnShowLoadingScreenEventHandler showLoadingScreen = this.OnShowLoadingScreen;
      if (showLoadingScreen == null)
        return;
      showLoadingScreen(intent);
    }

    public void AddTaskToLoadingScreen(IEnumerator task)
    {
      LoadingScreenService.OnAddTaskToLoadingScreenEventHandler taskToLoadingScreen = this.OnAddTaskToLoadingScreen;
      if (taskToLoadingScreen == null)
        return;
      taskToLoadingScreen(task);
    }

    public void SetLoadingScreenTaskCompleted()
    {
      LoadingScreenService.OnSetLoadingScreenTaskCompletedEventHandler screenTaskCompleted = this.OnSetLoadingScreenTaskCompleted;
      if (screenTaskCompleted == null)
        return;
      screenTaskCompleted();
    }

    public void SetSceneLoadingComplete(string sceneName)
    {
      LoadingScreenService.OnSetSceneLoadingCompletedEventHandler sceneLoadedCompleted = this.OnSetSceneLoadedCompleted;
      if (sceneLoadedCompleted == null)
        return;
      sceneLoadedCompleted(sceneName);
    }

    public void HideLoadingScreen()
    {
      LoadingScreenService.OnHideLoadingScreenEventHandler hideLoadingScreen = this.OnHideLoadingScreen;
      if (hideLoadingScreen == null)
        return;
      hideLoadingScreen();
    }

    public delegate void OnShowLoadingScreenEventHandler(
      LoadingScreenService.LoadingScreenIntent intent);

    public delegate void OnHideLoadingScreenEventHandler();

    public delegate void OnAddTaskToLoadingScreenEventHandler(IEnumerator task);

    public delegate void OnSetLoadingScreenTaskCompletedEventHandler();

    public delegate void OnSetSceneLoadingCompletedEventHandler(string sceneName);

    public enum LoadingScreenIntent
    {
      loadingLobby,
      loadingMainMenu,
    }
  }
}
