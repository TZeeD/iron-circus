// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.ScEntitas.Systems.ViewSystems.LocalPlayerVisualSmoothingSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.ScEntitas;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SharedWithServer.ScEntitas.Systems;
using Imi.SharedWithServer.Utils.Extensions;
using Imi.SteelCircus.JitterUnity;
using Imi.SteelCircus.ScriptableObjects;
using UnityEngine;

namespace Imi.SteelCircus.ScEntitas.Systems.ViewSystems
{
  public class LocalPlayerVisualSmoothingSystem : ExecuteGameSystem
  {
    private IGroup<GameEntity> localPlayers;
    private DebugConfig debugConfig;
    private LocalPlayerVisualSmoothingConfig smoothingConfig;
    private Vector3 entityPos0;
    private Quaternion entityRot0;
    private Vector3 entityPos1;
    private Quaternion entityRot1;
    private Vector3 entityPos2;
    private Quaternion entityRot2;
    private int currentTick;

    public LocalPlayerVisualSmoothingSystem(EntitasSetup entitasSetup)
      : base(entitasSetup)
    {
      this.localPlayers = this.gameContext.GetGroup((IMatcher<GameEntity>) GameMatcher.AllOf(GameMatcher.LocalEntity, GameMatcher.Transform, GameMatcher.LocalPlayerVisualSmoothing));
      this.debugConfig = entitasSetup.ConfigProvider.debugConfig;
      this.smoothingConfig = entitasSetup.ConfigProvider.visualSmoothingConfig;
    }

    protected override void GameExecute()
    {
      foreach (GameEntity localPlayer in this.localPlayers)
      {
        if (this.debugConfig.useNewVisualSmoothing)
        {
          if (this.currentTick != this.gameContext.globalTime.currentTick)
          {
            this.currentTick = this.gameContext.globalTime.currentTick;
            this.entityPos0 = this.entityPos1;
            this.entityRot0 = this.entityRot1;
            this.entityPos1 = this.entityPos2;
            this.entityRot1 = this.entityRot2;
            this.entityPos2 = localPlayer.transform.position.ToVector3();
            this.entityRot2 = localPlayer.transform.rotation.ToQuaternion();
          }
          this.InterpolateView(localPlayer);
        }
        else
        {
          this.SmooothLocalPlayer(localPlayer);
          this.InterpolateLocalPlayer(localPlayer);
        }
      }
    }

    private void SmoothLocalPlayer(GameEntity localEntity)
    {
      if (localEntity.IsDead() || localEntity.isPlayerRespawning)
      {
        Vector3 position = new Vector3(this.entityPos2.x, localEntity.unityView.gameObject.transform.position.y, this.entityPos2.z);
        localEntity.unityView.gameObject.transform.SetPositionAndRotation(position, this.entityRot2);
      }
      else if (localEntity.hasVisualSmoothing && !this.debugConfig.disableVisualSmoothing)
      {
        Vector3 position1 = localEntity.unityView.gameObject.transform.position;
        Vector3 vector3_1 = this.entityPos2 - position1;
        float num1 = localEntity.visualSmoothing.lerpFactor + Time.deltaTime / this.smoothingConfig.secondsToTopSpeed;
        float num2 = MathExtensions.Interpolate(0.0f, this.smoothingConfig.topSpeed, localEntity.visualSmoothing.lerpFactor = Mathf.Clamp01(num1));
        Vector3 vector3_2 = vector3_1.normalized * num2 * Time.deltaTime;
        if ((double) vector3_2.magnitude >= (double) vector3_1.magnitude)
        {
          vector3_2 = vector3_1;
          localEntity.RemoveVisualSmoothing();
        }
        Vector3 vector3_3 = position1 + vector3_2;
        Vector3 position2 = new Vector3(this.entityPos2.x, localEntity.unityView.gameObject.transform.position.y, this.entityPos2.z);
        localEntity.unityView.gameObject.transform.SetPositionAndRotation(position2, this.entityRot2);
      }
      else
        this.InterpolateView(localEntity);
    }

    private void InterpolateView(GameEntity localEntity)
    {
      float t = this.gameContext.globalTime.timeSinceStartOfTick / this.gameContext.globalTime.fixedSimTimeStep;
      Vector3 a1 = this.entityPos1;
      Vector3 b1 = this.entityPos2;
      Quaternion a2 = this.entityRot1;
      Quaternion b2 = this.entityRot2;
      if ((double) t < 0.0)
      {
        ++t;
        a1 = this.entityPos0;
        b1 = this.entityPos1;
        a2 = this.entityRot0;
        b2 = this.entityRot1;
      }
      Vector3 position = Vector3.Lerp(a1, b1, t);
      Log.Debug(string.Format("[{0}] t[{1}], d[{2}], m:{3}", (object) this.gameContext.globalTime.currentTick, (object) t, (object) this.gameContext.globalTime.timeSinceStartOfTick, (object) (float) ((double) (position - localEntity.unityView.gameObject.transform.position).magnitude / (double) Time.deltaTime)));
      Quaternion rotation = Quaternion.Slerp(a2, b2, t);
      localEntity.unityView.gameObject.transform.SetPositionAndRotation(position, rotation);
    }

    private void SmooothLocalPlayer(GameEntity localEntity)
    {
      LocalPlayerVisualSmoothing playerVisualSmoothing = localEntity.localPlayerVisualSmoothing;
      Vector3 vector3 = localEntity.transform.position.ToVector3();
      Quaternion quaternion = localEntity.transform.rotation.ToQuaternion();
      TransformState smoothedTransform = playerVisualSmoothing.smoothedTransform;
      Vector3 a1;
      Quaternion a2;
      if (smoothedTransform.Equals(TransformState.Invalid))
      {
        a1 = localEntity.unityView.gameObject.transform.position;
        a2 = localEntity.unityView.gameObject.transform.rotation;
      }
      else
      {
        a1 = smoothedTransform.position.ToVector3();
        a2 = smoothedTransform.rotation.ToQuaternion();
      }
      float t = (double) playerVisualSmoothing.currentLerpDuration == 0.0 ? 1f : Mathf.Clamp01(playerVisualSmoothing.currentLerpFactor + Time.deltaTime / playerVisualSmoothing.currentLerpDuration);
      Vector3 vector;
      Quaternion rot;
      if (!this.debugConfig.disableVisualSmoothing)
      {
        vector = Vector3.Lerp(a1, vector3, t);
        rot = Quaternion.Lerp(a2, quaternion, t);
      }
      else
      {
        vector = vector3;
        rot = quaternion;
      }
      smoothedTransform.position = vector.ToJVector();
      smoothedTransform.rotation = rot.ToJQuaternion();
      playerVisualSmoothing.smoothedTransform = smoothedTransform;
      playerVisualSmoothing.currentLerpFactor = t;
      localEntity.ReplaceComponent(40, (IComponent) playerVisualSmoothing);
    }

    private void InterpolateLocalPlayer(GameEntity localEntity)
    {
      LocalPlayerVisualSmoothing playerVisualSmoothing = localEntity.localPlayerVisualSmoothing;
      TransformState interpolationStartTransform = playerVisualSmoothing.interpolationStartTransform;
      TransformState interpolationEndTransform = playerVisualSmoothing.interpolationEndTransform;
      Transform transform = localEntity.unityView.gameObject.transform;
      if (this.debugConfig.disableVisualSmoothing)
      {
        Vector3 vector3 = localEntity.transform.position.ToVector3();
        Quaternion quaternion = localEntity.transform.rotation.ToQuaternion();
        transform.SetPositionAndRotation(vector3, quaternion);
      }
      else
      {
        if (interpolationStartTransform.Equals(TransformState.Invalid) || interpolationEndTransform.Equals(TransformState.Invalid))
          return;
        float num = Time.time - playerVisualSmoothing.tickStartTime + playerVisualSmoothing.frameDtOffset;
        float t = num / this.gameContext.globalTime.fixedSimTimeStep;
        float sampleTime = ScTime.TicksToMillis(this.gameContext.globalTime.currentTick - 1, this.gameContext.globalTime.fixedSimTimeStep) + num * 1000f;
        Vector3 vector3 = playerVisualSmoothing.positionTimeline.ValueAt(sampleTime).ToVector3();
        Quaternion rotation = Quaternion.Slerp(interpolationStartTransform.rotation.ToQuaternion(), interpolationEndTransform.rotation.ToQuaternion(), t);
        transform.SetPositionAndRotation(vector3, rotation);
      }
    }
  }
}
