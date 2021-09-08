// Decompiled with JetBrains decompiler
// Type: FireworksExplosionAudioTrigger
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

public class FireworksExplosionAudioTrigger : MonoBehaviour
{
  private ParticleSystem myParticleSystem;
  private ParticleSystem.SubEmittersModule mySubEmitter;

  private void Start()
  {
    this.myParticleSystem = this.GetComponent<ParticleSystem>();
    this.mySubEmitter = this.myParticleSystem.subEmitters;
  }

  private void Update()
  {
    int num = this.mySubEmitter.GetSubEmitterSystem(0).isEmitting ? 1 : 0;
  }
}
