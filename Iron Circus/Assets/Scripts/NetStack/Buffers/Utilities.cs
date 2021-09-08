// Decompiled with JetBrains decompiler
// Type: NetStack.Buffers.Utilities
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

namespace NetStack.Buffers
{
  internal static class Utilities
  {
    internal static int SelectBucketIndex(int bufferSize)
    {
      uint num1 = (uint) (bufferSize - 1) >> 4;
      int num2 = 0;
      if (num1 > (uint) ushort.MaxValue)
      {
        num1 >>= 16;
        num2 = 16;
      }
      if (num1 > (uint) byte.MaxValue)
      {
        num1 >>= 8;
        num2 += 8;
      }
      if (num1 > 15U)
      {
        num1 >>= 4;
        num2 += 4;
      }
      if (num1 > 3U)
      {
        num1 >>= 2;
        num2 += 2;
      }
      if (num1 > 1U)
      {
        num1 >>= 1;
        ++num2;
      }
      return num2 + (int) num1;
    }

    internal static int GetMaxSizeForBucket(int binIndex) => 16 << binIndex;
  }
}
