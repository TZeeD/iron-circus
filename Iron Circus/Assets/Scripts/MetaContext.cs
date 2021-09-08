// Decompiled with JetBrains decompiler
// Type: MetaContext
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.Game;
using Imi.ScEntitas.Components;
using Imi.SharedWithServer.Game;
using Imi.SteelCircus.Networking;
using SteelCircus.ScEntitas.Components;
using System;

public sealed class MetaContext : Context<MetaEntity>
{
  public MetaEntity metaMatchEntity => this.GetGroup(MetaMatcher.MetaMatch).GetSingleEntity();

  public MetaMatchComponent metaMatch => this.metaMatchEntity.metaMatch;

  public bool hasMetaMatch => this.metaMatchEntity != null;

  public MetaEntity SetMetaMatch(
    string newMatchId,
    string newGameSessionId,
    string newCurrentArena,
    GameType newGameType,
    bool newIsOvertime,
    bool newWasMatchAborted)
  {
    if (this.hasMetaMatch)
      throw new EntitasException("Could not set MetaMatch!\n" + (object) this + " already has an entity with Imi.ScEntitas.Components.MetaMatchComponent!", "You should check if the context already has a metaMatchEntity before setting it or use context.ReplaceMetaMatch().");
    MetaEntity entity = this.CreateEntity();
    entity.AddMetaMatch(newMatchId, newGameSessionId, newCurrentArena, newGameType, newIsOvertime, newWasMatchAborted);
    return entity;
  }

  public void ReplaceMetaMatch(
    string newMatchId,
    string newGameSessionId,
    string newCurrentArena,
    GameType newGameType,
    bool newIsOvertime,
    bool newWasMatchAborted)
  {
    MetaEntity metaMatchEntity = this.metaMatchEntity;
    if (metaMatchEntity == null)
      this.SetMetaMatch(newMatchId, newGameSessionId, newCurrentArena, newGameType, newIsOvertime, newWasMatchAborted);
    else
      metaMatchEntity.ReplaceMetaMatch(newMatchId, newGameSessionId, newCurrentArena, newGameType, newIsOvertime, newWasMatchAborted);
  }

  public void RemoveMetaMatch() => this.metaMatchEntity.Destroy();

  public MetaEntity metaNetworkEntity => this.GetGroup(MetaMatcher.MetaNetwork).GetSingleEntity();

  public MetaNetworkComponent metaNetwork => this.metaNetworkEntity.metaNetwork;

  public bool hasMetaNetwork => this.metaNetworkEntity != null;

  public MetaEntity SetMetaNetwork(SteelClient newValue)
  {
    if (this.hasMetaNetwork)
      throw new EntitasException("Could not set MetaNetwork!\n" + (object) this + " already has an entity with SteelCircus.ScEntitas.Components.MetaNetworkComponent!", "You should check if the context already has a metaNetworkEntity before setting it or use context.ReplaceMetaNetwork().");
    MetaEntity entity = this.CreateEntity();
    entity.AddMetaNetwork(newValue);
    return entity;
  }

  public void ReplaceMetaNetwork(SteelClient newValue)
  {
    MetaEntity metaNetworkEntity = this.metaNetworkEntity;
    if (metaNetworkEntity == null)
      this.SetMetaNetwork(newValue);
    else
      metaNetworkEntity.ReplaceMetaNetwork(newValue);
  }

  public void RemoveMetaNetwork() => this.metaNetworkEntity.Destroy();

  public MetaEntity metaPickOrderEntity => this.GetGroup(MetaMatcher.MetaPickOrder).GetSingleEntity();

  public MetaPickOrderComponent metaPickOrder => this.metaPickOrderEntity.metaPickOrder;

  public bool hasMetaPickOrder => this.metaPickOrderEntity != null;

  public MetaEntity SetMetaPickOrder(
    int newCurrentPickerIndex,
    int[,] newPlayerPickTimings,
    UniqueId[] newAlphaPickOrder,
    UniqueId[] newBetaPickOrder)
  {
    if (this.hasMetaPickOrder)
      throw new EntitasException("Could not set MetaPickOrder!\n" + (object) this + " already has an entity with Imi.ScEntitas.Components.MetaPickOrderComponent!", "You should check if the context already has a metaPickOrderEntity before setting it or use context.ReplaceMetaPickOrder().");
    MetaEntity entity = this.CreateEntity();
    entity.AddMetaPickOrder(newCurrentPickerIndex, newPlayerPickTimings, newAlphaPickOrder, newBetaPickOrder);
    return entity;
  }

  public void ReplaceMetaPickOrder(
    int newCurrentPickerIndex,
    int[,] newPlayerPickTimings,
    UniqueId[] newAlphaPickOrder,
    UniqueId[] newBetaPickOrder)
  {
    MetaEntity metaPickOrderEntity = this.metaPickOrderEntity;
    if (metaPickOrderEntity == null)
      this.SetMetaPickOrder(newCurrentPickerIndex, newPlayerPickTimings, newAlphaPickOrder, newBetaPickOrder);
    else
      metaPickOrderEntity.ReplaceMetaPickOrder(newCurrentPickerIndex, newPlayerPickTimings, newAlphaPickOrder, newBetaPickOrder);
  }

  public void RemoveMetaPickOrder() => this.metaPickOrderEntity.Destroy();

  public MetaEntity metaStateEntity => this.GetGroup(MetaMatcher.MetaState).GetSingleEntity();

  public MetaStateComponent metaState => this.metaStateEntity.metaState;

  public bool hasMetaState => this.metaStateEntity != null;

  public MetaEntity SetMetaState(MetaState newValue)
  {
    if (this.hasMetaState)
      throw new EntitasException("Could not set MetaState!\n" + (object) this + " already has an entity with Imi.ScEntitas.Components.MetaStateComponent!", "You should check if the context already has a metaStateEntity before setting it or use context.ReplaceMetaState().");
    MetaEntity entity = this.CreateEntity();
    entity.AddMetaState(newValue);
    return entity;
  }

  public void ReplaceMetaState(MetaState newValue)
  {
    MetaEntity metaStateEntity = this.metaStateEntity;
    if (metaStateEntity == null)
      this.SetMetaState(newValue);
    else
      metaStateEntity.ReplaceMetaState(newValue);
  }

  public void RemoveMetaState() => this.metaStateEntity.Destroy();

  public MetaContext()
    : base(14, 0, new ContextInfo("Meta", MetaComponentsLookup.componentNames, MetaComponentsLookup.componentTypes), (Func<IEntity, IAERC>) (entity => (IAERC) new SafeAERC(entity)))
  {
  }
}
