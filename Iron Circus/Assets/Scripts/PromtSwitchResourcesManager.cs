// Decompiled with JetBrains decompiler
// Type: PromtSwitchResourcesManager
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Rewired;
using System.Collections.Generic;
using UnityEngine;

public static class PromtSwitchResourcesManager
{
  private static Dictionary<string, ButtonSprites> spriteDictionary;
  private static string lastUsedControllerName = "";

  private static void LoadSprites(Controller controller)
  {
    if (PromtSwitchResourcesManager.spriteDictionary == null)
      PromtSwitchResourcesManager.spriteDictionary = new Dictionary<string, ButtonSprites>();
    if (PromtSwitchResourcesManager.spriteDictionary.ContainsKey(controller.name))
      return;
    Sprite nextSprite = (Sprite) null;
    Sprite previousSprite = (Sprite) null;
    string name = controller.name;
    Sprite confirmSprite;
    Sprite profileSprite;
    Sprite socialSprite;
    Sprite cancelSprite;
    Sprite primarySkillSprite;
    Sprite secondarySkillSprite;
    if (!(name == "Sony DualShock 4"))
    {
      if (!(name == "XInput Gamepad 1"))
      {
        if (!(name == "Nintendo Pro Controller"))
        {
          if (!(name == "Keyboard"))
          {
            if (name == "Mouse")
            {
              confirmSprite = Resources.Load<Sprite>("UI/MenuUI/PC Resources/pc_return_button_ui");
              profileSprite = Resources.Load<Sprite>("UI/MenuUI/PC Resources/pc_p_button_ui");
              socialSprite = Resources.Load<Sprite>("UI/MenuUI/PC Resources/pc_s_button_ui");
              cancelSprite = Resources.Load<Sprite>("UI/MenuUI/PC Resources/pc_escape_button_ui");
              nextSprite = Resources.Load<Sprite>("UI/MenuUI/PC Resources/1x1px_transparent");
              previousSprite = Resources.Load<Sprite>("UI/MenuUI/PC Resources/1x1px_transparent");
              primarySkillSprite = Resources.Load<Sprite>("UI/MenuUI/PS4Alt Resources/Right_Trigger_ui");
              secondarySkillSprite = Resources.Load<Sprite>("UI/MenuUI/PS4Alt Resources/Left_Trigger_ui");
            }
            else
            {
              confirmSprite = Resources.Load<Sprite>("UI/MenuUI/XBox Resources/XBox_confirm_button_ui");
              profileSprite = Resources.Load<Sprite>("UI/MenuUI/XBox Resources/XBox_profile_button_ui");
              socialSprite = Resources.Load<Sprite>("UI/MenuUI/XBox Resources/XBox_social_button_ui");
              cancelSprite = Resources.Load<Sprite>("UI/MenuUI/XBox Resources/XBox_back_button_ui");
              nextSprite = Resources.Load<Sprite>("UI/MenuUI/XBox Resources/1x1px_transparent");
              previousSprite = Resources.Load<Sprite>("UI/MenuUI/XBox Resources/1x1px_transparent");
              primarySkillSprite = Resources.Load<Sprite>("UI/MenuUI/PS4Alt Resources/Right_Trigger_ui");
              secondarySkillSprite = Resources.Load<Sprite>("UI/MenuUI/PS4Alt Resources/Left_Trigger_ui");
            }
          }
          else
          {
            confirmSprite = Resources.Load<Sprite>("UI/MenuUI/PC Resources/pc_return_button_ui");
            profileSprite = Resources.Load<Sprite>("UI/MenuUI/PC Resources/pc_p_button_ui");
            socialSprite = Resources.Load<Sprite>("UI/MenuUI/PC Resources/pc_s_button_ui");
            cancelSprite = Resources.Load<Sprite>("UI/MenuUI/PC Resources/pc_escape_button_ui");
            nextSprite = Resources.Load<Sprite>("UI/MenuUI/PC Resources/1x1px_transparent");
            previousSprite = Resources.Load<Sprite>("UI/MenuUI/PC Resources/1x1px_transparent");
            primarySkillSprite = Resources.Load<Sprite>("UI/MenuUI/PS4Alt Resources/Right_Trigger_ui");
            secondarySkillSprite = Resources.Load<Sprite>("UI/MenuUI/PS4Alt Resources/Left_Trigger_ui");
          }
        }
        else
        {
          confirmSprite = Resources.Load<Sprite>("UI/MenuUI/XBox Resources/XBox_back_button_ui");
          profileSprite = Resources.Load<Sprite>("UI/MenuUI/XBox Resources/XBox_social_button_ui");
          socialSprite = Resources.Load<Sprite>("UI/MenuUI/XBox Resources/XBox_profile_button_ui");
          cancelSprite = Resources.Load<Sprite>("UI/MenuUI/XBox Resources/XBox_confirm_button_ui");
          nextSprite = Resources.Load<Sprite>("UI/MenuUI/XBox Resources/1x1px_transparent");
          previousSprite = Resources.Load<Sprite>("UI/MenuUI/XBox Resources/1x1px_transparent");
          primarySkillSprite = Resources.Load<Sprite>("UI/MenuUI/PS4Alt Resources/Right_Trigger_ui");
          secondarySkillSprite = Resources.Load<Sprite>("UI/MenuUI/PS4Alt Resources/Left_Trigger_ui");
        }
      }
      else
      {
        confirmSprite = Resources.Load<Sprite>("UI/MenuUI/XBox Resources/XBox_confirm_button_ui");
        profileSprite = Resources.Load<Sprite>("UI/MenuUI/XBox Resources/XBox_profile_button_ui");
        socialSprite = Resources.Load<Sprite>("UI/MenuUI/XBox Resources/XBox_social_button_ui");
        cancelSprite = Resources.Load<Sprite>("UI/MenuUI/XBox Resources/XBox_back_button_ui");
        nextSprite = Resources.Load<Sprite>("UI/MenuUI/XBox Resources/1x1px_transparent");
        previousSprite = Resources.Load<Sprite>("UI/MenuUI/XBox Resources/1x1px_transparent");
        primarySkillSprite = Resources.Load<Sprite>("UI/MenuUI/PS4Alt Resources/Right_Trigger_ui");
        secondarySkillSprite = Resources.Load<Sprite>("UI/MenuUI/PS4Alt Resources/Left_Trigger_ui");
      }
    }
    else
    {
      confirmSprite = Resources.Load<Sprite>("UI/MenuUI/PS4Alt Resources/PS4_confirm_button_ui");
      profileSprite = Resources.Load<Sprite>("UI/MenuUI/PS4Alt Resources/PS4_shortcut_button_ui");
      socialSprite = Resources.Load<Sprite>("UI/MenuUI/PS4Alt Resources/PS4_leave_button_ui");
      cancelSprite = Resources.Load<Sprite>("UI/MenuUI/PS4Alt Resources/PS4_back_button_ui");
      primarySkillSprite = Resources.Load<Sprite>("UI/MenuUI/PS4Alt Resources/Right_Trigger_ui");
      secondarySkillSprite = Resources.Load<Sprite>("UI/MenuUI/PS4Alt Resources/Left_Trigger_ui");
    }
    ButtonSprites buttonSprites = new ButtonSprites(controller.type, controller.name, confirmSprite, profileSprite, socialSprite, cancelSprite, nextSprite, previousSprite, primarySkillSprite, secondarySkillSprite);
    PromtSwitchResourcesManager.spriteDictionary.Add(controller.name, buttonSprites);
  }

  private static void LoadDefaultSprites()
  {
    if (PromtSwitchResourcesManager.spriteDictionary == null)
      PromtSwitchResourcesManager.spriteDictionary = new Dictionary<string, ButtonSprites>();
    if (PromtSwitchResourcesManager.spriteDictionary.ContainsKey("Sony DualShock 4"))
      return;
    Sprite nextSprite = (Sprite) null;
    Sprite previousSprite = (Sprite) null;
    Sprite confirmSprite = Resources.Load<Sprite>("UI/MenuUI/PS4Alt Resources/PS4_confirm_button_ui");
    Sprite profileSprite = Resources.Load<Sprite>("UI/MenuUI/PS4Alt Resources/PS4_shortcut_button_ui");
    Sprite socialSprite = Resources.Load<Sprite>("UI/MenuUI/PS4Alt Resources/PS4_leave_button_ui");
    Sprite cancelSprite = Resources.Load<Sprite>("UI/MenuUI/PS4Alt Resources/PS4_back_button_ui");
    Sprite primarySkillSprite = Resources.Load<Sprite>("UI/MenuUI/PS4Alt Resources/Right_Trigger_ui");
    Sprite secondarySkillSprite = Resources.Load<Sprite>("UI/MenuUI/PS4Alt Resources/Left_Trigger_ui");
    ButtonSprites buttonSprites = new ButtonSprites(ControllerType.Joystick, "Sony DualShock 4", confirmSprite, profileSprite, socialSprite, cancelSprite, nextSprite, previousSprite, primarySkillSprite, secondarySkillSprite);
    PromtSwitchResourcesManager.spriteDictionary.Add("Sony DualShock 4", buttonSprites);
  }

  public static Sprite GetSpriteForControllerButton(
    Controller controller,
    PromtSwitchResourcesManager.ButtonType button)
  {
    ButtonSprites spritesForController = PromtSwitchResourcesManager.GetAllSpritesForController(controller);
    switch (button)
    {
      case PromtSwitchResourcesManager.ButtonType.Confirm:
        return spritesForController.ConfirmSprite;
      case PromtSwitchResourcesManager.ButtonType.Cancel:
        return spritesForController.CancelSprite;
      case PromtSwitchResourcesManager.ButtonType.Profile:
        return spritesForController.ProfileSprite;
      case PromtSwitchResourcesManager.ButtonType.Social:
        return spritesForController.SocialSprite;
      case PromtSwitchResourcesManager.ButtonType.Next:
        return spritesForController.NextSprite;
      case PromtSwitchResourcesManager.ButtonType.Previous:
        return spritesForController.PreviousSprite;
      default:
        Log.Error("Could not find controller button specified. Returning confirm button sprite.");
        return spritesForController.ConfirmSprite;
    }
  }

  public static ButtonSprites GetAllSpritesForController(Controller controller)
  {
    switch (controller.type)
    {
      case ControllerType.Keyboard:
        if (!string.IsNullOrEmpty(PromtSwitchResourcesManager.lastUsedControllerName))
          return PromtSwitchResourcesManager.spriteDictionary[PromtSwitchResourcesManager.lastUsedControllerName];
        PromtSwitchResourcesManager.LoadDefaultSprites();
        return PromtSwitchResourcesManager.spriteDictionary["Sony DualShock 4"];
      case ControllerType.Mouse:
        if (!string.IsNullOrEmpty(PromtSwitchResourcesManager.lastUsedControllerName))
          return PromtSwitchResourcesManager.spriteDictionary[PromtSwitchResourcesManager.lastUsedControllerName];
        PromtSwitchResourcesManager.LoadDefaultSprites();
        return PromtSwitchResourcesManager.spriteDictionary["Sony DualShock 4"];
      case ControllerType.Joystick:
        PromtSwitchResourcesManager.LoadSprites(controller);
        PromtSwitchResourcesManager.lastUsedControllerName = controller.name;
        return PromtSwitchResourcesManager.spriteDictionary[controller.name];
      case ControllerType.Custom:
        PromtSwitchResourcesManager.LoadSprites(controller);
        PromtSwitchResourcesManager.lastUsedControllerName = controller.name;
        return PromtSwitchResourcesManager.spriteDictionary[controller.name];
      default:
        return (ButtonSprites) null;
    }
  }

  public static Sprite GetSpriteForController(
    Controller controller,
    PromtSwitchResourcesManager.ButtonType btn)
  {
    PromtSwitchResourcesManager.LoadSprites(controller);
    switch (btn)
    {
      case PromtSwitchResourcesManager.ButtonType.Confirm:
        return PromtSwitchResourcesManager.spriteDictionary[controller.name].ConfirmSprite;
      case PromtSwitchResourcesManager.ButtonType.Cancel:
        return PromtSwitchResourcesManager.spriteDictionary[controller.name].CancelSprite;
      case PromtSwitchResourcesManager.ButtonType.Profile:
        return PromtSwitchResourcesManager.spriteDictionary[controller.name].ProfileSprite;
      case PromtSwitchResourcesManager.ButtonType.Social:
        return PromtSwitchResourcesManager.spriteDictionary[controller.name].SocialSprite;
      case PromtSwitchResourcesManager.ButtonType.Next:
        return PromtSwitchResourcesManager.spriteDictionary[controller.name].NextSprite;
      case PromtSwitchResourcesManager.ButtonType.Previous:
        return PromtSwitchResourcesManager.spriteDictionary[controller.name].PreviousSprite;
      default:
        return (Sprite) null;
    }
  }

  public enum ButtonType
  {
    Confirm,
    Cancel,
    Profile,
    Social,
    Next,
    Previous,
  }
}
