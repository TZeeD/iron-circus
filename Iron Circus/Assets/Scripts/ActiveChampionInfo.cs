// Decompiled with JetBrains decompiler
// Type: ActiveChampionInfo
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using UnityEngine;

public class ActiveChampionInfo
{
  public ChampionConfig champion;
  public GameObject championGameObject;
  public Animator championAnimator;
  public ItemDefinition skin;

  public ActiveChampionInfo(
    ChampionConfig champion,
    GameObject championGameObject,
    ItemDefinition skin)
  {
    this.champion = champion;
    this.championGameObject = championGameObject;
    this.championAnimator = championGameObject.GetComponentInChildren<Animator>();
    this.skin = skin;
  }

  public bool Equals(ActiveChampionInfo toCompare) => (Object) toCompare.champion == (Object) this.champion && toCompare.skin.Equals(this.skin);
}
