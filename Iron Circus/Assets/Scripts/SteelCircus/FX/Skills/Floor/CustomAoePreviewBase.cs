// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.Floor.CustomAoePreviewBase
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;

namespace SteelCircus.FX.Skills.Floor
{
  public abstract class CustomAoePreviewBase : FloorEffectBase, IAoeVfx, IVfx
  {
    public abstract void SetAoe(AreaOfEffect aoe);
  }
}
