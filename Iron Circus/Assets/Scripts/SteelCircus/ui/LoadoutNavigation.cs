// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.LoadoutNavigation
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SteelCircus.UI.Menu.ChampionGallery;
using System.Collections;
using UnityEngine;
using UnityEngine.Events;

namespace SteelCircus.UI
{
  public class LoadoutNavigation : MonoBehaviour
  {
    public SubPanelObject navigationPanel;
    public SubPanelObject[] subPanels;
    public SubPanelObject currentPanel;
    [SerializeField]
    private SimplePromptSwitch navigator;

    private void Start()
    {
      this.navigator.goBackToPanelEvent.AddListener(new UnityAction(this.BackToNavigation));
      for (int index = 0; index < this.subPanels.Length; ++index)
        this.subPanels[index].canvasGrp.gameObject.SetActive(false);
    }

    public void ShowNavigationPanel()
    {
      if (!this.gameObject.activeInHierarchy)
        return;
      this.currentPanel = this.navigationPanel;
      this.navigator.SetupNavigatorButtons(SimplePromptSwitch.ButtonFunction.submit, SimplePromptSwitch.ButtonFunction.disabled, SimplePromptSwitch.ButtonFunction.goBackToMenu);
      this.StartCoroutine(this.DelayedShowNavigator());
    }

    public IEnumerator DelayedShowNavigator()
    {
      yield return (object) null;
      this.navigationPanel.gameObject.GetComponent<Animator>().SetTrigger("Show");
    }

    public void BackToNavigation() => this.BackToNavigation(true);

    public void BackToNavigation(bool resetChampionAnimations)
    {
      if (!((Object) MenuController.Instance.currentMenu == (Object) MenuController.Instance.championPage) || !((Object) this.currentPanel != (Object) this.navigationPanel))
        return;
      MenuController.Instance.championPage.GetComponent<ChampionPage>().activeShopItemButton = (ChampionPageButton) null;
      this.navigator.SetupNavigatorButtons(SimplePromptSwitch.ButtonFunction.submit, SimplePromptSwitch.ButtonFunction.disabled, SimplePromptSwitch.ButtonFunction.goBackToMenu);
      MenuController.Instance.championGalleryTurntable.GetComponent<ChampionTurntableUI>().SetActiveChampion(MenuController.Instance.championPage.GetComponent<ChampionDescriptions>().activeChampion);
      if (resetChampionAnimations)
        MenuController.Instance.championGalleryTurntable.GetComponent<ChampionTurntableUI>().SetChampSelected();
      if ((Object) this.currentPanel != (Object) null)
      {
        this.currentPanel.OnExitPanel();
        this.currentPanel.GetComponent<Animator>().SetTrigger("ExitRight");
      }
      this.currentPanel = this.navigationPanel;
      this.currentPanel.OnEnterPanel();
      this.currentPanel.GetComponent<Animator>().SetTrigger("EnterLeft");
    }

    public void EnterSubPanel(int nNewPanel)
    {
      this.navigator.SetupNavigatorButtons(SimplePromptSwitch.ButtonFunction.submit, SimplePromptSwitch.ButtonFunction.disabled, SimplePromptSwitch.ButtonFunction.goBackToPanel);
      this.currentPanel.GetComponent<Animator>().SetTrigger("ExitLeft");
      this.currentPanel.OnExitPanel();
      this.currentPanel = this.subPanels[nNewPanel];
      this.currentPanel.OnEnterPanel();
      this.currentPanel.GetComponent<Animator>().SetTrigger("EnterRight");
    }
  }
}
