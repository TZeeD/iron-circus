// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.Services.UIProgressionButtonState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;

namespace SteelCircus.Core.Services
{
  [Serializable]
  public class UIProgressionButtonState
  {
    public bool enabled;
    public bool highlighted;
    public bool newlyUnlocked;

    public UIProgressionButtonState(bool enabled, bool highlighted, bool newlyUnlocked)
    {
      this.enabled = enabled;
      this.highlighted = highlighted;
      this.newlyUnlocked = newlyUnlocked;
    }
  }
}
