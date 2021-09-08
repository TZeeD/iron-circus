// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.SlamImpactFX
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SharedWithServer.ScEvents;
using UnityEngine;

namespace SteelCircus.FX.Skills
{
  public class SlamImpactFX : MonoBehaviour
  {
    [SerializeField]
    private ParticleSystem sparkParticles;
    [SerializeField]
    private Animator stompAnimator;
    [SerializeField]
    private MeshRenderer smokeRenderer;
    [SerializeField]
    private MeshRenderer shockwaveRenderer;
    private const float duration = 1.5f;
    private float counter;
    public bool debugDontDestroy;

    private void Awake()
    {
      this.smokeRenderer.material = Object.Instantiate<Material>(this.smokeRenderer.material);
      this.shockwaveRenderer.material = Object.Instantiate<Material>(this.shockwaveRenderer.material);
    }

    private void Start()
    {
      this.Restart();
      if (!this.debugDontDestroy)
        return;
      this.SetRange(4.5f);
    }

    public void SetRange(float radius)
    {
      this.smokeRenderer.transform.localScale = new Vector3(radius, this.smokeRenderer.transform.localScale.y, radius);
      this.shockwaveRenderer.transform.localScale = new Vector3(radius, this.shockwaveRenderer.transform.localScale.y, radius);
    }

    private void Update()
    {
      if ((double) this.counter > 1.5)
      {
        if (this.debugDontDestroy)
          this.Restart();
        else
          Object.Destroy((Object) this.gameObject);
      }
      else
        this.counter += Time.deltaTime;
    }

    private void Restart()
    {
      this.stompAnimator.Play("StompAnimation", 0, 0.0f);
      this.sparkParticles.Stop();
      this.sparkParticles.Play();
      this.counter = 0.0f;
      Events.Global.FireEventCameraShake(this.smokeRenderer.transform, 0.5f);
    }
  }
}
