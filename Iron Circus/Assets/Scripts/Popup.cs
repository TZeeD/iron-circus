// Decompiled with JetBrains decompiler
// Type: Popup
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SteelCircus.UI.Popups;
using System.Collections.Generic;

public class Popup : IPopupSettings
{
  public string title;
  public string information;
  public string button1;
  public string button2;
  public string button3;
  public int timer;

  public List<SCPopupButton> buttons { get; }

  public Popup(
    string information,
    string button1 = null,
    string button2 = null,
    string button3 = null,
    string title = null,
    int timer = 0)
  {
    this.information = information;
    this.button1 = button1;
    this.button2 = button2;
    this.button3 = button3;
    this.title = title;
    this.timer = timer;
  }

  public Popup(string information, List<SCPopupButton> buttons, string title = null)
  {
    this.title = title;
    this.information = information;
    this.buttons = buttons;
  }

  public string Title => this.title != null ? this.title : string.Empty;

  public string Information => this.information != null ? this.information : string.Empty;

  public string Button1 => this.button1 != null ? this.button1 : string.Empty;

  public string Button2 => this.button2 != null ? this.button2 : string.Empty;

  public string Button3 => this.button3 != null ? this.button3 : string.Empty;

  public int Timer => this.timer;
}
