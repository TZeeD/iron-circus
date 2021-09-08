// Decompiled with JetBrains decompiler
// Type: NetStack.Buffers.ArrayPool`1
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Runtime.CompilerServices;
using System.Threading;

namespace NetStack.Buffers
{
  public abstract class ArrayPool<T>
  {
    private static ArrayPool<T> s_sharedInstance;

    public static ArrayPool<T> Shared => Volatile.Read<ArrayPool<T>>(ref ArrayPool<T>.s_sharedInstance) ?? ArrayPool<T>.EnsureSharedCreated();

    [MethodImpl(MethodImplOptions.NoInlining)]
    private static ArrayPool<T> EnsureSharedCreated()
    {
      Interlocked.CompareExchange<ArrayPool<T>>(ref ArrayPool<T>.s_sharedInstance, ArrayPool<T>.Create(), (ArrayPool<T>) null);
      return ArrayPool<T>.s_sharedInstance;
    }

    public static ArrayPool<T> Create() => (ArrayPool<T>) new DefaultArrayPool<T>();

    public static ArrayPool<T> Create(int maxArrayLength, int maxArraysPerBucket) => (ArrayPool<T>) new DefaultArrayPool<T>(maxArrayLength, maxArraysPerBucket);

    public abstract T[] Rent(int minimumLength);

    public abstract void Return(T[] array, bool clearArray = false);
  }
}
