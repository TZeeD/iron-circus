// Decompiled with JetBrains decompiler
// Type: UnityEngine.PostProcessing.MinAttribute
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

namespace UnityEngine.PostProcessing
{
  public sealed class MinAttribute : PropertyAttribute
  {
    public readonly float min;

    public MinAttribute(float min) => this.min = min;
  }
}
