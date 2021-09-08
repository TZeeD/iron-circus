// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.RelativePointer`1
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Runtime.CompilerServices;

namespace Imi.SharedWithServer.Game.Skills
{
  public struct RelativePointer<T> where T : struct
  {
    private byte[] data;
    private int byteIndex;

    public RelativePointer(byte[] data, int byteIndex)
    {
      this.data = data;
      this.byteIndex = byteIndex;
    }

    public void SetTargetBuffer(byte[] targetBuffer) => this.data = targetBuffer;

    public void SetIndex(int index) => this.byteIndex = index;

    [MethodImpl((MethodImplOptions) 256)]
    public T Get() => Unsafe.As<byte, T>(ref this.data[this.byteIndex]);

    public static implicit operator T(RelativePointer<T> pointer) => pointer.Get();

    [MethodImpl((MethodImplOptions) 256)]
    public void Set(T value) => Unsafe.CopyBlockUnaligned(ref this.data[this.byteIndex], ref Unsafe.As<T, byte>(ref value), (uint) RelativePointer<T>.SizeOf());

    [MethodImpl((MethodImplOptions) 256)]
    public static int SizeOf() => Unsafe.SizeOf<T>();

    [MethodImpl((MethodImplOptions) 256)]
    public void CopyTo(byte[] target, int targetIndex) => Unsafe.CopyBlockUnaligned(ref target[targetIndex], ref this.data[this.byteIndex], (uint) Unsafe.SizeOf<T>());
  }
}
