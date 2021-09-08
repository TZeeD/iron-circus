// Decompiled with JetBrains decompiler
// Type: UnityEngine.UI.Extensions.CylinderText
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

namespace UnityEngine.UI.Extensions
{
  [RequireComponent(typeof (Text), typeof (RectTransform))]
  [AddComponentMenu("UI/Effects/Extensions/Cylinder Text")]
  public class CylinderText : BaseMeshEffect
  {
    public float radius;
    private RectTransform rectTrans;

    protected override void Awake()
    {
      base.Awake();
      this.rectTrans = this.GetComponent<RectTransform>();
      this.OnRectTransformDimensionsChange();
    }

    protected override void OnEnable()
    {
      base.OnEnable();
      this.rectTrans = this.GetComponent<RectTransform>();
      this.OnRectTransformDimensionsChange();
    }

    public override void ModifyMesh(VertexHelper vh)
    {
      if (!this.IsActive())
        return;
      int currentVertCount = vh.currentVertCount;
      if (!this.IsActive() || currentVertCount == 0)
        return;
      for (int i = 0; i < vh.currentVertCount; ++i)
      {
        UIVertex vertex = new UIVertex();
        vh.PopulateUIVertex(ref vertex, i);
        float x = vertex.position.x;
        vertex.position.z = -this.radius * Mathf.Cos(x / this.radius);
        vertex.position.x = this.radius * Mathf.Sin(x / this.radius);
        vh.SetUIVertex(vertex, i);
      }
    }
  }
}
