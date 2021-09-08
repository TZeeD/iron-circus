// Decompiled with JetBrains decompiler
// Type: Coffee.UIExtensions.UIFlip
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.UI;

namespace Coffee.UIExtensions
{
  [DisallowMultipleComponent]
  [AddComponentMenu("UI/MeshEffectForTextMeshPro/UIFlip", 102)]
  public class UIFlip : BaseMeshEffect
  {
    [Tooltip("Flip horizontally.")]
    [SerializeField]
    private bool m_Horizontal;
    [Tooltip("Flip vertically.")]
    [SerializeField]
    private bool m_Veritical;

    public bool horizontal
    {
      get => this.m_Horizontal;
      set
      {
        this.m_Horizontal = value;
        this.SetVerticesDirty();
      }
    }

    public bool vertical
    {
      get => this.m_Veritical;
      set
      {
        this.m_Veritical = value;
        this.SetVerticesDirty();
      }
    }

    public override void ModifyMesh(VertexHelper vh)
    {
      RectTransform rectTransform = this.graphic.rectTransform;
      UIVertex vertex = new UIVertex();
      Vector2 center = rectTransform.rect.center;
      for (int i = 0; i < vh.currentVertCount; ++i)
      {
        vh.PopulateUIVertex(ref vertex, i);
        Vector3 position = vertex.position;
        vertex.position = new Vector3(this.m_Horizontal ? -position.x : position.x, this.m_Veritical ? -position.y : position.y);
        vh.SetUIVertex(vertex, i);
      }
    }
  }
}
