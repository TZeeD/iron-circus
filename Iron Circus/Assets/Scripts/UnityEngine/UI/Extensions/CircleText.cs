// Decompiled with JetBrains decompiler
// Type: UnityEngine.UI.Extensions.CircleText
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

namespace UnityEngine.UI.Extensions
{
  [RequireComponent(typeof (Text), typeof (RectTransform))]
  [AddComponentMenu("UI/Effects/Extensions/Circle Text")]
  public class CircleText : BaseMeshEffect
  {
    public float angle = 60f;
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
        Vector3 position = vertex.position;
        float num = this.rectTrans.rect.width / 2f;
        Vector3 vector3_1 = position;
        vector3_1.x /= num;
        Vector3 vector3_2 = position;
        vector3_2.x = 0.0f;
        Vector3 vector3_3 = Quaternion.Euler(0.0f, 0.0f, (float) (-(double) this.angle / 2.0) * vector3_1.x) * vector3_2;
        vertex.position = vector3_3;
        vh.SetUIVertex(vertex, i);
      }
    }
  }
}
