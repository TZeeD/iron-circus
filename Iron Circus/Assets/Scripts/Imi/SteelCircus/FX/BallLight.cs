// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.FX.BallLight
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace Imi.SteelCircus.FX
{
  public class BallLight : MonoBehaviour
  {
    [SerializeField]
    private Rigidbody ball;
    [SerializeField]
    private Light ballLight;
    public float rangeAtHit = 305f;
    public float intensityAtHit = 3f;
    public float rangeNormal = 55f;
    public float intensityNormal = 1f;
    public float hitDuration = 1f;
    public float threshold = 1f;
    private float hitCounter;
    private Vector3 lastVelocity = Vector3.zero;

    private void FixedUpdate()
    {
      Vector3 velocity = this.ball.velocity;
      if ((double) (velocity - this.lastVelocity).magnitude * (double) Time.deltaTime > (double) this.threshold)
        this.hitCounter = this.hitDuration;
      this.lastVelocity = velocity;
      this.hitCounter -= Time.deltaTime;
      if ((double) this.hitCounter < 0.0)
        this.hitCounter = 0.0f;
      this.ballLight.intensity = Mathf.Lerp(this.intensityNormal, this.intensityAtHit, this.hitCounter / this.hitDuration);
      this.ballLight.range = Mathf.Lerp(this.rangeNormal, this.rangeAtHit, this.hitCounter / this.hitDuration);
    }
  }
}
