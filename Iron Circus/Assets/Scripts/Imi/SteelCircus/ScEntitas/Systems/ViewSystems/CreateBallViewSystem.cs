// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.ScEntitas.Systems.ViewSystems.CreateBallViewSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Entitas.Unity;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.ScEntitas;
using Imi.SharedWithServer.ScEntitas.Systems;
using Imi.SteelCircus.GameElements;
using SteelCircus.Core;
using System.Collections.Generic;
using UnityEngine;

namespace Imi.SteelCircus.ScEntitas.Systems.ViewSystems
{
  public class CreateBallViewSystem : ReactiveGameSystem
  {
    private readonly BallConfig ballConfig;

    public CreateBallViewSystem(EntitasSetup entitasSetup)
      : base(entitasSetup)
    {
      this.ballConfig = entitasSetup.ConfigProvider.ballConfig;
      Debug.LogError((object) "CREATE BALL VIEW SYSTEM CTOR");
    }

    protected override ICollector<GameEntity> GetTrigger(
      IContext<GameEntity> context)
    {
      return context.CreateCollector<GameEntity>(GameMatcher.Ball.Added<GameEntity>());
    }

    protected override bool Filter(GameEntity entity)
    {
      Debug.LogError((object) "CREATE BALL VIEW SYSTEM GETTRIGGER");
      return entity.isBall;
    }

    protected override void Execute(List<GameEntity> entities)
    {
      Debug.LogError((object) "CREATE BALL VIEW SYSTEM EXECUTE");
      foreach (GameEntity entity in entities)
      {
        GameObject gameObject = MatchObjectsParent.Add(Object.Instantiate<GameObject>(Resources.Load<GameObject>("Prefabs/Gameplay/ball")));
        gameObject.Link((IEntity) entity, (IContext) this.gameContext);
        entity.AddUnityView(gameObject);
        gameObject.GetComponent<BallView>().SetBallConfig(this.ballConfig);
        entity.isAlignViewToBottom = true;
      }
    }

    public static void CreateBallView(GameContext gameContext, BallConfig ballConfig)
    {
      GameEntity ballEntity = gameContext.ballEntity;
      GameObject gameObject = MatchObjectsParent.Add(Object.Instantiate<GameObject>(Resources.Load<GameObject>("Prefabs/Gameplay/ball")));
      gameObject.Link((IEntity) ballEntity, (IContext) gameContext);
      ballEntity.AddUnityView(gameObject);
      gameObject.GetComponent<BallView>().SetBallConfig(ballConfig);
      ballEntity.isAlignViewToBottom = true;
    }
  }
}
