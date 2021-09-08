// Decompiled with JetBrains decompiler
// Type: SceneExtensions
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.SceneManagement;

public static class SceneExtensions
{
  public static GameObject FindObjectInRoot(this Scene scene, string name)
  {
    foreach (GameObject rootGameObject in scene.GetRootGameObjects())
    {
      if (rootGameObject.name == name)
        return rootGameObject;
    }
    return (GameObject) null;
  }
}
