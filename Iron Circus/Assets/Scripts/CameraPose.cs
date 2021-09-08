// Decompiled with JetBrains decompiler
// Type: CameraPose
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;
using UnityEngine;

[Serializable]
public class CameraPose
{
  public SerializableVector3 positionOffset;
  public SerializableQuaternion rotationOffset;
  public float fov;
  public bool hasRotation;
  public string fileName;

  public CameraPose(
    Vector3 positionOffset,
    Quaternion rotationOffset,
    float fov = 32f,
    bool hasRotation = false)
  {
    this.positionOffset = (SerializableVector3) positionOffset;
    this.rotationOffset = (SerializableQuaternion) rotationOffset;
    this.fov = fov;
    this.hasRotation = hasRotation;
  }

  public void SaveCameraPose(string filename)
  {
    Debug.Log((object) (filename + ".save"));
    this.fileName = filename.Substring(filename.LastIndexOf(Path.DirectorySeparatorChar) + 1);
    BinaryFormatter binaryFormatter = new BinaryFormatter();
    FileStream fileStream1 = File.Create(filename + ".save");
    FileStream fileStream2 = fileStream1;
    binaryFormatter.Serialize((Stream) fileStream2, (object) this);
    fileStream1.Close();
  }
}
