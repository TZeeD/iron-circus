// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.Floor.DefaultAoePreview
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Config;
using Imi.SteelCircus.Utils;
using UnityEngine;

namespace SteelCircus.FX.Skills.Floor
{
  public class DefaultAoePreview : FloorEffectBase, IAoeVfx, IVfx
  {
    [HideInInspector]
    public AreaOfEffect aoe;
    [HideInInspector]
    public Team team;
    public int arcResolution;
    public Material previewMatTeam1;
    public Material previewMatTeam2;
    public GameObject circlePreviewPrefabTeam1;
    public GameObject rectPreviewPrefabTeam1;
    public GameObject circlePreviewPrefabTeam2;
    public GameObject rectPreviewPrefabTeam2;
    private GameObject previewGo;
    private AreaOfEffect cachedAoe;
    private int cachedArcRes;
    private Mesh previewMesh;
    private MeshRenderer meshRenderer;
    private MeshFilter mFilter;

    protected override void Awake()
    {
    }

    public new void SetOwner(GameEntity entity)
    {
      this.team = entity.playerTeam.value;
      this.CreateAndUpdatePreview();
    }

    public void SetAoe(AreaOfEffect aoe)
    {
      this.aoe = aoe;
      this.CreateAndUpdatePreview();
    }

    private void CacheState()
    {
      this.cachedArcRes = this.arcResolution;
      this.cachedAoe = this.aoe;
    }

    private void CreateAndUpdatePreview()
    {
      if ((Object) this.previewGo != (Object) null)
        Object.Destroy((Object) this.previewGo);
      this.CreatePreviewObject();
      this.UpdatePreview();
      this.CacheState();
      this.GatherMaterials();
    }

    private void CreatePreviewObject()
    {
      if (this.aoe.shape == AoeShape.Cone)
      {
        this.previewGo = new GameObject();
        this.meshRenderer = this.previewGo.AddComponent<MeshRenderer>();
        this.mFilter = this.previewGo.AddComponent<MeshFilter>();
        this.previewMesh = MeshUtils.GetConeMesh(this.aoe, this.arcResolution);
        this.meshRenderer.sharedMaterial = this.team == Team.Alpha ? this.previewMatTeam1 : this.previewMatTeam2;
        this.mFilter.mesh = this.previewMesh;
      }
      else if (this.aoe.shape == AoeShape.Circle)
      {
        this.previewGo = Object.Instantiate<GameObject>(this.team == Team.Alpha ? this.circlePreviewPrefabTeam1 : this.circlePreviewPrefabTeam2, this.transform, false);
        this.previewGo.transform.localPosition = Vector3.zero;
        this.previewGo.transform.localScale = Vector3.one * this.aoe.radius;
      }
      else if (this.aoe.shape == AoeShape.Rectangle)
      {
        this.previewGo = Object.Instantiate<GameObject>(this.team == Team.Alpha ? this.rectPreviewPrefabTeam1 : this.rectPreviewPrefabTeam2, this.transform, false);
        this.previewGo.transform.localPosition = Vector3.zero;
        this.previewGo.transform.localScale = new Vector3(this.aoe.rectWidth, 1f, this.aoe.rectLength);
      }
      this.previewGo.transform.SetParent(this.scaleNodes[0], false);
    }

    public void UpdatePreview()
    {
      if (this.aoe.shape == AoeShape.Cone)
      {
        if ((double) Mathf.Abs(this.cachedAoe.angle - this.aoe.angle) <= 1.40129846432482E-45 && (double) Mathf.Abs(this.cachedAoe.radius - this.aoe.radius) <= 1.40129846432482E-45 && (double) Mathf.Abs(this.cachedAoe.deadZone - this.aoe.deadZone) <= 1.40129846432482E-45 && this.cachedArcRes == this.arcResolution)
          return;
        this.UpdatePreviewMesh();
      }
      else
      {
        if (this.aoe.shape != AoeShape.Circle || (double) Mathf.Abs(this.cachedAoe.radius - this.aoe.radius) <= 1.40129846432482E-45)
          return;
        if ((Object) this.previewGo == (Object) null)
          this.CreatePreviewObject();
        this.previewGo.transform.localScale = Vector3.one * this.aoe.radius;
      }
    }

    private void UpdatePreviewMesh()
    {
      this.previewMesh = MeshUtils.GetConeMesh(this.aoe, this.arcResolution);
      if (!((Object) this.GetComponent<MeshFilter>() != (Object) null))
        return;
      this.GetComponent<MeshFilter>().mesh = this.previewMesh;
    }
  }
}
