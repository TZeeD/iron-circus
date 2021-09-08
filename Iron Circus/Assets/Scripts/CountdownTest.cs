// Decompiled with JetBrains decompiler
// Type: CountdownTest
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.ScEntitas;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SharedWithServer.ScEntitas.Systems;
using Imi.SteelCircus.Utils;
using SharedWithServer.ScEvents;
using System;
using System.IO;
using UnityEngine;

public class CountdownTest : MonoBehaviour
{
  public float spawnEvery = 5f;
  public float minLiveTime = 3f;
  public float maxLiveTime = 6f;
  private float currentT;
  public bool exit;
  private Entitas.Systems systems;
  private Contexts contexts;

  private void Start()
  {
    Console.SetOut((TextWriter) new ConsoleToDebug());
    this.contexts = new Contexts();
    Contexts.sharedInstance = this.contexts;
    this.contexts.game.SetGlobalTime(0.0f, 0.0f, 0, 0, 0.0f, false);
    this.systems = CountdownTest.CreateSystems(this.contexts);
    this.systems.Initialize();
    this.systems.Execute();
  }

  private void Update()
  {
    if ((double) this.currentT <= 0.0)
    {
      this.currentT = this.spawnEvery;
      this.contexts.game.CreateEntity().AddCountdownAction(CountdownAction.WithDuration(UnityEngine.Random.Range(this.minLiveTime, this.maxLiveTime)).WithFinishedAction((Action) (() => Debug.Log((object) "CountdownAction DONE"))).WithEarlyExitCondition((Func<bool>) (() => this.exit)).WithUpdateAction((Action<float, float>) ((t, deltaT) => Debug.Log((object) ("CurrentProgress: " + (object) t)))).DestoyEntityWhenDone().Create());
    }
    else
      this.currentT -= Time.deltaTime;
    this.contexts.game.globalTimeEntity.ReplaceGlobalTime(Time.deltaTime, this.contexts.game.globalTimeEntity.globalTime.timeSinceMatchStart + Time.deltaTime, this.contexts.game.globalTimeEntity.globalTime.currentTick + 1, 0, 0.0f, false);
    this.systems.Execute();
    this.systems.Cleanup();
  }

  private static Entitas.Systems CreateSystems(Contexts contexts) => new Entitas.Systems().Add((ISystem) new CountdownSystem(new EntitasSetup(contexts, (GameEntityFactory) null, (ConfigProvider) null, (Events) null)));
}
