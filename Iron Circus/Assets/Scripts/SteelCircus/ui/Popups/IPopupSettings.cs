// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.Popups.IPopupSettings
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections.Generic;

namespace SteelCircus.UI.Popups
{
  public interface IPopupSettings
  {
    string Title { get; }

    string Information { get; }

    string Button1 { get; }

    string Button2 { get; }

    string Button3 { get; }

    List<SCPopupButton> buttons { get; }

    int Timer { get; }
  }
}
