// Decompiled with JetBrains decompiler
// Type: MetaEntity
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.Game;
using Imi.ScEntitas.Components;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SteelCircus.Networking;
using SteelCircus.ScEntitas.Components;
using System.Collections.Generic;
using UnityEngine;

public sealed class MetaEntity : Entity
{
  private static readonly MetaIsArenaLoadedComponent metaIsArenaLoadedComponent = new MetaIsArenaLoadedComponent();
  private static readonly MetaIsChampionUnlockedDataLoaded metaIsChampionUnlockedDataLoadedComponent = new MetaIsChampionUnlockedDataLoaded();
  private static readonly MetaIsConnectedComponent metaIsConnectedComponent = new MetaIsConnectedComponent();
  private static readonly MetaIsReadyComponent metaIsReadyComponent = new MetaIsReadyComponent();
  private static readonly MetaIsTokenVerifiedComponent metaIsTokenVerifiedComponent = new MetaIsTokenVerifiedComponent();

  public MetaChampionsUnlockedComponent metaChampionsUnlocked => (MetaChampionsUnlockedComponent) this.GetComponent(0);

  public bool hasMetaChampionsUnlocked => this.HasComponent(0);

  public void AddMetaChampionsUnlocked(
    Dictionary<ChampionType, bool> newChampionLockStateDict,
    Dictionary<ChampionType, bool> newChampionRotationStateDict)
  {
    int index = 0;
    MetaChampionsUnlockedComponent component = this.CreateComponent<MetaChampionsUnlockedComponent>(index);
    component.championLockStateDict = newChampionLockStateDict;
    component.championRotationStateDict = newChampionRotationStateDict;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceMetaChampionsUnlocked(
    Dictionary<ChampionType, bool> newChampionLockStateDict,
    Dictionary<ChampionType, bool> newChampionRotationStateDict)
  {
    int index = 0;
    MetaChampionsUnlockedComponent component = this.CreateComponent<MetaChampionsUnlockedComponent>(index);
    component.championLockStateDict = newChampionLockStateDict;
    component.championRotationStateDict = newChampionRotationStateDict;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveMetaChampionsUnlocked() => this.RemoveComponent(0);

  public bool isMetaIsArenaLoaded
  {
    get => this.HasComponent(1);
    set
    {
      if (value == this.isMetaIsArenaLoaded)
        return;
      int index = 1;
      if (value)
      {
        Stack<IComponent> componentPool = this.GetComponentPool(index);
        IComponent component = componentPool.Count > 0 ? componentPool.Pop() : (IComponent) MetaEntity.metaIsArenaLoadedComponent;
        this.AddComponent(index, component);
      }
      else
        this.RemoveComponent(index);
    }
  }

  public bool isMetaIsChampionUnlockedDataLoaded
  {
    get => this.HasComponent(2);
    set
    {
      if (value == this.isMetaIsChampionUnlockedDataLoaded)
        return;
      int index = 2;
      if (value)
      {
        Stack<IComponent> componentPool = this.GetComponentPool(index);
        IComponent component = componentPool.Count > 0 ? componentPool.Pop() : (IComponent) MetaEntity.metaIsChampionUnlockedDataLoadedComponent;
        this.AddComponent(index, component);
      }
      else
        this.RemoveComponent(index);
    }
  }

  public bool isMetaIsConnected
  {
    get => this.HasComponent(3);
    set
    {
      if (value == this.isMetaIsConnected)
        return;
      int index = 3;
      if (value)
      {
        Stack<IComponent> componentPool = this.GetComponentPool(index);
        IComponent component = componentPool.Count > 0 ? componentPool.Pop() : (IComponent) MetaEntity.metaIsConnectedComponent;
        this.AddComponent(index, component);
      }
      else
        this.RemoveComponent(index);
    }
  }

  public bool isMetaIsReady
  {
    get => this.HasComponent(4);
    set
    {
      if (value == this.isMetaIsReady)
        return;
      int index = 4;
      if (value)
      {
        Stack<IComponent> componentPool = this.GetComponentPool(index);
        IComponent component = componentPool.Count > 0 ? componentPool.Pop() : (IComponent) MetaEntity.metaIsReadyComponent;
        this.AddComponent(index, component);
      }
      else
        this.RemoveComponent(index);
    }
  }

  public bool isMetaIsTokenVerified
  {
    get => this.HasComponent(5);
    set
    {
      if (value == this.isMetaIsTokenVerified)
        return;
      int index = 5;
      if (value)
      {
        Stack<IComponent> componentPool = this.GetComponentPool(index);
        IComponent component = componentPool.Count > 0 ? componentPool.Pop() : (IComponent) MetaEntity.metaIsTokenVerifiedComponent;
        this.AddComponent(index, component);
      }
      else
        this.RemoveComponent(index);
    }
  }

  public MetaLoadoutComponent metaLoadout => (MetaLoadoutComponent) this.GetComponent(11);

  public bool hasMetaLoadout => this.HasComponent(11);

  public void AddMetaLoadout(
    int newAvatarIconId,
    Sprite newAvatarIconSprite,
    Dictionary<ChampionType, ChampionLoadout> newItemLoadouts)
  {
    int index = 11;
    MetaLoadoutComponent component = this.CreateComponent<MetaLoadoutComponent>(index);
    component.avatarIconId = newAvatarIconId;
    component.avatarIconSprite = newAvatarIconSprite;
    component.itemLoadouts = newItemLoadouts;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceMetaLoadout(
    int newAvatarIconId,
    Sprite newAvatarIconSprite,
    Dictionary<ChampionType, ChampionLoadout> newItemLoadouts)
  {
    int index = 11;
    MetaLoadoutComponent component = this.CreateComponent<MetaLoadoutComponent>(index);
    component.avatarIconId = newAvatarIconId;
    component.avatarIconSprite = newAvatarIconSprite;
    component.itemLoadouts = newItemLoadouts;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveMetaLoadout() => this.RemoveComponent(11);

  public MetaMatchComponent metaMatch => (MetaMatchComponent) this.GetComponent(6);

  public bool hasMetaMatch => this.HasComponent(6);

  public void AddMetaMatch(
    string newMatchId,
    string newGameSessionId,
    string newCurrentArena,
    GameType newGameType,
    bool newIsOvertime,
    bool newWasMatchAborted)
  {
    int index = 6;
    MetaMatchComponent component = this.CreateComponent<MetaMatchComponent>(index);
    component.matchId = newMatchId;
    component.gameSessionId = newGameSessionId;
    component.currentArena = newCurrentArena;
    component.gameType = newGameType;
    component.isOvertime = newIsOvertime;
    component.wasMatchAborted = newWasMatchAborted;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceMetaMatch(
    string newMatchId,
    string newGameSessionId,
    string newCurrentArena,
    GameType newGameType,
    bool newIsOvertime,
    bool newWasMatchAborted)
  {
    int index = 6;
    MetaMatchComponent component = this.CreateComponent<MetaMatchComponent>(index);
    component.matchId = newMatchId;
    component.gameSessionId = newGameSessionId;
    component.currentArena = newCurrentArena;
    component.gameType = newGameType;
    component.isOvertime = newIsOvertime;
    component.wasMatchAborted = newWasMatchAborted;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveMetaMatch() => this.RemoveComponent(6);

  public MetaNetworkComponent metaNetwork => (MetaNetworkComponent) this.GetComponent(12);

  public bool hasMetaNetwork => this.HasComponent(12);

  public void AddMetaNetwork(SteelClient newValue)
  {
    int index = 12;
    MetaNetworkComponent component = this.CreateComponent<MetaNetworkComponent>(index);
    component.value = newValue;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceMetaNetwork(SteelClient newValue)
  {
    int index = 12;
    MetaNetworkComponent component = this.CreateComponent<MetaNetworkComponent>(index);
    component.value = newValue;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveMetaNetwork() => this.RemoveComponent(12);

  public MetaPickOrderComponent metaPickOrder => (MetaPickOrderComponent) this.GetComponent(7);

  public bool hasMetaPickOrder => this.HasComponent(7);

  public void AddMetaPickOrder(
    int newCurrentPickerIndex,
    int[,] newPlayerPickTimings,
    UniqueId[] newAlphaPickOrder,
    UniqueId[] newBetaPickOrder)
  {
    int index = 7;
    MetaPickOrderComponent component = this.CreateComponent<MetaPickOrderComponent>(index);
    component.currentPickerIndex = newCurrentPickerIndex;
    component.playerPickTimings = newPlayerPickTimings;
    component.alphaPickOrder = newAlphaPickOrder;
    component.betaPickOrder = newBetaPickOrder;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceMetaPickOrder(
    int newCurrentPickerIndex,
    int[,] newPlayerPickTimings,
    UniqueId[] newAlphaPickOrder,
    UniqueId[] newBetaPickOrder)
  {
    int index = 7;
    MetaPickOrderComponent component = this.CreateComponent<MetaPickOrderComponent>(index);
    component.currentPickerIndex = newCurrentPickerIndex;
    component.playerPickTimings = newPlayerPickTimings;
    component.alphaPickOrder = newAlphaPickOrder;
    component.betaPickOrder = newBetaPickOrder;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveMetaPickOrder() => this.RemoveComponent(7);

  public MetaPlayerIdComponent metaPlayerId => (MetaPlayerIdComponent) this.GetComponent(8);

  public bool hasMetaPlayerId => this.HasComponent(8);

  public void AddMetaPlayerId(ulong newValue)
  {
    int index = 8;
    MetaPlayerIdComponent component = this.CreateComponent<MetaPlayerIdComponent>(index);
    component.value = newValue;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceMetaPlayerId(ulong newValue)
  {
    int index = 8;
    MetaPlayerIdComponent component = this.CreateComponent<MetaPlayerIdComponent>(index);
    component.value = newValue;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveMetaPlayerId() => this.RemoveComponent(8);

  public MetaStateComponent metaState => (MetaStateComponent) this.GetComponent(9);

  public bool hasMetaState => this.HasComponent(9);

  public void AddMetaState(MetaState newValue)
  {
    int index = 9;
    MetaStateComponent component = this.CreateComponent<MetaStateComponent>(index);
    component.value = newValue;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceMetaState(MetaState newValue)
  {
    int index = 9;
    MetaStateComponent component = this.CreateComponent<MetaStateComponent>(index);
    component.value = newValue;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveMetaState() => this.RemoveComponent(9);

  public MetaTeamComponent metaTeam => (MetaTeamComponent) this.GetComponent(10);

  public bool hasMetaTeam => this.HasComponent(10);

  public void AddMetaTeam(Team newValue)
  {
    int index = 10;
    MetaTeamComponent component = this.CreateComponent<MetaTeamComponent>(index);
    component.value = newValue;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceMetaTeam(Team newValue)
  {
    int index = 10;
    MetaTeamComponent component = this.CreateComponent<MetaTeamComponent>(index);
    component.value = newValue;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveMetaTeam() => this.RemoveComponent(10);

  public MetaUsernameComponent metaUsername => (MetaUsernameComponent) this.GetComponent(13);

  public bool hasMetaUsername => this.HasComponent(13);

  public void AddMetaUsername(string newValue)
  {
    int index = 13;
    MetaUsernameComponent component = this.CreateComponent<MetaUsernameComponent>(index);
    component.value = newValue;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceMetaUsername(string newValue)
  {
    int index = 13;
    MetaUsernameComponent component = this.CreateComponent<MetaUsernameComponent>(index);
    component.value = newValue;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveMetaUsername() => this.RemoveComponent(13);
}
