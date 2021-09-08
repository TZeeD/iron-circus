// Decompiled with JetBrains decompiler
// Type: SteelCircus.BallIndicator
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace SteelCircus
{
  [RequireComponent(typeof (LineRenderer))]
  public class BallIndicator : MonoBehaviour
  {
    private Transform ballTransform;
    private LineRenderer lineRenderer;

    private void Start()
    {
      this.lineRenderer = this.GetComponent<LineRenderer>();
      this.ballTransform = GameObject.FindGameObjectWithTag("Ball").transform;
    }

    private void Update()
    {
      this.transform.position = new Vector3(this.ballTransform.position.x, this.transform.position.y, this.ballTransform.position.z);
      this.lineRenderer.SetPosition(0, this.transform.position);
      this.lineRenderer.SetPosition(1, this.ballTransform.position);
    }
  }
}
