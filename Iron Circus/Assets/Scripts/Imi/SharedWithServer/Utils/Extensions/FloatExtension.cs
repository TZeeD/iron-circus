// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Utils.Extensions.FloatExtension
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

namespace Imi.SharedWithServer.Utils.Extensions
{
  public static class FloatExtension
  {
    public static float Smooth(this float v, int value, float smoothing) => (float) ((double) v * (double) smoothing + (1.0 - (double) smoothing) * (double) value);

    public static float MapValue(
      this float from,
      float fromMin,
      float fromMax,
      float toMin,
      float toMax)
    {
      float num = (from - fromMin) / (fromMax - fromMin);
      return (toMax - toMin) * num + toMin;
    }
  }
}
