// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.SkillInfo.SkillHud
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SteelCircus.Controls;
using Imi.SteelCircus.Utils;
using SteelCircus.Core.Services;
using System;
using UnityEngine;

namespace SteelCircus.UI.SkillInfo
{
  public class SkillHud : MonoBehaviour
  {
    public static bool UseTeamColorsForSkillUi;
    [SerializeField]
    private bool useTeamColors;
    [SerializeField]
    private SprintSkillUiInstance sprintSkillInstance;
    [SerializeField]
    private TackleDodgeSkillUiInstance tackleDodgeSkillInstance;
    [SerializeField]
    private MainSkillUiInstance primaryMainSkillInstance;
    [SerializeField]
    private MainSkillUiInstance secondaryMainSkillInstance;
    [SerializeField]
    private SkillHudHealthContainerUi healthHud;
    private ButtonSpriteSet sprites;
    private IngameMenu ingameMenu;

    private void Awake() => SkillHud.UseTeamColorsForSkillUi = this.useTeamColors;

    private void Start()
    {
      this.ingameMenu = UnityEngine.Object.FindObjectOfType<IngameMenu>();
      ImiServices.Instance.InputService.lastInputSourceChangedEvent += new Action<InputSource>(this.ControllerChangedDelegate);
      this.SetSprites();
    }

    private void OnDestroy() => ImiServices.Instance.InputService.lastInputSourceChangedEvent -= new Action<InputSource>(this.ControllerChangedDelegate);

    private void ControllerChangedDelegate(InputSource inputSource)
    {
      if (ImiServices.Instance.InputService.IsUsingSteamInput() && this.ingameMenu.IsMenuActive())
        return;
      this.SetSprites();
    }

    private void SetSprites()
    {
      this.sprites = ImiServices.Instance.InputService.GetButtonSprites();
      this.SetButtonSprites(this.sprites.GetButtonSprite(DigitalInput.PrimarySkill), this.sprites.GetButtonSprite(DigitalInput.SecondarySkill), this.sprites.GetButtonSprite(DigitalInput.Tackle));
    }

    public void InitializeChampionSkills(ChampionConfig config)
    {
      UIUtils.InitializeSkillIcon(config.championType, Imi.SharedWithServer.ScEntitas.Components.ButtonType.PrimarySkill, this.primaryMainSkillInstance.SkillIcon);
      UIUtils.InitializeSkillIcon(config.championType, Imi.SharedWithServer.ScEntitas.Components.ButtonType.SecondarySkill, this.secondaryMainSkillInstance.SkillIcon);
    }

    public void SetButtonSprites(Sprite primaryButton, Sprite secondaryButton, Sprite tackleSprite)
    {
      this.tackleDodgeSkillInstance.SetSprite(tackleSprite);
      this.primaryMainSkillInstance.SetSprite(primaryButton);
      this.secondaryMainSkillInstance.SetSprite(secondaryButton);
    }

    public void InitializeChampionHealthPoints(ChampionConfig config, int currentHealth) => this.healthHud.InitializeChampionHealthPoints(config, currentHealth);

    public void SetHealth(int currentHealth, int maxHealth) => this.healthHud.SetHealthUi(currentHealth, maxHealth);

    public void UpdateUi(SkillUiStateData skillData, GameEntity champEntity)
    {
      switch (skillData.buttonType)
      {
        case Imi.SharedWithServer.ScEntitas.Components.ButtonType.Sprint:
          this.sprintSkillInstance.SetUiStateData(skillData, champEntity);
          break;
        case Imi.SharedWithServer.ScEntitas.Components.ButtonType.Tackle:
          this.tackleDodgeSkillInstance.SetUiStateData(skillData);
          break;
        case Imi.SharedWithServer.ScEntitas.Components.ButtonType.PrimarySkill:
          this.primaryMainSkillInstance.SetUiStateData(skillData);
          break;
        case Imi.SharedWithServer.ScEntitas.Components.ButtonType.SecondarySkill:
          this.secondaryMainSkillInstance.SetUiStateData(skillData);
          break;
      }
    }
  }
}
