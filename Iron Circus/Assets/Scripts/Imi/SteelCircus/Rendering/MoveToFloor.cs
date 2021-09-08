// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Rendering.MoveToFloor
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SteelCircus.Core;
using UnityEngine;

namespace Imi.SteelCircus.Rendering
{
  public class MoveToFloor : MonoBehaviour
  {
    [SerializeField]
    private FloorRenderer.FloorLayer floorLayer;

    private void Start()
    {
      this.transform.parent = (Transform) null;
      MatchObjectsParent.FloorRenderer.AddToLayer(this.transform, this.floorLayer);
    }
  }
}
