// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Debugging.InputDebugView
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections.Generic;
using UnityEngine;

namespace Imi.SteelCircus.Debugging
{
  public class InputDebugView : MonoBehaviour
  {
    public bool show = true;
    public Rect rect = new Rect(10f, 10f, 200f, 30f);
    public RectTransform joystickBase;
    public RectTransform joystickPosition;
    public int trailPtCount = 50;
    private static Vector3 input;
    private static List<string> inputLog = new List<string>();
    private List<Vector3> inputPositions = new List<Vector3>();
    private LineRenderer lineRenderer;
    private static InputDebugView instance;

    public static InputDebugView Instance => InputDebugView.instance;

    private void Start()
    {
      InputDebugView.instance = this;
      this.lineRenderer = this.joystickBase.gameObject.AddComponent<LineRenderer>();
      this.lineRenderer.positionCount = this.trailPtCount;
      this.lineRenderer.widthMultiplier = 1f / 1000f;
      this.lineRenderer.useWorldSpace = false;
    }

    private void LateUpdate()
    {
      this.lineRenderer.positionCount = this.inputPositions.Count;
      this.lineRenderer.SetPositions(this.inputPositions.ToArray());
    }

    private void OnGUI()
    {
      if (!this.show)
        return;
      string text = "";
      foreach (string str in InputDebugView.inputLog)
        text = text + str + "\n";
      this.rect.height = (float) (Screen.height - 20);
      GUI.Box(this.rect, text);
    }

    public void SetInputV(Vector3 newInput)
    {
      if (InputDebugView.inputLog.Count == 0 || !InputDebugView.inputLog[0].Equals(newInput.ToString()))
        InputDebugView.inputLog.Insert(0, newInput.ToString());
      if (InputDebugView.inputLog.Count > 100)
        InputDebugView.inputLog.RemoveRange(100, InputDebugView.inputLog.Count - 100);
      this.joystickPosition.anchoredPosition = new Vector2((float) ((double) newInput.z * (double) this.joystickBase.rect.width / 2.0), (float) (-(double) newInput.x * (double) this.joystickBase.rect.height / 2.0));
      this.inputPositions.Insert(0, (Vector3) this.joystickPosition.anchoredPosition);
      if (this.inputPositions.Count <= this.trailPtCount)
        return;
      this.inputPositions.RemoveAt(this.trailPtCount);
    }
  }
}
