// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Utils.Extensions.GameObjectExtensions
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.Rendering;
using UnityEngine;

namespace Imi.SteelCircus.Utils.Extensions
{
  public static class GameObjectExtensions
  {
    public static void SetLayer(this GameObject go, Layer layer, bool recursive = true)
    {
      go.layer = layer.ToInt();
      if (!recursive)
        return;
      foreach (Component component in go.transform)
        component.gameObject.SetLayer(layer);
    }

    public static GameObject FindObject(this GameObject parent, string name)
    {
      foreach (Transform componentsInChild in parent.GetComponentsInChildren<Transform>(true))
      {
        if (componentsInChild.name == name)
          return componentsInChild.gameObject;
      }
      return (GameObject) null;
    }
  }
}
