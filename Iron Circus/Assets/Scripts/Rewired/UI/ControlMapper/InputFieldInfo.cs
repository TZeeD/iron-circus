// Decompiled with JetBrains decompiler
// Type: Rewired.UI.ControlMapper.InputFieldInfo
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace Rewired.UI.ControlMapper
{
  [AddComponentMenu("")]
  public class InputFieldInfo : UIElementInfo
  {
    public int actionId { get; set; }

    public AxisRange axisRange { get; set; }

    public int actionElementMapId { get; set; }

    public ControllerType controllerType { get; set; }

    public int controllerId { get; set; }
  }
}
