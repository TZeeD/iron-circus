// Decompiled with JetBrains decompiler
// Type: PlayerSpawnView
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.GameElements;
using UnityEngine;

public class PlayerSpawnView : FloorSpawnableObject
{
  [SerializeField]
  private float radius = 1.2f;
  [SerializeField]
  private string audioKey = "PlayerSpawn";

  public void RespawnPlayerEffect()
  {
    this.Spawn(this.radius);
    if (string.IsNullOrEmpty(this.audioKey))
      return;
    AudioController.Play(this.audioKey, this.transform);
  }

  public void RespawnPlayerEffect(Vector3 pos)
  {
    this.Spawn(new Vector3(pos.x, 0.0f, pos.z), this.radius);
    if (string.IsNullOrEmpty(this.audioKey))
      return;
    AudioController.Play(this.audioKey, this.transform);
  }
}
