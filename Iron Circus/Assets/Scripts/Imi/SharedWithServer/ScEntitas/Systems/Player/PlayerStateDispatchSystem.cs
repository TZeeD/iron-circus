// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Systems.Player.PlayerStateDispatchSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.Diagnostics;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas.Components;
using SharedWithServer.ScEvents;
using System.Collections.Generic;
using System.Linq;

namespace Imi.SharedWithServer.ScEntitas.Systems.Player
{
  public class PlayerStateDispatchSystem : ReactiveGameSystem, ITearDownSystem, ISystem
  {
    private readonly Events events;

    public PlayerStateDispatchSystem(EntitasSetup entitasSetup)
      : base(entitasSetup)
    {
      this.events = entitasSetup.Events;
      this.events.OnEventPlayerStatusChanged += new Events.EventPlayerStatusChanged(this.OnPlayerStunnedMsg);
      Log.Debug("Instantiating PlayerStateDispatchSystem");
    }

    public void TearDown()
    {
      Log.Debug("Tearing down PlayerStateDispatchSystem");
      this.events.OnEventPlayerStatusChanged -= new Events.EventPlayerStatusChanged(this.OnPlayerStunnedMsg);
    }

    private void OnPlayerStunnedMsg(ulong playerId, ref StatusEffectComponent statusComponent)
    {
      Log.Debug("Got OnPlayerStunnedMsg (or any PlayerStatusMessage, really)");
      Log.Debug(string.Format("STATUS: Stunned: {0}, CtrlsSuspended: {1}", (object) statusComponent.HasEffect(StatusEffectType.Stun), (object) statusComponent.HasModifier(StatusModifier.BlockMove)));
      this.gameContext.GetFirstEntityWithPlayerId(playerId).ReplaceStatusEffect(statusComponent.effects.ToList<StatusEffect>(), statusComponent.modifierStack, statusComponent.effectStack);
    }

    protected override ICollector<GameEntity> GetTrigger(
      IContext<GameEntity> context)
    {
      return context.CreateCollector<GameEntity>(GameMatcher.StatusEffect);
    }

    protected override bool Filter(GameEntity entity) => entity.hasPlayerId;

    protected override void Execute(List<GameEntity> entities)
    {
    }
  }
}
