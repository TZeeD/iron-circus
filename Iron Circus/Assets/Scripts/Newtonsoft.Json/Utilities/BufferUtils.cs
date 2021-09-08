// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Utilities.BufferUtils
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

namespace Newtonsoft.Json.Utilities
{
  internal static class BufferUtils
  {
    public static char[] RentBuffer(IArrayPool<char> bufferPool, int minSize) => bufferPool == null ? new char[minSize] : bufferPool.Rent(minSize);

    public static void ReturnBuffer(IArrayPool<char> bufferPool, char[] buffer) => bufferPool?.Return(buffer);

    public static char[] EnsureBufferSize(IArrayPool<char> bufferPool, int size, char[] buffer)
    {
      if (bufferPool == null)
        return new char[size];
      if (buffer != null)
        bufferPool.Return(buffer);
      return bufferPool.Rent(size);
    }
  }
}
