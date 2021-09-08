// Decompiled with JetBrains decompiler
// Type: OffscreenObjectIndicator
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.UI;

public class OffscreenObjectIndicator : MonoBehaviour
{
  public GameObject objectToIndicate;
  public Camera cameraToUse;
  public float pixelsFromScreenBorder = 10f;
  public GameObject graphic;
  private bool isVisible;
  private Canvas canvas;
  [SerializeField]
  private Image arrowImg;
  [SerializeField]
  private Image circleImg;
  private float minAlpha = 0.5f;
  private float maxAlpha = 1f;
  private float blinkFrequency = 3f;
  private float blinkCounter;
  private Color color;

  private void Start()
  {
    if ((Object) this.objectToIndicate != (Object) null)
      this.graphic.gameObject.SetActive(false);
    this.SetColor(Color.white);
  }

  private void Update()
  {
    if ((Object) this.cameraToUse == (Object) null)
      this.cameraToUse = Camera.main;
    if ((Object) this.canvas == (Object) null)
      this.canvas = this.GetComponentInParent<Canvas>();
    if ((Object) this.cameraToUse != (Object) null && (Object) this.objectToIndicate != (Object) null && (Object) this.canvas != (Object) null)
    {
      bool flag = this.IsPositionOnScreen(this.objectToIndicate.transform.position);
      if (this.isVisible != flag)
      {
        this.isVisible = flag;
        this.graphic.gameObject.SetActive(!this.isVisible);
      }
      if (!this.isVisible)
      {
        this.SetRotation();
        this.SetPosition();
      }
    }
    Color color = this.color;
    this.blinkCounter += Time.deltaTime * this.blinkFrequency;
    float t = Mathf.Pow(Mathf.Clamp01((float) (1.0 - (double) this.blinkCounter % 1.0)), 0.5f);
    color.a = Mathf.Lerp(this.minAlpha, this.maxAlpha, t);
    this.arrowImg.color = color;
    this.circleImg.color = color;
  }

  public void SetColor(Color col) => this.color = col;

  private void SetRotation()
  {
    Vector3 normalized = this.ProjectOntoCameraXY(this.objectToIndicate.transform.position - this.cameraToUse.transform.position).normalized;
    this.graphic.transform.localEulerAngles = new Vector3(0.0f, 0.0f, -(Mathf.Atan2(normalized.x, normalized.y) * 57.29578f));
  }

  private void SetPosition()
  {
    Vector3 screenPoint = this.cameraToUse.WorldToScreenPoint(this.objectToIndicate.transform.position);
    screenPoint.x = Mathf.Clamp(screenPoint.x, 0.0f, (float) Screen.width);
    screenPoint.y = Mathf.Clamp(screenPoint.y, 0.0f, (float) Screen.height);
    Vector2 localPoint;
    RectTransformUtility.ScreenPointToLocalPointInRectangle(this.graphic.transform.parent as RectTransform, (Vector2) screenPoint, this.cameraToUse, out localPoint);
    ref Vector2 local1 = ref localPoint;
    double x = (double) screenPoint.x;
    Rect pixelRect1 = this.canvas.pixelRect;
    double num1 = (double) pixelRect1.xMin + (double) this.pixelsFromScreenBorder;
    pixelRect1 = this.canvas.pixelRect;
    double num2 = (double) pixelRect1.xMax - (double) this.pixelsFromScreenBorder;
    double num3 = (double) Mathf.Clamp((float) x, (float) num1, (float) num2);
    local1.x = (float) num3;
    ref Vector2 local2 = ref localPoint;
    double y = (double) screenPoint.y;
    Rect pixelRect2 = this.canvas.pixelRect;
    double num4 = (double) pixelRect2.yMin + (double) this.pixelsFromScreenBorder;
    pixelRect2 = this.canvas.pixelRect;
    double num5 = (double) pixelRect2.yMax - (double) this.pixelsFromScreenBorder;
    double num6 = (double) Mathf.Clamp((float) y, (float) num4, (float) num5);
    local2.y = (float) num6;
    this.graphic.transform.position = (Vector3) localPoint;
  }

  private Vector3 ProjectOntoCameraXY(Vector3 vector) => new Vector3(Vector3.Dot(this.cameraToUse.transform.right, vector), Vector3.Dot(this.cameraToUse.transform.up, vector), 0.0f);

  private Vector3 GetScreenCenterAsWorldPosition(float zDistance) => this.cameraToUse.ScreenToWorldPoint(new Vector3((float) Screen.width / 2f, (float) Screen.height / 2f, zDistance));

  private bool IsPositionOnScreen(Vector3 position)
  {
    Vector3 screenPoint = this.cameraToUse.WorldToScreenPoint(position);
    return (double) screenPoint.x >= 0.0 && (double) screenPoint.x <= (double) Screen.width && (double) screenPoint.y >= 0.0 && (double) screenPoint.y <= (double) Screen.height;
  }
}
