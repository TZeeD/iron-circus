// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.SubPanelNavigation
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.Controls;
using SteelCircus.Core.Services;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace SteelCircus.UI
{
  [RequireComponent(typeof (MenuObject))]
  public class SubPanelNavigation : MonoBehaviour
  {
    [SerializeField]
    private GameObject navigationBarButtonPrefab;
    [SerializeField]
    private GameObject navigationBarButtonParent;
    private InputService input;
    public int currentPanel;
    private int previousPanel;
    [HideInInspector]
    public SubPanelObjectData[] menuPanels;
    [HideInInspector]
    public List<SubPanelObjectData> visibleMenuPanels;
    public GameObject navigatorBarScrollRect;
    public int startPanelNumber;

    private void Awake()
    {
      this.input = ImiServices.Instance.InputService;
      this.visibleMenuPanels = new List<SubPanelObjectData>();
      if (!((Object) this.GetComponent<ShopManager>() != (Object) null))
        return;
      this.menuPanels[0].isHighlighted = true;
    }

    private void Start() => MenuController.Instance.EnteredMenuEvent.AddListener(new UnityAction(this.OnPageEntered));

    private void Destroy() => MenuController.Instance.EnteredMenuEvent.RemoveListener(new UnityAction(this.OnPageEntered));

    public void OnPageEntered()
    {
      if (!((Object) MenuController.Instance.currentMenu == (Object) this.GetComponent<MenuObject>()))
        return;
      this.NavigationSetup();
    }

    public void NavigationSetup(bool showStartPanel = true)
    {
      this.GenerateButtons();
      this.HideAllPanels();
      if (!showStartPanel)
        return;
      this.ShowStartPanel();
    }

    public SubPanelObject GetCurrentSubPanelObject() => this.visibleMenuPanels != null && this.currentPanel >= 0 && this.currentPanel < this.visibleMenuPanels.Count ? this.visibleMenuPanels[this.currentPanel].panel : (SubPanelObject) null;

    public SubPanelObject GetPreviousSubPanelObject() => this.visibleMenuPanels != null && this.previousPanel >= 0 && this.previousPanel < this.visibleMenuPanels.Count ? this.visibleMenuPanels[this.previousPanel].panel : (SubPanelObject) null;

    public int GetIndexOfSubPanel(SubPanelObject panel)
    {
      for (int index = 0; index < this.menuPanels.Length; ++index)
      {
        if ((Object) this.menuPanels[index].panel == (Object) panel)
          return index;
      }
      return -1;
    }

    private void ClearButtons()
    {
      foreach (SubPanelObjectData visibleMenuPanel in this.visibleMenuPanels)
        visibleMenuPanel.navigatorButton = (GameObject) null;
      foreach (Component component in this.navigationBarButtonParent.transform)
        Object.Destroy((Object) component.gameObject);
    }

    public void GenerateButtons()
    {
      this.ClearButtons();
      this.HideAllPanels();
      this.visibleMenuPanels = new List<SubPanelObjectData>();
      int num1 = 0;
      foreach (SubPanelObjectData menuPanel in this.menuPanels)
      {
        if (menuPanel.isVisible)
          this.visibleMenuPanels.Add(menuPanel);
      }
      RectTransform component1 = this.navigationBarButtonParent.GetComponent<RectTransform>();
      Rect rect1 = this.GetComponent<RectTransform>().rect;
      RectTransform component2 = this.navigatorBarScrollRect.GetComponent<RectTransform>();
      Rect rect2 = component1.rect;
      double num2 = (double) rect2.width / (double) this.visibleMenuPanels.Count + 16.0;
      rect2 = component1.rect;
      double num3 = (double) rect2.height * 1.04999995231628;
      Vector2 vector2_1 = new Vector2((float) num2, (float) num3);
      component2.sizeDelta = vector2_1;
      foreach (SubPanelObjectData visibleMenuPanel in this.visibleMenuPanels)
      {
        GameObject gameObject = Object.Instantiate<GameObject>(this.navigationBarButtonPrefab, this.navigationBarButtonParent.transform);
        gameObject.name = visibleMenuPanel.panel.name;
        gameObject.GetComponentInChildren<TextMeshProUGUI>().text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + visibleMenuPanel.panel.panelName);
        RectTransform component3 = gameObject.GetComponent<RectTransform>();
        rect2 = component1.rect;
        double num4 = (double) rect2.width / (double) this.visibleMenuPanels.Count;
        rect2 = component1.rect;
        double height = (double) rect2.height;
        Vector2 vector2_2 = new Vector2((float) num4, (float) height);
        component3.sizeDelta = vector2_2;
        int tempPanelIndex = num1;
        Button componentInChildren = gameObject.GetComponentInChildren<Button>();
        componentInChildren.interactable = visibleMenuPanel.isActive;
        componentInChildren.onClick.AddListener((UnityAction) (() => this.SwitchToPanel(tempPanelIndex)));
        visibleMenuPanel.navigatorButton = componentInChildren.gameObject;
        if ((Object) gameObject.transform.GetComponentInChildren<Image>() != (Object) null)
          gameObject.transform.GetComponentInChildren<Image>().gameObject.SetActive(visibleMenuPanel.isHighlighted);
        visibleMenuPanel.panel.panelManager = this;
        ++num1;
      }
    }

    public IEnumerator Test(Sprite sprite)
    {
      yield return (object) null;
      this.navigatorBarScrollRect.GetComponent<Image>().sprite = sprite;
    }

    public void SetCurrentPanelBold()
    {
      foreach (SubPanelObjectData visibleMenuPanel in this.visibleMenuPanels)
      {
        if (visibleMenuPanel.isVisible)
        {
          if (visibleMenuPanel.isActive)
          {
            if (visibleMenuPanel.isHighlighted)
            {
              visibleMenuPanel.navigatorButton.GetComponentInChildren<TextMeshProUGUI>().color = new Color(0.75f, 0.95f, 1f, 1f);
              visibleMenuPanel.navigatorButton.GetComponentInChildren<TextMeshProUGUI>().fontStyle = FontStyles.Bold | FontStyles.UpperCase;
            }
            else
            {
              visibleMenuPanel.navigatorButton.GetComponentInChildren<TextMeshProUGUI>().color = new Color(1f, 1f, 1f, 1f);
              visibleMenuPanel.navigatorButton.GetComponentInChildren<TextMeshProUGUI>().fontStyle = FontStyles.UpperCase;
            }
          }
          else
          {
            visibleMenuPanel.navigatorButton.GetComponentInChildren<TextMeshProUGUI>().color = new Color(0.5f, 0.5f, 0.5f, 0.5f);
            visibleMenuPanel.navigatorButton.GetComponentInChildren<TextMeshProUGUI>().fontStyle = FontStyles.UpperCase;
          }
        }
      }
      this.visibleMenuPanels[this.currentPanel].navigatorButton.GetComponentInChildren<TextMeshProUGUI>().color = new Color(0.15f, 0.15f, 0.15f, 1f);
      this.visibleMenuPanels[this.currentPanel].navigatorButton.GetComponentInChildren<TextMeshProUGUI>().fontStyle = FontStyles.Bold | FontStyles.UpperCase;
    }

    public void SetScrollRectToCurrentPanel()
    {
      if (!((Object) this.navigatorBarScrollRect != (Object) null))
        return;
      this.navigatorBarScrollRect.GetComponent<RectTransform>().position = (Vector3) new Vector2(this.visibleMenuPanels[this.currentPanel].navigatorButton.GetComponent<RectTransform>().position.x, this.navigatorBarScrollRect.GetComponent<RectTransform>().position.y);
    }

    public void HideAllPanels()
    {
      for (int index = 0; index < this.menuPanels.Length; ++index)
      {
        if ((Object) this.menuPanels[index].panel.canvasGrp != (Object) null)
          this.menuPanels[index].panel.ExitPanel(MenuObject.animationType.changeInstantly);
      }
    }

    public void ShowStartPanel() => this.SetStartPanel(this.startPanelNumber);

    private void Update()
    {
      if (!((Object) MenuController.Instance.currentMenu == (Object) this.gameObject.GetComponent<MenuObject>()))
        return;
      if (this.input.GetButtonDown(DigitalInput.UIPrevious))
      {
        this.PreviousPanel();
      }
      else
      {
        if (!this.input.GetButtonDown(DigitalInput.UINext))
          return;
        this.NextPanel();
      }
    }

    public void OnExitCurrentPanel() => this.visibleMenuPanels[this.currentPanel].panel.OnExitPanel(true);

    private void NextPanel()
    {
      if (!this.visibleMenuPanels[this.currentPanel].panel.IsAllowedToExit())
        return;
      int currentPanel = this.currentPanel;
      int num = 0;
      this.previousPanel = this.currentPanel;
      while (num++ <= 50)
      {
        this.currentPanel = ++this.currentPanel % this.visibleMenuPanels.Count;
        if (this.visibleMenuPanels[this.currentPanel].isActive && this.visibleMenuPanels[this.currentPanel].isVisible)
          break;
      }
      if (this.currentPanel == currentPanel)
        return;
      this.visibleMenuPanels[currentPanel].panel.ExitPanel(MenuObject.animationType.swipeToLeft);
      this.visibleMenuPanels[this.currentPanel].panel.EnterPanel(MenuObject.animationType.swipeToLeft);
      this.SetScrollRectToCurrentPanel();
      this.SetCurrentPanelBold();
    }

    private void PreviousPanel()
    {
      if (!this.visibleMenuPanels[this.currentPanel].panel.IsAllowedToExit())
        return;
      int currentPanel = this.currentPanel;
      do
      {
        this.currentPanel = --this.currentPanel;
        if (this.currentPanel < 0)
          this.currentPanel = this.visibleMenuPanels.Count - 1;
      }
      while (!this.visibleMenuPanels[this.currentPanel].isActive || !this.visibleMenuPanels[this.currentPanel].isVisible);
      if (this.currentPanel == currentPanel)
        return;
      this.visibleMenuPanels[currentPanel].panel.ExitPanel(MenuObject.animationType.swipeToRight);
      this.visibleMenuPanels[this.currentPanel].panel.EnterPanel(MenuObject.animationType.swipeToRight);
      this.SetScrollRectToCurrentPanel();
      this.SetCurrentPanelBold();
    }

    public void SwitchToPanel(int nPanel)
    {
      if (!this.visibleMenuPanels[this.currentPanel].panel.IsAllowedToExit())
        return;
      this.previousPanel = this.currentPanel;
      if (nPanel > this.currentPanel)
      {
        this.visibleMenuPanels[this.currentPanel].panel.ExitPanel(MenuObject.animationType.swipeToLeft);
        this.currentPanel = nPanel;
        if (this.currentPanel < 0 || this.currentPanel >= this.menuPanels.Length)
          this.currentPanel = 0;
        this.visibleMenuPanels[this.currentPanel].panel.EnterPanel(MenuObject.animationType.swipeToLeft);
      }
      else if (nPanel < this.currentPanel)
      {
        this.visibleMenuPanels[this.currentPanel].panel.ExitPanel(MenuObject.animationType.swipeToRight);
        this.currentPanel = nPanel;
        if (this.currentPanel < 0 || this.currentPanel >= this.menuPanels.Length)
          this.currentPanel = 0;
        this.visibleMenuPanels[this.currentPanel].panel.EnterPanel(MenuObject.animationType.swipeToRight);
      }
      this.SetScrollRectToCurrentPanel();
      this.SetCurrentPanelBold();
    }

    private void SetStartPanel(int panelNr)
    {
      this.previousPanel = this.currentPanel;
      this.visibleMenuPanels[this.currentPanel].panel.ExitPanel(MenuObject.animationType.changeInstantly);
      this.currentPanel = panelNr;
      if (this.visibleMenuPanels.Count < 1)
        return;
      this.StartCoroutine(this.DelayedShowPanel());
    }

    public IEnumerator DelayedShowPanel()
    {
      yield return (object) null;
      this.SetScrollRectToCurrentPanel();
      this.SetCurrentPanelBold();
      this.visibleMenuPanels[this.currentPanel].panel.EnterPanel(MenuObject.animationType.changeInstantly);
    }
  }
}
