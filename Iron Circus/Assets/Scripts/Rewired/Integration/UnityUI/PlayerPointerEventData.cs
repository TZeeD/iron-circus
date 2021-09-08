﻿// Decompiled with JetBrains decompiler
// Type: Rewired.Integration.UnityUI.PlayerPointerEventData
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Rewired.UI;
using System.Text;
using UnityEngine.EventSystems;

namespace Rewired.Integration.UnityUI
{
  public class PlayerPointerEventData : PointerEventData
  {
    public int playerId { get; set; }

    public int inputSourceIndex { get; set; }

    public IMouseInputSource mouseSource { get; set; }

    public ITouchInputSource touchSource { get; set; }

    public PointerEventType sourceType { get; set; }

    public int buttonIndex { get; set; }

    public PlayerPointerEventData(EventSystem eventSystem)
      : base(eventSystem)
    {
      this.playerId = -1;
      this.inputSourceIndex = -1;
      this.buttonIndex = -1;
    }

    public override string ToString()
    {
      StringBuilder stringBuilder = new StringBuilder();
      stringBuilder.AppendLine("<b>Player Id</b>: " + (object) this.playerId);
      stringBuilder.AppendLine("<b>Mouse Source</b>: " + (object) this.mouseSource);
      stringBuilder.AppendLine("<b>Input Source Index</b>: " + (object) this.inputSourceIndex);
      stringBuilder.AppendLine("<b>Touch Source/b>: " + (object) this.touchSource);
      stringBuilder.AppendLine("<b>Source Type</b>: " + (object) this.sourceType);
      stringBuilder.AppendLine("<b>Button Index</b>: " + (object) this.buttonIndex);
      stringBuilder.Append(base.ToString());
      return stringBuilder.ToString();
    }
  }
}
