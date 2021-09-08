// Decompiled with JetBrains decompiler
// Type: Imi.Game.History.WorldHistoryLog
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.Diagnostics;
using Imi.SharedWithServer.Utils;
using Jitter.LinearMath;
using System;
using System.Collections.Concurrent;
using System.Threading;

namespace Imi.Game.History
{
  public static class WorldHistoryLog
  {
    private static bool fileWriteEnabled = false;
    private static bool inspectorEnabled = false;
    private static int initCounter = 0;
    private static int lastWrittenTick = -1;
    private static BlockingCollection<WorldHistoryLog.LogItem> fileQueue = new BlockingCollection<WorldHistoryLog.LogItem>();
    private static CancellationTokenSource cancelCts = new CancellationTokenSource();
    private static CancellationToken cancelToken;
    private static string sessionId = "temp";
    private static IInspectorClient inspectorClient;
    private static Thread thread;

    public static bool IsEnabled() => WorldHistoryLog.fileWriteEnabled || WorldHistoryLog.inspectorEnabled;

    public static void Init(string _sessionId, IInspectorClient _inspectorClient)
    {
      if (!WorldHistoryLog.IsEnabled() || WorldHistoryLog.initCounter != 0)
        return;
      ++WorldHistoryLog.initCounter;
      WorldHistoryLog.sessionId = _sessionId;
      WorldHistoryLog.inspectorClient = _inspectorClient;
      WorldHistoryLog.cancelToken = WorldHistoryLog.cancelCts.Token;
      WorldHistoryLog.thread = new Thread(new ThreadStart(WorldHistoryLog.ProcessQueue));
      WorldHistoryLog.thread.Start();
    }

    public static void Exit()
    {
      if (!WorldHistoryLog.IsEnabled())
        return;
      --WorldHistoryLog.initCounter;
      if (WorldHistoryLog.initCounter != 0)
        return;
      WorldHistoryLog.cancelCts.Cancel();
      if (!WorldHistoryLog.fileWriteEnabled)
        return;
      WorldHistoryLog.fileQueue.CompleteAdding();
    }

    public static void WriteAsync(
      int tick,
      GameContext gameContext,
      WorldHistory worldHistory,
      bool isRewrite = false)
    {
      if (!WorldHistoryLog.IsEnabled())
        return;
      IGroup<GameEntity> group = gameContext.GetGroup((IMatcher<GameEntity>) GameMatcher.AllOf(GameMatcher.Player, GameMatcher.Transform, GameMatcher.StatusEffect, GameMatcher.SkillGraph));
      float timeSinceMatchStart = gameContext.globalTimeEntity.globalTime.timeSinceMatchStart;
      WorldHistoryLog.WriteAsync(tick, string.Format("Time: {0}", (object) timeSinceMatchStart), isRewrite);
      foreach (GameEntity gameEntity in group)
      {
        PlayerHistoryObject playerHistoryObject;
        if (worldHistory.TryGetPlayerEntry(gameEntity.uniqueId.id, tick, out playerHistoryObject))
        {
          if (WorldHistoryLog.fileWriteEnabled)
          {
            string str1 = playerHistoryObject.ToString();
            if (isRewrite)
              str1 = "_RW_" + str1;
            string str2 = "PlayerId: " + gameEntity.uniqueId.id.ToString() + "\n" + str1;
            WorldHistoryLog.WriteAsync(tick, str2, isRewrite);
          }
          if (WorldHistoryLog.inspectorEnabled)
          {
            ulong playerId = gameEntity.playerId.value;
            float roll;
            float pitch;
            float yaw;
            playerHistoryObject.TransformState.rotation.ToEulerAngle(out roll, out pitch, out yaw);
            WorldHistoryLog.inspectorClient.SetTransform(playerId, playerHistoryObject.TransformState.position, new JVector(roll, pitch, yaw), playerHistoryObject.TransformState.velocity);
            WorldHistoryLog.inspectorClient.SetStateMachines(playerId, playerHistoryObject.ChampionState.serializedSkillGraph);
            WorldHistoryLog.inspectorClient.SetStatusEffects(playerId, playerHistoryObject.ChampionState.serializedStatusEffects);
            WorldHistoryLog.inspectorClient.SetAnimationStates(playerId, playerHistoryObject.ChampionState.animationStates);
          }
        }
      }
    }

    public static void RewriteAsync(int tick, GameContext gameContext, WorldHistory worldHistory)
    {
    }

    public static void WriteLogAsync(int tick, string str)
    {
      if (!WorldHistoryLog.IsEnabled() || !WorldHistoryLog.fileWriteEnabled)
        return;
      WorldHistoryLog.FileWriteAsync(tick, "_LG_" + str);
    }

    private static void WriteAsync(int tick, string str, bool isRewrite)
    {
      if (!WorldHistoryLog.fileWriteEnabled)
        return;
      if (!isRewrite)
      {
        if (tick != WorldHistoryLog.lastWrittenTick && WorldHistoryLog.lastWrittenTick >= 0)
        {
          WorldHistoryLog.FileWriteAsync(WorldHistoryLog.lastWrittenTick, "======== EOT");
          WorldHistoryLog.FileWriteAsync(WorldHistoryLog.lastWrittenTick, "");
          WorldHistoryLog.lastWrittenTick = tick;
          WorldHistoryLog.FileWriteAsync(tick, "======== TICK START: ");
        }
        if (WorldHistoryLog.lastWrittenTick < 0)
          WorldHistoryLog.lastWrittenTick = tick;
      }
      WorldHistoryLog.FileWriteAsync(tick, str);
    }

    private static void FileWriteAsync(int tick, string str) => WorldHistoryLog.fileQueue.Add(new WorldHistoryLog.LogItem()
    {
      tick = tick,
      str = str
    });

    private static string GetLogFilename() => WorldHistoryLog.sessionId + ".txt";

    private static void ProcessQueue()
    {
      try
      {
        foreach (WorldHistoryLog.LogItem consuming in WorldHistoryLog.fileQueue.GetConsumingEnumerable(WorldHistoryLog.cancelToken))
        {
          string str1 = consuming.str;
          bool flag1 = str1.StartsWith("_RW_");
          bool flag2 = str1.StartsWith("_LG_");
          if (flag1 | flag2)
            str1 = str1.Substring(4);
          string str2 = str1;
          char[] chArray = new char[1]{ '\n' };
          foreach (string str3 in str2.Split(chArray))
          {
            if (!flag2)
            {
              int num = flag1 ? 1 : 0;
            }
          }
        }
      }
      catch (OperationCanceledException ex)
      {
        Log.Warning("Inspector client timeout.");
      }
    }

    private struct LogItem
    {
      public int tick;
      public string str;
    }
  }
}
