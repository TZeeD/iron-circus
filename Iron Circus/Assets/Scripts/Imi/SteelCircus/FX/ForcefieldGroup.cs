// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.FX.ForcefieldGroup
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.SharedWithServer.Game;
using Imi.SteelCircus.GameElements;
using Imi.SteelCircus.JitterUnity;
using Jitter.LinearMath;
using SharedWithServer.ScEvents;
using UnityEngine;

namespace Imi.SteelCircus.FX
{
  public class ForcefieldGroup : MonoBehaviour
  {
    private ForcefieldMaterialFX[] forcefields;
    private IGroup<GameEntity> players;

    private void Start()
    {
      this.forcefields = this.GetComponentsInChildren<ForcefieldMaterialFX>(true);
      Events.Global.OnEventBallTerrainCollision += new Events.EventBallTerrainCollision(this.OnTerrainCollision);
      this.players = Contexts.sharedInstance.game.GetGroup(GameMatcher.Player);
    }

    private void OnTerrainCollision(UniqueId id, JVector position, JVector normal)
    {
      GameEntity ballEntity = Contexts.sharedInstance.game.ballEntity;
      Vector3 position1 = ballEntity.unityView.gameObject.GetComponent<BallView>().Position;
      foreach (ForcefieldMaterialFX forcefield in this.forcefields)
        forcefield.StartFlash(position1);
      this.PlayForceFieldHitAudio(position1, ballEntity.velocityOverride.value.ToVector3().magnitude);
    }

    private void Update()
    {
      int playerIndex = 0;
      foreach (GameEntity player in this.players)
      {
        if (player.hasTransform)
        {
          foreach (ForcefieldMaterialFX forcefield in this.forcefields)
            forcefield.UpdatePlayer(player.transform.position.ToVector3(), playerIndex);
        }
        ++playerIndex;
      }
    }

    private void OnDestroy() => Events.Global.OnEventBallTerrainCollision -= new Events.EventBallTerrainCollision(this.OnTerrainCollision);

    private void PlayForceFieldHitAudio(Vector3 ballPosition, float ballVelocity)
    {
      float num1 = Mathf.Min(1f, (float) (0.5 + (double) ballVelocity / 50.0));
      AudioController.Play((double) ballVelocity < 25.0 ? "BallHitEnergyFieldSoft" : "BallHitEnergyFieldHard", ballPosition);
      float volume = Mathf.Pow(num1, 1.75f);
      AudioController.Play("BallHitEnergyFieldBuzz", ballPosition, (Transform) null, volume);
      if ((double) ballVelocity > 35.0)
        AudioController.Play("BallHitEnergyFieldImpact", ballPosition, (Transform) null, num1);
      float num2 = 6f;
      AudioController.GetAudioItem("BallHitEnergyFieldPitch").PitchShift = ballVelocity / num2;
      AudioController.Play("BallHitEnergyFieldPitch", ballPosition, (Transform) null, num1);
      AudioController.GetAudioItem("BallHitEnergyFieldBase").PitchShift = ballVelocity / (num2 * 2f);
      AudioController.Play("BallHitEnergyFieldBase", ballPosition, (Transform) null, num1);
    }
  }
}
