// Decompiled with JetBrains decompiler
// Type: PickupView2D
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.SteelCircus.Rendering;
using Imi.SteelCircus.ScriptableObjects;
using SteelCircus.Core;
using SteelCircus.GameElements;
using UnityEngine;

public class PickupView2D : MonoBehaviour, IPickupView
{
  [SerializeField]
  private SpriteRenderer icon;

  private void Start()
  {
    MatchObjectsParent.FloorRenderer.AddToLayer(this.transform, FloorRenderer.FloorLayer.Emissive);
    this.transform.SetParent(MatchObjectsParent.FloorRenderer.GetCanvas().transform);
  }

  public void PlayPickupSpawn(bool activeOnStart, PickupType pickupType)
  {
    this.icon.color = SingletonScriptableObject<ColorsConfig>.Instance.ColorForPickupType(pickupType);
    this.gameObject.SetActive(activeOnStart);
  }
}
