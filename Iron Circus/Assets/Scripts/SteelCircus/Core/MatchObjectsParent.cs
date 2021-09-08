// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.MatchObjectsParent
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.Rendering;
using Imi.SteelCircus.ui.Floor;
using Imi.SteelCircus.Utils.Extensions;
using UnityEngine;

namespace SteelCircus.Core
{
  public static class MatchObjectsParent
  {
    private static Transform parentTransform;
    private static Imi.SteelCircus.Rendering.Floor floor;

    public static Transform Transform => MatchObjectsParent.parentTransform;

    public static Imi.SteelCircus.Rendering.Floor Floor => MatchObjectsParent.floor;

    public static FloorRenderer FloorRenderer => MatchObjectsParent.floor.FloorRenderer;

    public static FloorStateManager FloorStateManager => MatchObjectsParent.floor.FloorContents;

    public static void Init()
    {
      GameObject gameObject = new GameObject(nameof (MatchObjectsParent));
      MatchObjectsParent.parentTransform = gameObject.transform;
      MatchObjectsParent.parentTransform.SetToIdentity();
      Object.DontDestroyOnLoad((Object) gameObject);
    }

    public static GameObject Add(GameObject go)
    {
      MatchObjectsParent.Add(go.transform);
      return go;
    }

    public static void Add(Transform t) => t.SetParent(MatchObjectsParent.parentTransform);

    public static void Clear()
    {
      for (int index = MatchObjectsParent.parentTransform.childCount - 1; index > 0; --index)
        Object.Destroy((Object) MatchObjectsParent.parentTransform.GetChild(index).gameObject);
    }

    public static void DisableAllChildren()
    {
      for (int index = MatchObjectsParent.parentTransform.childCount - 1; index > 0; --index)
        MatchObjectsParent.parentTransform.GetChild(index).gameObject.SetActive(false);
    }

    public static void RegisterFloor(Imi.SteelCircus.Rendering.Floor f) => MatchObjectsParent.floor = f;

    public static void UnregisterFloor() => MatchObjectsParent.floor = (Imi.SteelCircus.Rendering.Floor) null;
  }
}
