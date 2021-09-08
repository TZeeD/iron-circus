// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Controls.InputStructures
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.ScEntitas.Components;
using System.Collections.Generic;
using UnityEngine;

namespace Imi.SteelCircus.Controls
{
  public class InputStructures
  {
    private static Dictionary<DigitalInput, string> buttonActionNames = new Dictionary<DigitalInput, string>()
    {
      {
        DigitalInput.None,
        ""
      },
      {
        DigitalInput.Sprint,
        "Boost"
      },
      {
        DigitalInput.Tackle,
        "Tackle"
      },
      {
        DigitalInput.PrimarySkill,
        "Skill1"
      },
      {
        DigitalInput.SecondarySkill,
        "Skill2"
      },
      {
        DigitalInput.ThrowBall,
        "ChargeThrow"
      },
      {
        DigitalInput.Ping,
        "Ping"
      },
      {
        DigitalInput.Emote0,
        "Emote0"
      },
      {
        DigitalInput.Emote1,
        "Emote1"
      },
      {
        DigitalInput.Emote2,
        "Emote2"
      },
      {
        DigitalInput.Emote3,
        "Emote3"
      },
      {
        DigitalInput.Spraytag0,
        "Spraytag0"
      },
      {
        DigitalInput.Spraytag1,
        "Spraytag1"
      },
      {
        DigitalInput.Spraytag2,
        "Spraytag2"
      },
      {
        DigitalInput.Spraytag3,
        "Spraytag3"
      },
      {
        DigitalInput.QuickMessage0,
        "QuickMessage0"
      },
      {
        DigitalInput.QuickMessage1,
        "QuickMessage1"
      },
      {
        DigitalInput.QuickMessage2,
        "QuickMessage2"
      },
      {
        DigitalInput.QuickMessage3,
        "QuickMessage3"
      },
      {
        DigitalInput.EmoteModifier,
        "EmoteModifier"
      },
      {
        DigitalInput.SpraytagModifier,
        "SpraytagModifier"
      },
      {
        DigitalInput.QuickMessageModifier,
        "QuickMessageModifier"
      },
      {
        DigitalInput.MoveToBall,
        "MoveToBall"
      },
      {
        DigitalInput.Surrender,
        "Surrender"
      },
      {
        DigitalInput.Menu,
        "Menu"
      },
      {
        DigitalInput.MouseMove,
        "MouseMove"
      },
      {
        DigitalInput.UICancel,
        "UICancel"
      },
      {
        DigitalInput.UIMatchMakingLeave,
        "UIMatchMakingLeave"
      },
      {
        DigitalInput.UIShortcut,
        "UIShortcut"
      },
      {
        DigitalInput.UISubmit,
        "UISubmit"
      },
      {
        DigitalInput.UIModifier,
        "UIModifier"
      },
      {
        DigitalInput.UIMenu,
        "UIMenu"
      },
      {
        DigitalInput.UIPrevious,
        "UIPrevious"
      },
      {
        DigitalInput.UINext,
        "UINext"
      },
      {
        DigitalInput.UILeftTrigger,
        "UILeftTrigger"
      },
      {
        DigitalInput.UIRightTrigger,
        "UIRightTrigger"
      },
      {
        DigitalInput.UIUp,
        "UIUp"
      },
      {
        DigitalInput.UIDown,
        "UIDown"
      },
      {
        DigitalInput.UILeft,
        "UILeft"
      },
      {
        DigitalInput.UIRight,
        "UIRight"
      },
      {
        DigitalInput.UIHorizontal,
        "UIHorizontal"
      },
      {
        DigitalInput.UIVertical,
        "UIVertical"
      },
      {
        DigitalInput.MouseHorizontal,
        "MouseHorizontal"
      },
      {
        DigitalInput.MouseVertical,
        "MouseVertical"
      },
      {
        DigitalInput.VoiceMute,
        "VoiceChatMute"
      },
      {
        DigitalInput.VoicePushToTalk,
        "VoiceChatPushToTalk"
      },
      {
        DigitalInput.UIVoicePushToTalk,
        "UIVoiceChatPushToTalk"
      },
      {
        DigitalInput.UIVoiceMute,
        "UIVoiceMute"
      },
      {
        DigitalInput.FreeroamCButton,
        "CButton"
      },
      {
        DigitalInput.FreeroamSButton,
        "SButton"
      },
      {
        DigitalInput.FreeroamTButton,
        "TButton"
      },
      {
        DigitalInput.FreeroamXButotn,
        "XButton"
      },
      {
        DigitalInput.FreeroamDPadDown,
        "DPadDownButton"
      },
      {
        DigitalInput.FreeroamDPadUp,
        "DPadUpButton"
      },
      {
        DigitalInput.FreeroamDPadLeft,
        "DPadLeftButton"
      },
      {
        DigitalInput.FreeroamDPadRight,
        "DPadRightButton"
      },
      {
        DigitalInput.FreeroamLeftTrigger1,
        "LeftTrigger1"
      },
      {
        DigitalInput.FreeroamLeftTrigger2,
        "LeftTrigger2"
      },
      {
        DigitalInput.FreeroamRightTrigger1,
        "RightTrigger1"
      },
      {
        DigitalInput.FreeroamRightTrigger2,
        "RightTrigger2"
      },
      {
        DigitalInput.FreeroamRightJoystickButton,
        "RightJoystickButton"
      }
    };
    private static Dictionary<AnalogInput, string> analogActionNames = new Dictionary<AnalogInput, string>()
    {
      {
        AnalogInput.None,
        ""
      },
      {
        AnalogInput.Aim,
        "Aim"
      },
      {
        AnalogInput.Move,
        "Move"
      },
      {
        AnalogInput.UISecondaryScroll,
        "UISecondaryScroll"
      },
      {
        AnalogInput.UIScroll,
        "UIScroll"
      },
      {
        AnalogInput.FreeroamLeftStick,
        "LeftStick"
      },
      {
        AnalogInput.FreeroamRightStick,
        "RightStick"
      }
    };
    private static Dictionary<DigitalInput, ButtonType> buttonNetworkedTypes = new Dictionary<DigitalInput, ButtonType>()
    {
      {
        DigitalInput.None,
        ButtonType.None
      },
      {
        DigitalInput.Sprint,
        ButtonType.Sprint
      },
      {
        DigitalInput.Tackle,
        ButtonType.Tackle
      },
      {
        DigitalInput.PrimarySkill,
        ButtonType.PrimarySkill
      },
      {
        DigitalInput.SecondarySkill,
        ButtonType.SecondarySkill
      },
      {
        DigitalInput.ThrowBall,
        ButtonType.ThrowBall
      },
      {
        DigitalInput.Ping,
        ButtonType.Ping
      },
      {
        DigitalInput.Emote0,
        ButtonType.Emote0
      },
      {
        DigitalInput.Emote1,
        ButtonType.Emote1
      },
      {
        DigitalInput.Emote2,
        ButtonType.Emote2
      },
      {
        DigitalInput.Emote3,
        ButtonType.Emote3
      },
      {
        DigitalInput.Spraytag0,
        ButtonType.Spraytag0
      },
      {
        DigitalInput.Spraytag1,
        ButtonType.Spraytag1
      },
      {
        DigitalInput.Spraytag2,
        ButtonType.Spraytag2
      },
      {
        DigitalInput.Spraytag3,
        ButtonType.Spraytag3
      },
      {
        DigitalInput.QuickMessage0,
        ButtonType.QuickMessage0
      },
      {
        DigitalInput.QuickMessage1,
        ButtonType.QuickMessage1
      },
      {
        DigitalInput.QuickMessage2,
        ButtonType.QuickMessage2
      },
      {
        DigitalInput.QuickMessage3,
        ButtonType.QuickMessage3
      },
      {
        DigitalInput.EmoteModifier,
        ButtonType.EmoteModifier
      },
      {
        DigitalInput.SpraytagModifier,
        ButtonType.SpraytagModifier
      },
      {
        DigitalInput.QuickMessageModifier,
        ButtonType.QuickMessageModifier
      },
      {
        DigitalInput.MoveToBall,
        ButtonType.MoveToBall
      }
    };
    private static Dictionary<string, DigitalInput> reverseButtonActionNames;
    private static Dictionary<string, AnalogInput> reverseAnalogActionNames;
    private static Dictionary<InputSource, Dictionary<int, string>> rewiredGlyphs = new Dictionary<InputSource, Dictionary<int, string>>()
    {
      {
        InputSource.DefaultController,
        new Dictionary<int, string>()
        {
          {
            32,
            "XBox Resources/xbox_button_a"
          },
          {
            33,
            "XBox Resources/xbox_button_b"
          },
          {
            34,
            "XBox Resources/xbox_button_x"
          },
          {
            35,
            "XBox Resources/xbox_button_y"
          },
          {
            38,
            "Common/button_lt"
          },
          {
            39,
            "Common/button_rt"
          },
          {
            36,
            "XBox Resources/XBOX_lb"
          },
          {
            37,
            "XBox Resources/XBOX_rb"
          }
        }
      },
      {
        InputSource.XBox,
        new Dictionary<int, string>()
        {
          {
            6,
            "XBox Resources/xbox_button_a"
          },
          {
            7,
            "XBox Resources/xbox_button_b"
          },
          {
            8,
            "XBox Resources/xbox_button_x"
          },
          {
            9,
            "XBox Resources/xbox_button_y"
          },
          {
            4,
            "Common/button_lt"
          },
          {
            5,
            "Common/button_rt"
          },
          {
            10,
            "XBox Resources/XBOX_lb"
          },
          {
            11,
            "XBox Resources/XBOX_rb"
          },
          {
            12,
            "XBox Resources/xbox_context"
          },
          {
            13,
            "XBox Resources/xbox_switch"
          },
          {
            16,
            "Common/GEN_up"
          },
          {
            17,
            "Common/GEN_right"
          },
          {
            18,
            "Common/GEN_down"
          },
          {
            19,
            "Common/GEN_left"
          }
        }
      },
      {
        InputSource.DualShock,
        new Dictionary<int, string>()
        {
          {
            6,
            "PS4 Resources/ps_button_cross"
          },
          {
            7,
            "PS4 Resources/ps_button_circle"
          },
          {
            8,
            "PS4 Resources/ps_button_square"
          },
          {
            9,
            "PS4 Resources/ps_button_triangle"
          },
          {
            4,
            "PS4 Resources/DS_2"
          },
          {
            5,
            "PS4 Resources/DS_r2"
          },
          {
            10,
            "PS4 Resources/DS_l1"
          },
          {
            11,
            "PS4 Resources/DS_r2_1"
          },
          {
            12,
            "PS4 Resources/DS_share"
          },
          {
            13,
            "PS4 Resources/DS_options"
          },
          {
            18,
            "Common/GEN_up"
          },
          {
            19,
            "Common/GEN_right"
          },
          {
            20,
            "Common/GEN_down"
          },
          {
            21,
            "Common/GEN_left"
          }
        }
      },
      {
        InputSource.SwitchPro,
        new Dictionary<int, string>()
        {
          {
            4,
            "Switch Resources/SW_b"
          },
          {
            5,
            "Switch Resources/SW_a"
          },
          {
            6,
            "Switch Resources/SW_y"
          },
          {
            7,
            "Switch Resources/SW_x"
          },
          {
            10,
            "Switch Resources/SW_zl"
          },
          {
            11,
            "Switch Resources/SW_zr"
          },
          {
            8,
            "Switch Resources/SW_l"
          },
          {
            9,
            "Switch Resources/SW_r"
          },
          {
            12,
            "Switch Resources/SW_-"
          },
          {
            13,
            "Switch Resources/SW_+"
          },
          {
            18,
            "Common/GEN_up"
          },
          {
            19,
            "Common/GEN_right"
          },
          {
            20,
            "Common/GEN_down"
          },
          {
            21,
            "Common/GEN_left"
          }
        }
      },
      {
        InputSource.SteamController,
        new Dictionary<int, string>()
        {
          {
            6,
            "XBox Resources/xbox_button_a"
          },
          {
            7,
            "XBox Resources/xbox_button_b"
          },
          {
            8,
            "XBox Resources/xbox_button_x"
          },
          {
            9,
            "XBox Resources/xbox_button_y"
          },
          {
            4,
            "Common/button_lt"
          },
          {
            5,
            "Common/button_rt"
          },
          {
            10,
            "XBox Resources/XBOX_lb"
          },
          {
            11,
            "XBox Resources/XBOX_rb"
          },
          {
            12,
            "XBox Resources/xbox_context"
          },
          {
            13,
            "XBox Resources/xbox_switch"
          },
          {
            16,
            "Common/GEN_up"
          },
          {
            17,
            "Common/GEN_right"
          },
          {
            18,
            "Common/GEN_down"
          },
          {
            19,
            "Common/GEN_left"
          }
        }
      },
      {
        InputSource.Raiju,
        new Dictionary<int, string>()
        {
          {
            4,
            "PS4 Resources/ps_button_cross"
          },
          {
            5,
            "PS4 Resources/ps_button_circle"
          },
          {
            6,
            "PS4 Resources/ps_button_square"
          },
          {
            7,
            "PS4 Resources/ps_button_triangle"
          },
          {
            10,
            "PS4 Resources/DS_2"
          },
          {
            11,
            "PS4 Resources/DS_r2"
          },
          {
            8,
            "PS4 Resources/DS_l1"
          },
          {
            9,
            "PS4 Resources/DS_r2_1"
          },
          {
            12,
            "PS4 Resources/DS_share"
          },
          {
            13,
            "PS4 Resources/DS_options"
          },
          {
            18,
            "Common/GEN_up"
          },
          {
            19,
            "Common/GEN_right"
          },
          {
            20,
            "Common/GEN_down"
          },
          {
            21,
            "Common/GEN_left"
          }
        }
      },
      {
        InputSource.Keyboard,
        new Dictionary<int, string>()
        {
          {
            3,
            "PC Resources/MOUSE_left"
          },
          {
            4,
            "PC Resources/MOUSE_right"
          },
          {
            5,
            "PC Resources/MOUSE_mid"
          },
          {
            60,
            "PC Resources/KB_esc"
          },
          {
            58,
            "PC Resources/KB_enter"
          },
          {
            56,
            "PC Resources/KB_tab_b"
          },
          {
            54,
            "PC Resources/KB_space"
          },
          {
            119,
            "PC Resources/KB_left_control"
          },
          {
            121,
            "PC Resources/KB_left_alt"
          },
          {
            120,
            "PC Resources/KB_right_alt"
          },
          {
            23,
            "PC Resources/KB_w"
          },
          {
            1,
            "PC Resources/KB_a"
          },
          {
            19,
            "PC Resources/KB_s"
          },
          {
            28,
            "PC Resources/KB_1"
          },
          {
            29,
            "PC Resources/KB_2"
          },
          {
            30,
            "PC Resources/KB_3"
          },
          {
            31,
            "PC Resources/KB_4"
          },
          {
            117,
            "PC Resources/KB_shift_b"
          },
          {
            116,
            "PC Resources/KB_shift_b"
          },
          {
            17,
            "PC Resources/KB_q"
          }
        }
      },
      {
        InputSource.Mouse,
        new Dictionary<int, string>()
        {
          {
            3,
            "PC Resources/MOUSE_left"
          },
          {
            4,
            "PC Resources/MOUSE_right"
          },
          {
            5,
            "PC Resources/MOUSE_mid"
          },
          {
            60,
            "PC Resources/KB_esc"
          },
          {
            58,
            "PC Resources/KB_enter"
          },
          {
            56,
            "PC Resources/KB_tab_b"
          },
          {
            54,
            "PC Resources/KB_space"
          },
          {
            119,
            "PC Resources/KB_left_control"
          },
          {
            121,
            "PC Resources/KB_left_alt"
          },
          {
            120,
            "PC Resources/KB_right_alt"
          },
          {
            23,
            "PC Resources/KB_w"
          },
          {
            1,
            "PC Resources/KB_a"
          },
          {
            19,
            "PC Resources/KB_s"
          },
          {
            20,
            "PC Resources/KB_t"
          },
          {
            22,
            "PC Resources/KB_v"
          },
          {
            28,
            "PC Resources/KB_1"
          },
          {
            29,
            "PC Resources/KB_2"
          },
          {
            30,
            "PC Resources/KB_3"
          },
          {
            31,
            "PC Resources/KB_4"
          },
          {
            117,
            "PC Resources/KB_shift_b"
          },
          {
            116,
            "PC Resources/KB_shift_b"
          },
          {
            17,
            "PC Resources/KB_q"
          }
        }
      }
    };

    public static string GetRewiredGlyphPath(InputSource inputSource, int elementId)
    {
      string str = "UI/MenuUI/";
      return !InputStructures.rewiredGlyphs.ContainsKey(inputSource) || !InputStructures.rewiredGlyphs[inputSource].ContainsKey(elementId) ? str + (inputSource == InputSource.Keyboard || inputSource == InputSource.Mouse ? "PC Resources/pc_default" : "Common/controller_default") : str + InputStructures.rewiredGlyphs[inputSource][elementId];
    }

    public static List<string> GetAllButtonNames() => new List<string>((IEnumerable<string>) InputStructures.buttonActionNames.Values);

    public static List<DigitalInput> GetAllButtons() => new List<DigitalInput>((IEnumerable<DigitalInput>) InputStructures.buttonActionNames.Keys);

    public static List<AnalogInput> GetAllAnalogInputs() => new List<AnalogInput>((IEnumerable<AnalogInput>) InputStructures.analogActionNames.Keys);

    public static string GetButtonName(DigitalInput button)
    {
      if (InputStructures.buttonActionNames.ContainsKey(button))
        return InputStructures.buttonActionNames[button];
      Debug.LogError((object) ("No name for button " + (object) button + " exists. Check dictionaries in InputStructures.cs file."));
      return "";
    }

    public static DigitalInput GetButtonByName(string buttonName, bool suppressErrorLog = false)
    {
      if (InputStructures.IsButtonKnown(buttonName))
        return InputStructures.reverseButtonActionNames[buttonName];
      if (!suppressErrorLog)
        Debug.LogError((object) ("No button type with name " + buttonName + " exists. Check dictionaries in InputStructures.cs file."));
      return DigitalInput.None;
    }

    public static bool IsButtonKnown(string buttonName)
    {
      if (InputStructures.reverseButtonActionNames == null)
      {
        InputStructures.reverseButtonActionNames = new Dictionary<string, DigitalInput>();
        foreach (KeyValuePair<DigitalInput, string> buttonActionName in InputStructures.buttonActionNames)
          InputStructures.reverseButtonActionNames.Add(buttonActionName.Value, buttonActionName.Key);
      }
      return InputStructures.reverseButtonActionNames.ContainsKey(buttonName);
    }

    public static string GetAnalogInputName(AnalogInput analogInput)
    {
      if (InputStructures.analogActionNames.ContainsKey(analogInput))
        return InputStructures.analogActionNames[analogInput];
      Debug.LogError((object) ("No name for analog input " + (object) analogInput + " exists. Check dictionaries in InputStructures.cs file."));
      return "";
    }

    public static AnalogInput GetAnalogInputByName(
      string analogInputName,
      bool suppressAnalogInputNameNotFoundMessage = false)
    {
      if (InputStructures.IsAnalogInputKnown(analogInputName))
        return InputStructures.reverseAnalogActionNames[analogInputName];
      if (!suppressAnalogInputNameNotFoundMessage)
        Debug.LogError((object) ("No analog input with name " + analogInputName + " exists. Check dictionaries in InputStructures.cs file."));
      return AnalogInput.None;
    }

    public static bool IsAnalogInputKnown(string analogInputName)
    {
      if (InputStructures.reverseAnalogActionNames == null)
      {
        InputStructures.reverseAnalogActionNames = new Dictionary<string, AnalogInput>();
        foreach (KeyValuePair<AnalogInput, string> analogActionName in InputStructures.analogActionNames)
          InputStructures.reverseAnalogActionNames.Add(analogActionName.Value, analogActionName.Key);
      }
      return InputStructures.reverseAnalogActionNames.ContainsKey(analogInputName);
    }

    public static ButtonType GetNetworkedButtonType(DigitalInput button)
    {
      if (InputStructures.buttonNetworkedTypes.ContainsKey(button))
        return InputStructures.buttonNetworkedTypes[button];
      Debug.LogError((object) ("No network button type for button " + (object) button + " exists. Check dictionaries in InputStructures.cs file."));
      return ButtonType.None;
    }

    public static bool IsButtonNetworked(DigitalInput button) => InputStructures.buttonNetworkedTypes.ContainsKey(button);
  }
}
