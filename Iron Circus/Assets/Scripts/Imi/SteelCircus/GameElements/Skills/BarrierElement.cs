// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.GameElements.Skills.BarrierElement
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.Audio;
using System.Collections;
using UnityEngine;

namespace Imi.SteelCircus.GameElements.Skills
{
  public class BarrierElement : MonoBehaviour
  {
    [SerializeField]
    private AnimationCurve scaleY;
    [SerializeField]
    private MeshRenderer forceField;
    [SerializeField]
    private float spawnPitch = 0.5f;
    [SerializeField]
    private float despawnPitch = 1.5f;
    [SerializeField]
    private float volume = 0.7f;
    [HideInInspector]
    public float growDuration = 1.5f;
    [HideInInspector]
    public float stayDuration = 1f;
    [HideInInspector]
    public bool shouldPlaySound;
    [HideInInspector]
    public AudioClip despawnClip;
    [HideInInspector]
    public AudioClip spawnClip;
    private float counter;
    private bool isRunningFlag;
    private Vector3 ogScale;

    private void Start()
    {
      this.ogScale = this.transform.localScale;
      this.transform.localScale = new Vector3(this.ogScale.x, 0.01f, this.ogScale.z);
      this.StartCoroutine(this.Grow());
      this.forceField.material.SetFloat("_UVScrollU", Random.Range(0.0f, 1f));
    }

    private void Update()
    {
      this.counter += Time.deltaTime;
      if ((double) this.counter < (double) this.stayDuration || this.isRunningFlag)
        return;
      this.isRunningFlag = true;
    }

    private IEnumerator Grow()
    {
      BarrierElement barrierElement = this;
      barrierElement.counter = 0.0f;
      barrierElement.PlaySound(barrierElement.spawnClip, barrierElement.spawnPitch);
      while ((double) barrierElement.counter <= (double) barrierElement.growDuration)
      {
        barrierElement.transform.localScale = new Vector3(barrierElement.ogScale.x, barrierElement.scaleY.Evaluate(barrierElement.counter / barrierElement.growDuration) * barrierElement.ogScale.y, barrierElement.ogScale.z);
        yield return (object) null;
      }
      barrierElement.transform.localScale = barrierElement.ogScale;
    }

    private IEnumerator GoAway()
    {
      BarrierElement barrierElement = this;
      barrierElement.PlaySound(barrierElement.despawnClip, barrierElement.despawnPitch);
      while ((double) barrierElement.counter <= (double) barrierElement.growDuration + (double) barrierElement.stayDuration)
      {
        float time = (float) (1.0 - ((double) barrierElement.counter - (double) barrierElement.stayDuration) / (double) barrierElement.growDuration);
        barrierElement.transform.localScale = new Vector3(barrierElement.ogScale.x, barrierElement.scaleY.Evaluate(time) * barrierElement.ogScale.y, barrierElement.ogScale.z);
        yield return (object) null;
      }
      Object.Destroy((Object) barrierElement.gameObject);
    }

    private void PlaySound(AudioClip clip, float pitch)
    {
      if (!this.shouldPlaySound || !((Object) clip != (Object) null))
        return;
      AudioManager.Instance.PlayClipAtPoint3D(clip, this.transform.position, this.volume, pitch, 2f);
    }
  }
}
