// Decompiled with JetBrains decompiler
// Type: SharedWithServer.ScEntitas.Systems.Gameplay.CameraTargetSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.ScEntitas;
using Imi.SharedWithServer.ScEntitas.Systems;
using Imi.SteelCircus.JitterUnity;
using Jitter.LinearMath;
using UnityEngine;

namespace SharedWithServer.ScEntitas.Systems.Gameplay
{
  public class CameraTargetSystem : ExecuteGameSystem
  {
    public CameraTargetSystem(EntitasSetup entitasSetup)
      : base(entitasSetup)
    {
    }

    protected override void GameExecute()
    {
      GameEntity firstLocalEntity = this.gameContext.GetFirstLocalEntity();
      if (!this.gameContext.hasCameraTarget || firstLocalEntity == null || this.gameContext.cameraTarget.overrideInProgress || !firstLocalEntity.hasUnityView)
        return;
      this.gameContext.ReplaceCameraTarget(firstLocalEntity.unityView.gameObject.transform.position.ToJVector(), false);
      if (!firstLocalEntity.hasDeath || !firstLocalEntity.hasUnityView)
        return;
      float num1 = 1f;
      float num2 = 1f;
      float num3 = firstLocalEntity.death.respawnDuration - num1 - num2;
      JVector position = this.gameContext.ballEntity.transform.position;
      if ((double) firstLocalEntity.death.lerpFactor >= (double) firstLocalEntity.death.respawnDuration)
        return;
      if ((double) firstLocalEntity.death.lerpFactor <= (double) num1)
      {
        float t = firstLocalEntity.death.lerpFactor / num1;
        this.gameContext.ReplaceCameraTarget(JVector.Lerp(firstLocalEntity.death.lastPlayerPosition, position, t), false);
      }
      else if ((double) firstLocalEntity.death.lerpFactor <= (double) num3 + (double) num1)
        this.gameContext.ReplaceCameraTarget(position, false);
      else if ((double) firstLocalEntity.death.lerpFactor <= (double) firstLocalEntity.death.respawnDuration)
      {
        float t = (firstLocalEntity.death.lerpFactor - num1 - num2) / num2;
        this.gameContext.ReplaceCameraTarget(JVector.Lerp(position, firstLocalEntity.death.playerSpawnPoint, t), false);
      }
      firstLocalEntity.death.lerpFactor += Time.deltaTime;
    }
  }
}
