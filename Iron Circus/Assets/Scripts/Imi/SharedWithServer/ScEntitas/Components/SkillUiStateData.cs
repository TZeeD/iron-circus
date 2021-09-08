// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Components.SkillUiStateData
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Jitter.LinearMath;

namespace Imi.SharedWithServer.ScEntitas.Components
{
  public struct SkillUiStateData
  {
    public int skillIdx;
    public string iconName;
    public float fillAmount;
    public float coolDownLeft;
    public bool active;
    public ButtonType buttonType;
    public JVector aimDirection;
    public bool onButtonDown;
    public bool isButtonDown;
  }
}
