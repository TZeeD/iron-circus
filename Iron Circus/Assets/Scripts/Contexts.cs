// Decompiled with JetBrains decompiler
// Type: Contexts
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Entitas.CodeGeneration.Attributes;
using Imi.Game;
using Imi.ScEntitas.Components;
using Imi.SharedWithServer.ScEntitas.Components;
using Jitter.Dynamics;
using server.ScEntitas.Components;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;

public class Contexts : IContexts
{
  private static Contexts _sharedInstance;
  public const string MetaPlayerId = "MetaPlayerId";
  public const string PlayerId = "PlayerId";
  public const string PlayerTeam = "PlayerTeam";
  public const string Rigidbody = "Rigidbody";
  public const string TriggerEnterEventFirst = "TriggerEnterEventFirst";
  public const string TriggerEnterEventSecond = "TriggerEnterEventSecond";
  public const string TriggerEvent = "TriggerEvent";
  public const string TriggerExitEventFirst = "TriggerExitEventFirst";
  public const string TriggerExitEventSecond = "TriggerExitEventSecond";
  public const string TriggerStayEventFirst = "TriggerStayEventFirst";
  public const string TriggerStayEventSecond = "TriggerStayEventSecond";
  public const string UniqueId = "UniqueId";

  public static Contexts sharedInstance
  {
    get
    {
      if (Contexts._sharedInstance == null)
        Contexts._sharedInstance = new Contexts();
      return Contexts._sharedInstance;
    }
    set => Contexts._sharedInstance = value;
  }

  public GameContext game { get; set; }

  public MetaContext meta { get; set; }

  public IContext[] allContexts => new IContext[2]
  {
    (IContext) this.game,
    (IContext) this.meta
  };

  public Contexts()
  {
    this.game = new GameContext();
    this.meta = new MetaContext();
    foreach (MethodBase methodBase in ((IEnumerable<MethodInfo>) this.GetType().GetMethods()).Where<MethodInfo>((Func<MethodInfo, bool>) (method => Attribute.IsDefined((MemberInfo) method, typeof (PostConstructorAttribute)))))
      methodBase.Invoke((object) this, (object[]) null);
  }

  public void Reset()
  {
    foreach (IContext allContext in this.allContexts)
      allContext.Reset();
  }

  [PostConstructor]
  public void InitializeEntityIndices()
  {
    this.meta.AddEntityIndex((IEntityIndex) new PrimaryEntityIndex<MetaEntity, ulong>("MetaPlayerId", this.meta.GetGroup(MetaMatcher.MetaPlayerId), (Func<MetaEntity, IComponent, ulong>) ((e, c) => ((MetaPlayerIdComponent) c).value)));
    this.game.AddEntityIndex((IEntityIndex) new EntityIndex<GameEntity, ulong>("PlayerId", this.game.GetGroup(GameMatcher.PlayerId), (Func<GameEntity, IComponent, ulong>) ((e, c) => ((PlayerIdComponent) c).value)));
    this.game.AddEntityIndex((IEntityIndex) new EntityIndex<GameEntity, Team>("PlayerTeam", this.game.GetGroup(GameMatcher.PlayerTeam), (Func<GameEntity, IComponent, Team>) ((e, c) => ((PlayerTeamComponent) c).value)));
    this.game.AddEntityIndex((IEntityIndex) new EntityIndex<GameEntity, JRigidbody>("Rigidbody", this.game.GetGroup(GameMatcher.Rigidbody), (Func<GameEntity, IComponent, JRigidbody>) ((e, c) => ((RigidbodyComponent) c).value)));
    this.game.AddEntityIndex((IEntityIndex) new EntityIndex<GameEntity, JRigidbody>("TriggerEnterEventFirst", this.game.GetGroup(GameMatcher.TriggerEnterEvent), (Func<GameEntity, IComponent, JRigidbody>) ((e, c) => ((TriggerEnterEventComponent) c).first)));
    this.game.AddEntityIndex((IEntityIndex) new EntityIndex<GameEntity, JRigidbody>("TriggerEnterEventSecond", this.game.GetGroup(GameMatcher.TriggerEnterEvent), (Func<GameEntity, IComponent, JRigidbody>) ((e, c) => ((TriggerEnterEventComponent) c).second)));
    this.game.AddEntityIndex((IEntityIndex) new EntityIndex<GameEntity, JTriggerPair>("TriggerEvent", this.game.GetGroup(GameMatcher.TriggerEvent), (Func<GameEntity, IComponent, JTriggerPair>) ((e, c) => ((TriggerEventComponent) c).bodies)));
    this.game.AddEntityIndex((IEntityIndex) new EntityIndex<GameEntity, JRigidbody>("TriggerExitEventFirst", this.game.GetGroup(GameMatcher.TriggerExitEvent), (Func<GameEntity, IComponent, JRigidbody>) ((e, c) => ((TriggerExitEventComponent) c).first)));
    this.game.AddEntityIndex((IEntityIndex) new EntityIndex<GameEntity, JRigidbody>("TriggerExitEventSecond", this.game.GetGroup(GameMatcher.TriggerExitEvent), (Func<GameEntity, IComponent, JRigidbody>) ((e, c) => ((TriggerExitEventComponent) c).second)));
    this.game.AddEntityIndex((IEntityIndex) new EntityIndex<GameEntity, JRigidbody>("TriggerStayEventFirst", this.game.GetGroup(GameMatcher.TriggerStayEvent), (Func<GameEntity, IComponent, JRigidbody>) ((e, c) => ((TriggerStayEventComponent) c).first)));
    this.game.AddEntityIndex((IEntityIndex) new EntityIndex<GameEntity, JRigidbody>("TriggerStayEventSecond", this.game.GetGroup(GameMatcher.TriggerStayEvent), (Func<GameEntity, IComponent, JRigidbody>) ((e, c) => ((TriggerStayEventComponent) c).second)));
    this.game.AddEntityIndex((IEntityIndex) new EntityIndex<GameEntity, Imi.SharedWithServer.Game.UniqueId>("UniqueId", this.game.GetGroup(GameMatcher.UniqueId), (Func<GameEntity, IComponent, Imi.SharedWithServer.Game.UniqueId>) ((e, c) => ((UniqueIdComponent) c).id)));
  }

  public static bool HasSharedInstance => Contexts._sharedInstance != null;

  public static void ClearSharedInstance() => Contexts._sharedInstance = (Contexts) null;
}
