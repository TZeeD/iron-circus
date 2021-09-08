// Decompiled with JetBrains decompiler
// Type: SerializableQuaternion
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using UnityEngine;

[Serializable]
public struct SerializableQuaternion
{
  public float x;
  public float y;
  public float z;
  public float w;

  public SerializableQuaternion(float rX, float rY, float rZ, float rW)
  {
    this.x = rX;
    this.y = rY;
    this.z = rZ;
    this.w = rW;
  }

  public override string ToString() => string.Format("[{0}, {1}, {2}, {3}]", (object) this.x, (object) this.y, (object) this.z, (object) this.w);

  public static implicit operator Quaternion(SerializableQuaternion rValue) => new Quaternion(rValue.x, rValue.y, rValue.z, rValue.w);

  public static implicit operator SerializableQuaternion(Quaternion rValue) => new SerializableQuaternion(rValue.x, rValue.y, rValue.z, rValue.w);
}
