// Decompiled with JetBrains decompiler
// Type: UnityEngine.UI.Extensions.CurvedText
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

namespace UnityEngine.UI.Extensions
{
  [RequireComponent(typeof (Text), typeof (RectTransform))]
  [AddComponentMenu("UI/Effects/Extensions/Curved Text")]
  public class CurvedText : BaseMeshEffect
  {
    [SerializeField]
    private AnimationCurve _curveForText = AnimationCurve.Linear(0.0f, 0.0f, 1f, 10f);
    [SerializeField]
    private float _curveMultiplier = 1f;
    private RectTransform rectTrans;

    public AnimationCurve CurveForText
    {
      get => this._curveForText;
      set
      {
        this._curveForText = value;
        this.graphic.SetVerticesDirty();
      }
    }

    public float CurveMultiplier
    {
      get => this._curveMultiplier;
      set
      {
        this._curveMultiplier = value;
        this.graphic.SetVerticesDirty();
      }
    }

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
      int currentVertCount = vh.currentVertCount;
      if (!this.IsActive() || currentVertCount == 0)
        return;
      for (int i = 0; i < vh.currentVertCount; ++i)
      {
        UIVertex vertex = new UIVertex();
        vh.PopulateUIVertex(ref vertex, i);
        vertex.position.y += this._curveForText.Evaluate(this.rectTrans.rect.width * this.rectTrans.pivot.x + vertex.position.x) * this._curveMultiplier;
        vh.SetUIVertex(vertex, i);
      }
    }

    protected override void OnRectTransformDimensionsChange()
    {
      if (!(bool) (Object) this.rectTrans)
        return;
      Keyframe key = this._curveForText[this._curveForText.length - 1];
      key.time = this.rectTrans.rect.width;
      this._curveForText.MoveKey(this._curveForText.length - 1, key);
    }
  }
}
