// Decompiled with JetBrains decompiler
// Type: LoadoutData
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using System;
using UnityEngine;

[Serializable]
public class LoadoutData
{
  public ChampionType type;
  public int skinId = int.MaxValue;
  public int victoryPose = int.MaxValue;
  public int goalAnimation = int.MaxValue;
  public int[] sprays = new int[4]
  {
    int.MaxValue,
    int.MaxValue,
    int.MaxValue,
    int.MaxValue
  };
  public int[] emotes = new int[4]
  {
    int.MaxValue,
    int.MaxValue,
    int.MaxValue,
    int.MaxValue
  };
  public GameObject skinAsset;
  public AnimationClip victoryPoseAsset;
  public AnimationClip goalAnimationAssets;
  public GameObject[] sprayAssets;
  public AnimationClip[] emoteAssets;

  public override string ToString() => this.type.ToString();
}
