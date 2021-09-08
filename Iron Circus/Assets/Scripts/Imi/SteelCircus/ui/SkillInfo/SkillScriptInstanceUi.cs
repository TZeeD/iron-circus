// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.UI.SkillInfo.SkillScriptInstanceUi
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SteelCircus.Core;
using UnityEngine;
using UnityEngine.UI;

namespace Imi.SteelCircus.UI.SkillInfo
{
  public class SkillScriptInstanceUi : MonoBehaviour
  {
    public Image chargeIndicator;
    public Image skillIcon;
    public Sprite throwButtonSprite;
    public Sprite tackleButtonSprite;
    public Sprite sprintButtonSprite;
    public Sprite primaryButtonSprite;
    public Sprite secondaryButtonSprite;
    public Image buttonImage;
    public Sprite[] sourceSprites;
    protected Color readyColor;
    protected Color notReadyColor;
    private PlayerSkillState currentState;
    private GameEntity stateDataEntity;
    protected Animation readyAnimation;
    private SkillUiStateData stateData;
    private bool wasUseable = true;

    public void Init(SkillUiStateData stateData, Team team)
    {
      switch (stateData.buttonType)
      {
        case Imi.SharedWithServer.ScEntitas.Components.ButtonType.Sprint:
          this.buttonImage.sprite = this.sprintButtonSprite;
          break;
        case Imi.SharedWithServer.ScEntitas.Components.ButtonType.Tackle:
          this.buttonImage.sprite = this.tackleButtonSprite;
          break;
        case Imi.SharedWithServer.ScEntitas.Components.ButtonType.PrimarySkill:
          this.buttonImage.sprite = this.primaryButtonSprite;
          break;
        case Imi.SharedWithServer.ScEntitas.Components.ButtonType.SecondarySkill:
          this.buttonImage.sprite = this.secondaryButtonSprite;
          break;
        case Imi.SharedWithServer.ScEntitas.Components.ButtonType.ThrowBall:
          this.buttonImage.sprite = this.throwButtonSprite;
          break;
      }
      this.readyAnimation = this.GetComponent<Animation>();
      this.readyColor = StartupSetup.Colors.LightColor(team);
      this.notReadyColor = StartupSetup.Colors.DarkColor(team);
      this.chargeIndicator.type = Image.Type.Filled;
      this.chargeIndicator.fillMethod = Image.FillMethod.Vertical;
      this.chargeIndicator.color = this.readyColor;
      Sprite sprite = (Sprite) null;
      foreach (Sprite sourceSprite in this.sourceSprites)
      {
        if (sourceSprite.name == stateData.iconName)
        {
          sprite = sourceSprite;
          break;
        }
      }
      if ((Object) sprite != (Object) null)
      {
        this.chargeIndicator.sprite = sprite;
        this.skillIcon.sprite = sprite;
      }
      else
        Log.Error(string.Format("No skill icon found in list with name {0} {1}", (object) stateData.iconName, (object) this.gameObject));
    }

    private void Update() => this.chargeIndicator.fillAmount = this.stateData.fillAmount;

    public void SetUiStateData(SkillUiStateData newStateData) => this.stateData = newStateData;

    protected void SetUseable(bool useable)
    {
      if (this.wasUseable == useable)
        return;
      this.wasUseable = useable;
      this.chargeIndicator.color = useable ? this.readyColor : this.notReadyColor;
      if (!useable)
        return;
      this.OnUseable();
    }

    private void OnUseable() => this.readyAnimation.Play();
  }
}
