// Decompiled with JetBrains decompiler
// Type: AudioSpreadHandler
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using ClockStone;
using System;
using UnityEngine;

[Obsolete]
public class AudioSpreadHandler : SingletonManager<AudioSpreadHandler>
{
  public GameObject audioPrefabSpreadBlend;
  public GameObject audioPrefab3D;

  public AudioObject Play(string audioID, Transform parent, GameEntity entity)
  {
    int num = this.SetSpreadPrefabBasedOnLocalOrRemote(audioID, entity) ? 1 : 0;
    AudioObject audioObject = AudioController.Play(audioID, parent);
    if (num != 0)
      this.ResetSpreadPrefab(audioID);
    return audioObject;
  }

  private bool SetSpreadPrefabBasedOnLocalOrRemote(string audioID, GameEntity entity)
  {
    if (!entity.isLocalEntity)
      return false;
    AudioController.GetAudioItem(audioID).category.AudioObjectPrefab = this.audioPrefabSpreadBlend;
    return true;
  }

  private void ResetSpreadPrefab(string audioID) => AudioController.GetAudioItem(audioID).category.AudioObjectPrefab = this.audioPrefab3D;
}
