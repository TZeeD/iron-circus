// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Audio.FootstepAudioHelper
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using UnityEngine;

namespace Imi.SteelCircus.Audio
{
  public class FootstepAudioHelper : MonoBehaviour
  {
    [Header("Right Foot")]
    [SerializeField]
    private AudioClip rightFootstep;
    [SerializeField]
    private float rightScale;
    [Header("Left Foot")]
    [SerializeField]
    private AudioClip leftFootstep;
    [SerializeField]
    private float leftScale;
    [Space]
    [SerializeField]
    private AudioSource playerAudioSource;

    public void Start()
    {
      if (!((Object) this.playerAudioSource == (Object) null))
        return;
      Log.Warning("No AudioSource was found on the player object.");
    }

    public void FootstepRight()
    {
    }

    public void FootstepLeft()
    {
    }

    private void PlayOnAudioSource(AudioClip clip, float scale)
    {
      if (!((Object) this.playerAudioSource != (Object) null))
        return;
      this.playerAudioSource.PlayOneShot(clip, scale);
    }
  }
}
