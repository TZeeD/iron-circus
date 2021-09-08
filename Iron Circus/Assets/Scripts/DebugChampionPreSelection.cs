// Decompiled with JetBrains decompiler
// Type: DebugChampionPreSelection
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Game;
using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class DebugChampionPreSelection : MonoBehaviour
{
  public static ChampionType champion;
  private ChampionType[] championsArray;

  private void Start()
  {
    Dropdown component = this.GetComponent<Dropdown>();
    component.ClearOptions();
    component.AddOptions(this.GetChampions());
  }

  private void Update()
  {
  }

  private List<string> GetChampions()
  {
    List<string> stringList = new List<string>();
    this.championsArray = (ChampionType[]) Enum.GetValues(typeof (ChampionType));
    foreach (ChampionType champions in this.championsArray)
      stringList.Add(champions.ToString());
    return stringList;
  }

  public void SetChampion(int index)
  {
    ChampionType champions = this.championsArray[index];
    Log.Warning("Selected Champion is " + (object) champions + " - " + (object) index);
    DebugChampionPreSelection.champion = champions;
  }
}
