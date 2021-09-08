// Decompiled with JetBrains decompiler
// Type: RotateWithMouseDrag
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.Controls;
using SteelCircus.Core.Services;
using UnityEngine;
using UnityEngine.EventSystems;

public class RotateWithMouseDrag : MonoBehaviour, IDragHandler, IEventSystemHandler
{
  [SerializeField]
  private float rotateSpeed = 10f;
  [SerializeField]
  private GameObject rotateObject;
  private float startRotation;
  private Vector3 startWorldPos;
  private Vector3 currentWorldPos;
  private InputService input;
  private const string RotationAxisKey = "UIHorizontal_R";

  private void Start() => this.input = ImiServices.Instance.InputService;

  private void Update()
  {
    if ((double) this.input.GetAnalogInput(AnalogInput.UISecondaryScroll).x == 0.0 || !((Object) this.rotateObject != (Object) null))
      return;
    this.rotateObject.transform.Rotate(new Vector3(0.0f, (float) (-(double) this.input.GetAnalogInput(AnalogInput.UISecondaryScroll).x * (double) this.rotateSpeed * (double) Time.deltaTime * 10.0), 0.0f));
  }

  private void OnMouseDown()
  {
    this.startRotation = this.transform.localEulerAngles.y;
    this.startWorldPos = this.GetWorldClickPosition();
  }

  private void OnMouseDrag()
  {
    this.currentWorldPos = this.GetWorldClickPosition();
    Vector3 localEulerAngles = this.transform.localEulerAngles;
    Vector3 vector3 = this.currentWorldPos - this.startWorldPos;
    float num = vector3.sqrMagnitude * Mathf.Sign(vector3.x);
    localEulerAngles.y = this.startRotation + num;
    if ((Object) this.rotateObject != (Object) null)
      this.rotateObject.transform.localEulerAngles = localEulerAngles;
    else
      this.transform.localEulerAngles = localEulerAngles;
  }

  private Vector3 GetWorldClickPosition()
  {
    Vector3 mousePosition = Input.mousePosition;
    mousePosition.z = -this.rotateSpeed;
    return Camera.main.ScreenToWorldPoint(mousePosition);
  }

  public void OnDrag(PointerEventData eventData)
  {
    if (!((Object) this.rotateObject != (Object) null))
      return;
    this.rotateObject.transform.Rotate(new Vector3(0.0f, -eventData.delta.x, 0.0f));
  }
}
