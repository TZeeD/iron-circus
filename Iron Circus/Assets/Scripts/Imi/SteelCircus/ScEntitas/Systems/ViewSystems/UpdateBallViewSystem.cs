// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.ScEntitas.Systems.ViewSystems.UpdateBallViewSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.ScEntitas;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SharedWithServer.ScEntitas.Systems;
using Imi.SharedWithServer.Utils.Extensions;
using Imi.SteelCircus.JitterUnity;
using Jitter.LinearMath;
using UnityEngine;

namespace Imi.SteelCircus.ScEntitas.Systems.ViewSystems
{
  public class UpdateBallViewSystem : ExecuteGameSystem
  {
    private const float InterpolationDistance = 45f;

    public UpdateBallViewSystem(EntitasSetup entitasSetup)
      : base(entitasSetup)
    {
    }

    protected override void GameExecute()
    {
      GameEntity ballEntity = this.gameContext.ballEntity;
      GameEntity firstLocalEntity = this.gameContext.GetFirstLocalEntity();
      if (ballEntity == null || firstLocalEntity == null || ballEntity.hasBallOwner || !ballEntity.hasUnityView || !ballEntity.hasLastKnownRemoteTick)
        return;
      float t = (firstLocalEntity.transform.position - ballEntity.transform.position).Length().Clamp<float>(0.0f, 45f) / 45f;
      int ticks;
      float num1 = (float) (((double) (ticks = (int) MathExtensions.Interpolate((float) this.gameContext.globalTime.currentTick, (float) ballEntity.lastKnownRemoteTick.value, t)) - (double) ticks) / 30.0 * 1000.0);
      float num2 = this.gameContext.globalTime.timeSinceStartOfTick * 1000f;
      float sampleTime = ScTime.TicksToMillis(ticks, this.gameContext.globalTime.fixedSimTimeStep) + num1 + num2;
      JVector vector = ballEntity.positionTimeline.value.ValueAt(sampleTime);
      Quaternion rotation = Quaternion.Slerp(ballEntity.transform.rotation.ToQuaternion(), ballEntity.remoteTransform.value.rotation.ToQuaternion(), t);
      ballEntity.unityView.gameObject.transform.SetPositionAndRotation(vector.ToVector3(), rotation);
    }
  }
}
