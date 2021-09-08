// Decompiled with JetBrains decompiler
// Type: UnityEngine.UI.Extensions.Vector3_Array2D
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;

namespace UnityEngine.UI.Extensions
{
  [Serializable]
  public struct Vector3_Array2D
  {
    [SerializeField]
    public Vector3[] array;

    public Vector3 this[int _idx]
    {
      get => this.array[_idx];
      set => this.array[_idx] = value;
    }
  }
}
