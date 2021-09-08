// Decompiled with JetBrains decompiler
// Type: SteelCircus.Tutorial.TutorialTextBoxPositioner
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.ScEntitas;
using Imi.SteelCircus.CameraSystem;
using SteelCircus.Core.Services;
using System.Collections;
using UnityEngine;

namespace SteelCircus.Tutorial
{
  public class TutorialTextBoxPositioner : MonoBehaviour
  {
    [SerializeField]
    private float dampen = 2f;
    private TutorialTextBoxPositioner.Mode mode;
    private TutorialTextBox textBox;
    private Transform textBoxTransform;
    private Canvas canvas;
    private Vector3 currentOffset = Vector3.zero;

    private void Start()
    {
      this.canvas = this.transform.GetComponentInParent<Canvas>();
      this.textBox = this.GetComponent<TutorialTextBox>();
      this.textBoxTransform = this.textBox.transform;
    }

    public void SetMode(
      TutorialTextBoxPositioner.Mode newMode,
      Vector3 offset,
      bool animated = true,
      float delay = 0.0f)
    {
      Log.Debug(string.Format("New Text Box Position: {0}", (object) newMode));
      if ((double) delay != 0.0)
      {
        this.StopAllCoroutines();
        this.StartCoroutine(this.SetModeCR(newMode, offset, animated, delay));
      }
      else
      {
        this.mode = newMode;
        this.currentOffset = offset;
        if (animated)
          return;
        this.transform.localPosition = this.CalcTargetPos();
      }
    }

    private IEnumerator SetModeCR(
      TutorialTextBoxPositioner.Mode newMode,
      Vector3 offset,
      bool animated,
      float delay)
    {
      yield return (object) new WaitForSeconds(delay);
      this.SetMode(newMode, offset, animated);
    }

    private void Update() => this.transform.localPosition = Vector3.Lerp(this.transform.localPosition, this.CalcTargetPos(), 1f - Mathf.Exp(-this.dampen * Time.deltaTime));

    private Vector3 CalcTargetPos()
    {
      float y = this.GetComponent<RectTransform>().sizeDelta.y;
      switch (this.mode)
      {
        case TutorialTextBoxPositioner.Mode.Centered:
          return this.currentOffset;
        case TutorialTextBoxPositioner.Mode.AnchoredToBottom:
          return (Object) this.canvas == (Object) null ? Vector3.zero : new Vector3(0.0f, (float) (-(double) this.canvas.GetComponent<RectTransform>().sizeDelta.y * 0.5 + (double) y * 0.5), 0.0f) + this.currentOffset;
        case TutorialTextBoxPositioner.Mode.AnchoredToPlayer:
          if ((Object) this.canvas == (Object) null)
            return Vector3.zero;
          Vector2 screenPoint = RectTransformUtility.WorldToScreenPoint(ImiServices.Instance.CameraManager.GetCamera(Imi.SteelCircus.CameraSystem.CameraType.InGameCamera).GetComponent<InGameCameraBehaviour>().Camera.GetMain(), Contexts.sharedInstance.game.GetFirstLocalEntity().unityView.gameObject.transform.position);
          Vector2 localPoint;
          RectTransformUtility.ScreenPointToLocalPointInRectangle(this.canvas.GetComponent<RectTransform>(), screenPoint, (Camera) null, out localPoint);
          float b = (float) (-(double) this.canvas.GetComponent<RectTransform>().sizeDelta.y * 0.5 + (double) y * 0.5 - (double) this.currentOffset.y + 150.0);
          localPoint.y = Mathf.Max(localPoint.y, b);
          return new Vector3(localPoint.x, localPoint.y, 0.0f) + this.currentOffset;
        default:
          return Vector3.zero;
      }
    }

    public enum Mode
    {
      Centered,
      AnchoredToBottom,
      AnchoredToPlayer,
    }
  }
}
