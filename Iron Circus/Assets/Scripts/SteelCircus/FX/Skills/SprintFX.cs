// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.SprintFX
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game.Skills;
using Imi.SteelCircus.Utils;
using SteelCircus.Core;
using UnityEngine;

namespace SteelCircus.FX.Skills
{
  public class SprintFX : MonoBehaviour, IVfx
  {
    public GameObject trails;
    public bool UseFloorTrail;
    private GameObject floorTrailRenderer;
    private GameEntity owner;

    private void Awake()
    {
      this.floorTrailRenderer = this.GetComponentInChildren<TrailRenderer>(true).gameObject;
      this.floorTrailRenderer.GetComponent<LinkLocalSpace>().linkedTransform = this.transform;
      MatchObjectsParent.FloorRenderer.AddEmissive(this.floorTrailRenderer.transform);
      this.floorTrailRenderer.SetActive(false);
    }

    private void Update() => this.trails.SetActive(this.owner != null && (double) this.owner.velocityOverride.value.LengthSquared() > 0.00999999977648258);

    private void OnEnable()
    {
      if (!this.UseFloorTrail)
        return;
      this.floorTrailRenderer.SetActive(true);
    }

    private void OnDisable()
    {
      if (!this.UseFloorTrail)
        return;
      this.floorTrailRenderer.SetActive(false);
    }

    private void OnDestroy() => Object.Destroy((Object) this.floorTrailRenderer);

    public void SetOwner(GameEntity entity) => this.owner = entity;

    public void SetArgs(object args)
    {
    }

    public void SetSkillGraph(SkillGraph graph)
    {
    }
  }
}
