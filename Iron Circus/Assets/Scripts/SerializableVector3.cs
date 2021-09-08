// Decompiled with JetBrains decompiler
// Type: SerializableVector3
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using UnityEngine;

[Serializable]
public struct SerializableVector3
{
  public float x;
  public float y;
  public float z;

  public SerializableVector3(float rX, float rY, float rZ)
  {
    this.x = rX;
    this.y = rY;
    this.z = rZ;
  }

  public override string ToString() => string.Format("[{0}, {1}, {2}]", (object) this.x, (object) this.y, (object) this.z);

  public static implicit operator Vector3(SerializableVector3 rValue) => new Vector3(rValue.x, rValue.y, rValue.z);

  public static implicit operator SerializableVector3(Vector3 rValue) => new SerializableVector3(rValue.x, rValue.y, rValue.z);
}
