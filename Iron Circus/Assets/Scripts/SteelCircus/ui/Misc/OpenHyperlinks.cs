// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.Misc.OpenHyperlinks
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;

namespace SteelCircus.UI.Misc
{
  [RequireComponent(typeof (TextMeshProUGUI))]
  public class OpenHyperlinks : MonoBehaviour, IPointerClickHandler, IEventSystemHandler
  {
    public bool doesColorChangeOnHover = true;
    public Color normalColor = new Color(0.2352941f, 0.4705882f, 1f);
    public Color hoverColor = new Color(0.2352941f, 0.4705882f, 1f);
    private TextMeshProUGUI pTextMeshPro;
    private Canvas pCanvas;
    private Camera pCamera;
    private int pCurrentLink = -1;
    private List<Color32[]> pOriginalVertexColors = new List<Color32[]>();

    public bool isLinkHighlighted => this.pCurrentLink != -1;

    protected virtual void Awake()
    {
      this.pTextMeshPro = this.GetComponent<TextMeshProUGUI>();
      this.pCanvas = this.GetComponentInParent<Canvas>();
      this.pCamera = this.pCanvas.renderMode != RenderMode.ScreenSpaceOverlay ? this.pCanvas.worldCamera : (Camera) null;
      this.StartCoroutine(this.ColorLinkTextDelayed());
    }

    private void LateUpdate()
    {
      int linkIndex = TMP_TextUtilities.IsIntersectingRectTransform(this.pTextMeshPro.rectTransform, Input.mousePosition, this.pCamera) ? TMP_TextUtilities.FindIntersectingLink((TMP_Text) this.pTextMeshPro, Input.mousePosition, this.pCamera) : -1;
      if (this.pCurrentLink != -1 && linkIndex != this.pCurrentLink)
      {
        this.SetLinkToColor(this.pCurrentLink, (Func<int, int, Color32>) ((linkIdx, vertIdx) => this.pOriginalVertexColors[linkIdx][vertIdx]));
        this.pOriginalVertexColors.Clear();
        this.pCurrentLink = -1;
      }
      if (linkIndex == -1 || linkIndex == this.pCurrentLink)
        return;
      this.pCurrentLink = linkIndex;
      this.pOriginalVertexColors = this.SetLinkToColor(linkIndex, (Func<int, int, Color32>) ((_linkIdx, _vertIdx) => (Color32) this.normalColor));
      if (!this.doesColorChangeOnHover)
        return;
      this.pOriginalVertexColors = this.SetLinkToColor(linkIndex, (Func<int, int, Color32>) ((_linkIdx, _vertIdx) => (Color32) this.hoverColor));
    }

    public void OnPointerClick(PointerEventData eventData)
    {
      int intersectingLink = TMP_TextUtilities.FindIntersectingLink((TMP_Text) this.pTextMeshPro, Input.mousePosition, this.pCamera);
      if (intersectingLink == -1)
        return;
      Application.OpenURL(this.pTextMeshPro.textInfo.linkInfo[intersectingLink].GetLinkID());
    }

    private List<Color32[]> SetLinkToColor(
      int linkIndex,
      Func<int, int, Color32> colorForLinkAndVert)
    {
      TMP_LinkInfo tmpLinkInfo = this.pTextMeshPro.textInfo.linkInfo[linkIndex];
      List<Color32[]> color32ArrayList = new List<Color32[]>();
      for (int index = 0; index < tmpLinkInfo.linkTextLength; ++index)
      {
        TMP_CharacterInfo tmpCharacterInfo = this.pTextMeshPro.textInfo.characterInfo[tmpLinkInfo.linkTextfirstCharacterIndex + index];
        int materialReferenceIndex = tmpCharacterInfo.materialReferenceIndex;
        int vertexIndex = tmpCharacterInfo.vertexIndex;
        Color32[] colors32 = this.pTextMeshPro.textInfo.meshInfo[materialReferenceIndex].colors32;
        color32ArrayList.Add(((IEnumerable<Color32>) colors32).ToArray<Color32>());
        if (tmpCharacterInfo.isVisible)
        {
          colors32[vertexIndex] = colorForLinkAndVert(index, vertexIndex);
          colors32[vertexIndex + 1] = colorForLinkAndVert(index, vertexIndex + 1);
          colors32[vertexIndex + 2] = colorForLinkAndVert(index, vertexIndex + 2);
          colors32[vertexIndex + 3] = colorForLinkAndVert(index, vertexIndex + 3);
        }
      }
      this.pTextMeshPro.UpdateVertexData(TMP_VertexDataUpdateFlags.All);
      return color32ArrayList;
    }

    private IEnumerator ColorLinkTextDelayed()
    {
      // ISSUE: reference to a compiler-generated field
      int num = this.\u003C\u003E1__state;
      OpenHyperlinks openHyperlinks = this;
      if (num != 0)
      {
        if (num != 1)
          return false;
        // ISSUE: reference to a compiler-generated field
        this.\u003C\u003E1__state = -1;
        // ISSUE: reference to a compiler-generated method
        openHyperlinks.SetLinkToColor(0, new Func<int, int, Color32>(openHyperlinks.\u003CColorLinkTextDelayed\u003Eb__14_0));
        return false;
      }
      // ISSUE: reference to a compiler-generated field
      this.\u003C\u003E1__state = -1;
      // ISSUE: reference to a compiler-generated field
      this.\u003C\u003E2__current = (object) new WaitForSeconds(0.5f);
      // ISSUE: reference to a compiler-generated field
      this.\u003C\u003E1__state = 1;
      return true;
    }
  }
}
