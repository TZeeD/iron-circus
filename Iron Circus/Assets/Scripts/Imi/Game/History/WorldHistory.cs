// Decompiled with JetBrains decompiler
// Type: Imi.Game.History.WorldHistory
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas;
using Imi.Utils;
using System.Collections.Generic;

namespace Imi.Game.History
{
  public class WorldHistory
  {
    private const int HistorySmallSize = 3600;
    private readonly IWorldHistoryStore<PlayerHistoryObject> playerStore;
    private readonly IWorldHistoryStore<BallHistoryObject> ballStore;
    private readonly WorldHistoryStoreDynamicEntityCountRing<TransformState> replicateStore;
    private RingBuffer<WorldHistoryInfo> storeInfoRing;
    private Dictionary<ulong, PlayerHistoryObject> zeroBaselinePlayers = new Dictionary<ulong, PlayerHistoryObject>();
    private GameContext gameContext;
    private IGroup<GameEntity> players;
    private IGroup<GameEntity> balls;
    private IGroup<GameEntity> replicate;

    public WorldHistory(int numPlayers, GameContext gameContext)
    {
      this.playerStore = (IWorldHistoryStore<PlayerHistoryObject>) new WorldHistoryStoreRing<PlayerHistoryObject>(numPlayers, 3600);
      this.ballStore = (IWorldHistoryStore<BallHistoryObject>) new WorldHistoryStoreRing<BallHistoryObject>(1, 3600);
      this.replicateStore = new WorldHistoryStoreDynamicEntityCountRing<TransformState>(3600);
      this.storeInfoRing = new RingBuffer<WorldHistoryInfo>(3600);
      this.gameContext = gameContext;
      this.players = gameContext.GetGroup((IMatcher<GameEntity>) GameMatcher.AllOf(GameMatcher.Player, GameMatcher.Transform, GameMatcher.StatusEffect));
      this.balls = gameContext.GetGroup((IMatcher<GameEntity>) GameMatcher.AllOf(GameMatcher.Ball, GameMatcher.Transform));
      this.replicate = gameContext.GetGroup(GameMatcher.Replicate);
    }

    public void RegisterPlayers(UniqueId[] uIds)
    {
      foreach (UniqueId uId in uIds)
        this.playerStore.InitializeStorageFor(uId);
    }

    public void RegisterPlayer(UniqueId uId) => this.playerStore.InitializeStorageFor(uId);

    public void AddZeroBaselinePlayer(GameEntity entity)
    {
      if (this.zeroBaselinePlayers.ContainsKey(entity.playerId.value))
        return;
      PlayerHistoryObject playerHistoryObject = new PlayerHistoryObject();
      playerHistoryObject.CopyFrom(entity, (IHistoryObject) null);
      this.zeroBaselinePlayers[entity.playerId.value] = playerHistoryObject;
    }

    public PlayerHistoryObject GetZeroBaselinePlayer(ulong playerId) => this.zeroBaselinePlayers[playerId];

    public void RegisterBall(UniqueId uid) => this.ballStore.InitializeStorageFor(uid);

    public void AddPlayerEntry(GameEntity entity, int tick, bool fromFuture = false) => this.playerStore.AddHistoryObject(tick, entity, fromFuture);

    public void AddBallEntry(GameEntity entity, int tick, bool fromFuture = false) => this.ballStore.AddHistoryObject(tick, entity, fromFuture);

    public void AddReplicateEntry(GameEntity entity, int tick, bool fromFuture = false) => this.replicateStore.AddHistoryObject(tick, entity, fromFuture, -1);

    public PlayerHistoryObject GetPlayerEntry(UniqueId uid, int tick) => this.playerStore.GetHistoryObject(tick, uid);

    public BallHistoryObject GetBallEntry(UniqueId uid, int tick) => this.ballStore.GetHistoryObject(tick, uid);

    public bool TryGetPlayerEntry(UniqueId uid, int tick, out PlayerHistoryObject obj) => this.playerStore.TryGetHistoryObject(tick, uid, out obj);

    public bool TryGetBallEntry(UniqueId uid, int tick, out BallHistoryObject obj) => this.ballStore.TryGetHistoryObject(tick, uid, out obj);

    public bool TryGetReplicatedEntry(UniqueId uid, int tick, out TransformState obj) => this.replicateStore.TryGetHistoryObject(tick, uid, out obj);

    private void AddHistoryObject<T>(
      IWorldHistoryStore<T> store,
      GameEntity entity,
      int tick,
      bool fromFuture = false,
      int copyFromReferenceTick = -1)
      where T : new()
    {
      store.AddHistoryObject(tick, entity, fromFuture, copyFromReferenceTick);
      this.SetHistoryInfoForTick(tick, fromFuture, copyFromReferenceTick);
    }

    public void Write(int tick, bool fromFuture, int copyFromReferenceTick = -1)
    {
      if (this.gameContext.matchState.value == Imi.SharedWithServer.Game.MatchState.WaitingForPlayers)
        return;
      foreach (GameEntity player in this.players)
        this.AddHistoryObject<PlayerHistoryObject>(this.playerStore, player, tick, fromFuture, copyFromReferenceTick);
      foreach (GameEntity ball in this.balls)
        this.AddHistoryObject<BallHistoryObject>(this.ballStore, ball, tick, fromFuture, copyFromReferenceTick);
      foreach (GameEntity entity in this.replicate)
        this.AddHistoryObject<TransformState>((IWorldHistoryStore<TransformState>) this.replicateStore, entity, tick, fromFuture, copyFromReferenceTick);
    }

    public void PatchLocalEnityt(int tick) => this.AddHistoryObject<PlayerHistoryObject>(this.playerStore, this.gameContext.GetFirstLocalEntity(), tick);

    public void Lock(int tick)
    {
      WorldHistoryInfo t = this.storeInfoRing.GetObject(tick);
      t.isLocked = true;
      this.storeInfoRing.SetObject(tick, t);
    }

    private void SetHistoryInfoForTick(int tick, bool fromFuture, int copyFromReferenceTick)
    {
      WorldHistoryInfo t = this.storeInfoRing.GetObject(tick);
      t.IncrementGeneration();
      if (t.generationCount == 1)
        t.firstWrittenIn = tick;
      if (fromFuture)
        t.fromFuture = true;
      t.copyFromReferenceTick = copyFromReferenceTick;
      t.lastWrittenIn = tick;
      this.storeInfoRing.SetObject(tick, t);
    }
  }
}
