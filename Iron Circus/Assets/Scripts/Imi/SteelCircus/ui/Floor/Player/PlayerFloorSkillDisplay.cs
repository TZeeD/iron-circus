// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.UI.Floor.Player.PlayerFloorSkillDisplay
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace Imi.SteelCircus.UI.Floor.Player
{
  public class PlayerFloorSkillDisplay : MonoBehaviour
  {
    public float innerRadiusAtUnitScale = 0.36f;
    private float scale = 1f;
    private Renderer[] renderers;

    private void Start() => this.renderers = this.GetComponentsInChildren<Renderer>();

    public float Scale
    {
      get => this.scale;
      set
      {
        this.scale = value;
        this.transform.localScale = Vector3.one * this.scale;
        float num = this.innerRadiusAtUnitScale / this.scale;
        foreach (Renderer renderer in this.renderers)
        {
          Material material = renderer.material;
          if (material.HasProperty("_MinRadius"))
            material.SetFloat("_MinRadius", num);
        }
      }
    }
  }
}
