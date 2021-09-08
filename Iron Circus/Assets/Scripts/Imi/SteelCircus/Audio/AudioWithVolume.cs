// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Audio.AudioWithVolume
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using UnityEngine;

namespace Imi.SteelCircus.Audio
{
  [Serializable]
  public class AudioWithVolume
  {
    public AudioClip clip;
    public bool is2d;
    [Range(0.0f, 1f)]
    public float volume;

    public static void PlayAudioClipWithVolume(AudioWithVolume audioWithVolume)
    {
      if (!((UnityEngine.Object) audioWithVolume.clip != (UnityEngine.Object) null))
        return;
      if (audioWithVolume.is2d)
        AudioManager.Instance.PlaySfx2D(audioWithVolume.clip, audioWithVolume.volume);
      else
        AudioManager.Instance.PlayClipAtPoint3D(audioWithVolume.clip, Vector3.zero, audioWithVolume.volume, 1f);
    }

    public static void PlayAudioClipWithVolume(AudioWithVolume audioWithVolume, Vector3 pos)
    {
      if (!((UnityEngine.Object) audioWithVolume.clip != (UnityEngine.Object) null))
        return;
      if (audioWithVolume.is2d)
        AudioManager.Instance.PlaySfx2D(audioWithVolume.clip, audioWithVolume.volume);
      else
        AudioManager.Instance.PlayClipAtPoint3D(audioWithVolume.clip, pos, audioWithVolume.volume, 1f);
    }

    public static void PlayAudioClipWithVolume(
      AudioWithVolume audioWithVolume,
      Vector3 pos,
      float minDistance,
      float maxDistance)
    {
      if (!((UnityEngine.Object) audioWithVolume.clip != (UnityEngine.Object) null))
        return;
      if (audioWithVolume.is2d)
        AudioManager.Instance.PlaySfx2D(audioWithVolume.clip, audioWithVolume.volume);
      else
        AudioManager.Instance.PlayClipAtPoint3D(audioWithVolume.clip, pos, audioWithVolume.volume, 1f, minDistance, maxDistance);
    }
  }
}
