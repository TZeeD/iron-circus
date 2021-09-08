// Decompiled with JetBrains decompiler
// Type: UnityEngine.UI.Extensions.CUIImage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections.Generic;

namespace UnityEngine.UI.Extensions
{
  [RequireComponent(typeof (RectTransform))]
  [RequireComponent(typeof (Image))]
  [AddComponentMenu("UI/Effects/Extensions/Curly UI Image")]
  public class CUIImage : CUIGraphic
  {
    public static int SlicedImageCornerRefVertexIdx = 2;
    public static int FilledImageCornerRefVertexIdx = 0;
    [Tooltip("For changing the size of the corner for tiled or sliced Image")]
    [HideInInspector]
    [SerializeField]
    public Vector2 cornerPosRatio = Vector2.one * -1f;
    [HideInInspector]
    [SerializeField]
    protected Vector2 oriCornerPosRatio = Vector2.one * -1f;

    public static int ImageTypeCornerRefVertexIdx(Image.Type _type) => _type == Image.Type.Sliced ? CUIImage.SlicedImageCornerRefVertexIdx : CUIImage.FilledImageCornerRefVertexIdx;

    public Vector2 OriCornerPosRatio => this.oriCornerPosRatio;

    public Image UIImage => (Image) this.uiGraphic;

    public override void ReportSet()
    {
      if ((Object) this.uiGraphic == (Object) null)
        this.uiGraphic = (Graphic) this.GetComponent<Image>();
      base.ReportSet();
    }

    protected override void modifyVertices(List<UIVertex> _verts)
    {
      if (!this.IsActive())
        return;
      if (this.UIImage.type == Image.Type.Filled)
        Debug.LogWarning((object) "Might not work well Radial Filled at the moment!");
      else if (this.UIImage.type == Image.Type.Sliced || this.UIImage.type == Image.Type.Tiled)
      {
        if (this.cornerPosRatio == Vector2.one * -1f)
        {
          this.cornerPosRatio = (Vector2) _verts[CUIImage.ImageTypeCornerRefVertexIdx(this.UIImage.type)].position;
          this.cornerPosRatio.x = (this.cornerPosRatio.x + this.rectTrans.pivot.x * this.rectTrans.rect.width) / this.rectTrans.rect.width;
          this.cornerPosRatio.y = (this.cornerPosRatio.y + this.rectTrans.pivot.y * this.rectTrans.rect.height) / this.rectTrans.rect.height;
          this.oriCornerPosRatio = this.cornerPosRatio;
        }
        if ((double) this.cornerPosRatio.x < 0.0)
          this.cornerPosRatio.x = 0.0f;
        if ((double) this.cornerPosRatio.x >= 0.5)
          this.cornerPosRatio.x = 0.5f;
        if ((double) this.cornerPosRatio.y < 0.0)
          this.cornerPosRatio.y = 0.0f;
        if ((double) this.cornerPosRatio.y >= 0.5)
          this.cornerPosRatio.y = 0.5f;
        for (int index = 0; index < _verts.Count; ++index)
        {
          UIVertex vert = _verts[index];
          double x = (double) vert.position.x;
          Rect rect = this.rectTrans.rect;
          double num1 = (double) rect.width * (double) this.rectTrans.pivot.x;
          double num2 = x + num1;
          rect = this.rectTrans.rect;
          double width1 = (double) rect.width;
          float num3 = (float) (num2 / width1);
          double y = (double) vert.position.y;
          rect = this.rectTrans.rect;
          double num4 = (double) rect.height * (double) this.rectTrans.pivot.y;
          double num5 = y + num4;
          rect = this.rectTrans.rect;
          double height1 = (double) rect.height;
          float num6 = (float) (num5 / height1);
          float num7 = (double) num3 >= (double) this.oriCornerPosRatio.x ? ((double) num3 <= 1.0 - (double) this.oriCornerPosRatio.x ? Mathf.Lerp(this.cornerPosRatio.x, 1f - this.cornerPosRatio.x, (float) (((double) num3 - (double) this.oriCornerPosRatio.x) / (1.0 - (double) this.oriCornerPosRatio.x * 2.0))) : Mathf.Lerp(1f - this.cornerPosRatio.x, 1f, (num3 - (1f - this.oriCornerPosRatio.x)) / this.oriCornerPosRatio.x)) : Mathf.Lerp(0.0f, this.cornerPosRatio.x, num3 / this.oriCornerPosRatio.x);
          float num8 = (double) num6 >= (double) this.oriCornerPosRatio.y ? ((double) num6 <= 1.0 - (double) this.oriCornerPosRatio.y ? Mathf.Lerp(this.cornerPosRatio.y, 1f - this.cornerPosRatio.y, (float) (((double) num6 - (double) this.oriCornerPosRatio.y) / (1.0 - (double) this.oriCornerPosRatio.y * 2.0))) : Mathf.Lerp(1f - this.cornerPosRatio.y, 1f, (num6 - (1f - this.oriCornerPosRatio.y)) / this.oriCornerPosRatio.y)) : Mathf.Lerp(0.0f, this.cornerPosRatio.y, num6 / this.oriCornerPosRatio.y);
          ref Vector3 local1 = ref vert.position;
          double num9 = (double) num7;
          rect = this.rectTrans.rect;
          double width2 = (double) rect.width;
          double num10 = num9 * width2;
          rect = this.rectTrans.rect;
          double num11 = (double) rect.width * (double) this.rectTrans.pivot.x;
          double num12 = num10 - num11;
          local1.x = (float) num12;
          ref Vector3 local2 = ref vert.position;
          double num13 = (double) num8;
          rect = this.rectTrans.rect;
          double height2 = (double) rect.height;
          double num14 = num13 * height2;
          rect = this.rectTrans.rect;
          double num15 = (double) rect.height * (double) this.rectTrans.pivot.y;
          double num16 = num14 - num15;
          local2.y = (float) num16;
          _verts[index] = vert;
        }
      }
      base.modifyVertices(_verts);
    }
  }
}
