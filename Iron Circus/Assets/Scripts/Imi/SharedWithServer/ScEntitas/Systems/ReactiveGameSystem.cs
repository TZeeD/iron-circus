// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Systems.ReactiveGameSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;

namespace Imi.SharedWithServer.ScEntitas.Systems
{
  public abstract class ReactiveGameSystem : ReactiveSystem<GameEntity>
  {
    protected GameContext gameContext;

    protected ReactiveGameSystem(EntitasSetup entitasSetup)
      : base((IContext<GameEntity>) entitasSetup.Contexts.game)
    {
      this.gameContext = entitasSetup.Contexts.game;
    }
  }
}
