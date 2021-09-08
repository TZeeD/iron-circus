// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Utils.IInspectorClient
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.ScEntitas.Components;
using Jitter.LinearMath;
using System.Net;

namespace Imi.SharedWithServer.Utils
{
  public interface IInspectorClient
  {
    void Start(bool server, ulong _playerId, IPAddress serverIp = null, bool _writeLocalFile = false);

    void Stop();

    void OnSessionStart(string sessionId);

    bool IsStarted { get; }

    void Flush();

    void TickBegin(int tick, float time);

    void TickEnd();

    void OnMispredict(
      int baseline,
      int remoteTick,
      int clientTick,
      int mispredictReason,
      string debugData);

    void OnJumpToFuture(int currentTick, int remoteTick);

    void SetInput(ulong playerId, JVector moveDir, int buttonType);

    void SetTransform(ulong playerId, JVector pos, JVector rotEuler, JVector vel);

    void SetStateMachines(ulong playerId, SerializedSkillGraphs sm);

    void SetStatusEffects(ulong playerId, SerializedStatusEffects se);

    void SetAnimationStates(ulong playerId, AnimationStates ani);

    void OnInputDuplicate(ulong playerId, int lastKnownInputTick);

    void SectionBegin(string name, int tick);

    void SectionEnd(string name);

    void SendLog(string msg);

    void ReportMemory();

    void SendAsync(InspectorClient.DataType type, byte[] data, int dataSize);
  }
}
