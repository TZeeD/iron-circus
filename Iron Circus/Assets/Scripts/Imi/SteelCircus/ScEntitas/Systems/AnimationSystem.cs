// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.ScEntitas.Systems.AnimationSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas;
using Imi.SharedWithServer.ScEntitas.Systems;
using Imi.SteelCircus.JitterUnity;
using System;
using UnityEngine;

namespace Imi.SteelCircus.ScEntitas.Systems
{
  public class AnimationSystem : ExecuteGameSystem
  {
    private const string MaxSpeed = "maxSpeed";
    private const string HasBall = "hasBall";
    private const string IsChargingBallThrow = "isChargingBallThrow";
    private const string BallThrowCharge = "throwCharge";
    private const string Speed = "speed";
    private const string Tackling = "tackling";
    private const string SkillActive = "skillActive";
    private const string Skill2Active = "skill2Active";
    private const string Dodging = "isDodging";
    private const string UTurn = "performingUTurn";
    private const string RandomSeed = "randomSeed";
    private const string Stunned = "stunned";
    private const string Pushed = "pushed";
    private const string PushX = "pushbackVx";
    private const string PushY = "pushbackVy";
    private const string Emote = "emote";
    private const string EmoteInterrupt = "emoteInterrupt";
    private const string ChampionIntro = "champIntro";
    private const string VictoryPose = "victoryPose";
    private IGroup<GameEntity> playerViews;

    public AnimationSystem(EntitasSetup entitasSetup)
      : base(entitasSetup)
    {
      this.playerViews = this.gameContext.GetGroup((IMatcher<GameEntity>) GameMatcher.AllOf(GameMatcher.Player, GameMatcher.UnityView));
    }

    protected override void GameExecute()
    {
      foreach (GameEntity playerView in this.playerViews)
      {
        Animator componentInChildren = playerView.unityView.gameObject.GetComponentInChildren<Animator>(true);
        this.UpdateChampionAnimations(playerView, componentInChildren);
      }
    }

    public static bool HasAnimatorParameter(string paramName, Animator animator)
    {
      foreach (AnimatorControllerParameter parameter in animator.parameters)
      {
        if (parameter.name == paramName)
          return true;
      }
      return false;
    }

    private void UpdateChampionAnimations(GameEntity champion, Animator animator)
    {
      if ((UnityEngine.Object) animator == (UnityEngine.Object) null || champion.IsDead() || (UnityEngine.Object) animator.runtimeAnimatorController == (UnityEngine.Object) null)
        return;
      this.HandleInvisible(champion, animator);
      if (!animator.gameObject.activeInHierarchy)
        return;
      this.HandleEmoteActionInterrupt(champion, animator);
      animator.SetFloat("randomSeed", UnityEngine.Random.value);
      animator.SetBool("stunned", champion.IsStunned());
      animator.SetBool("tackling", champion.animationState.HasType(AnimationStateType.Tackle));
      animator.SetBool("isDodging", champion.animationState.HasType(AnimationStateType.Dodge));
      animator.SetBool("skillActive", champion.animationState.HasType(AnimationStateType.PrimarySkill));
      animator.SetBool("skill2Active", champion.animationState.HasType(AnimationStateType.SecondarySkill));
      this.HandlePush(champion, animator);
      this.HandleRun(champion, animator);
      this.HandleHoldBall(champion, animator);
      AnimationSystem.HandleEmote(champion, animator);
      AnimationSystem.HandleChampionIntro(champion, animator);
      AnimationSystem.HandleVictoryPose(champion, animator);
    }

    private static void HandleEmote(GameEntity champion, Animator animator)
    {
      int num = 0;
      if (champion.animationState.HasType(AnimationStateType.Emote))
      {
        num = champion.animationState.GetState(AnimationStateType.Emote).variation;
        animator.SetBool("emoteInterrupt", false);
      }
      if (num != 0)
      {
        if (!((UnityEngine.Object) champion.playerLoadout.itemLoadouts[champion.playerChampionData.value.type].emoteAssets[num - 1] != (UnityEngine.Object) null))
          return;
        animator.SetInteger("emote", num);
      }
      else
        animator.SetInteger("emote", 0);
    }

    private void HandleEmoteMovementInterrupt(
      GameEntity champion,
      bool velociyChanged,
      Animator animator)
    {
      bool flag = animator.GetBool("emoteInterrupt");
      if (!champion.animationState.HasType(AnimationStateType.Emote))
      {
        if (!velociyChanged || flag)
          return;
        animator.SetInteger("emote", 0);
        animator.SetBool("emoteInterrupt", true);
      }
      else
        animator.SetBool("emoteInterrupt", false);
    }

    private void HandleEmoteActionInterrupt(GameEntity champion, Animator animator)
    {
      bool flag = animator.GetBool("emoteInterrupt");
      if (!champion.animationState.HasType(AnimationStateType.Emote))
      {
        if (flag || !AnimationSystem.ChampionIsDoingAction(champion))
          return;
        animator.SetInteger("emote", 0);
        animator.SetBool("emoteInterrupt", true);
      }
      else
        animator.SetBool("emoteInterrupt", false);
    }

    private static bool ChampionIsDoingAction(GameEntity champion) => champion.animationState.HasType(AnimationStateType.Tackle) || champion.animationState.HasType(AnimationStateType.Dodge) || champion.animationState.HasType(AnimationStateType.PrimarySkill) || champion.animationState.HasType(AnimationStateType.SecondarySkill) || champion.animationState.HasType(AnimationStateType.ChargeThrowBall);

    private static void HandleChampionIntro(GameEntity champion, Animator animator)
    {
      int num = 0;
      if (champion.animationState.HasType(AnimationStateType.ChampionIntro))
        num = champion.animationState.GetState(AnimationStateType.ChampionIntro).variation;
      animator.SetInteger("champIntro", num);
    }

    private static void HandleVictoryPose(GameEntity champion, Animator animator)
    {
      int num = 0;
      if (champion.animationState.HasType(AnimationStateType.VictoryPose))
        num = champion.animationState.GetState(AnimationStateType.VictoryPose).variation;
      animator.SetInteger("victoryPose", num);
    }

    private void HandleRun(GameEntity champion, Animator animator)
    {
      float num1 = champion.velocityOverride.value.Length();
      float num2 = animator.GetFloat("speed");
      bool flag = champion.isLocalEntity && (double) champion.input.GetInput(this.gameContext.globalTime.currentTick).moveDir.Length() > 0.4 || (double) num1 > 0.25;
      animator.SetFloat("speed", flag ? num1 : 0.0f);
      this.HandleEmoteMovementInterrupt(champion, (double) Math.Abs(num1 - num2) > 1.0 / 1000.0, animator);
    }

    private void HandleHoldBall(GameEntity champion, Animator animator)
    {
      GameEntity ballEntity = Contexts.sharedInstance.game.ballEntity;
      bool flag = ballEntity != null && ballEntity.hasBallOwner && (long) ballEntity.ballOwner.playerId == (long) champion.playerId.value;
      animator.SetBool("hasBall", flag);
      animator.SetBool("isChargingBallThrow", champion.animationState.HasType(AnimationStateType.ChargeThrowBall));
      animator.SetFloat("throwCharge", champion.animationState.GetState(AnimationStateType.ChargeThrowBall).normalizedProgress);
    }

    private void HandlePush(GameEntity champion, Animator animator)
    {
      int num = animator.GetBool("pushed") ? 1 : 0;
      bool flag = champion.HasEffect(StatusEffectType.Push);
      animator.SetBool("pushed", flag);
      if (!(num == 0 & flag))
        return;
      Vector3 vector3 = champion.unityView.gameObject.transform.InverseTransformDirection(champion.PushForce().ToVector3()) * 10f;
      animator.SetFloat("pushbackVx", vector3.x);
      animator.SetFloat("pushbackVy", vector3.z);
    }

    private void HandleInvisible(GameEntity champion, Animator animator)
    {
      int num = champion.statusEffect.GetEffect(StatusEffectType.Invisible) != null ? 1 : 0;
      Renderer[] componentsInChildren = animator.GetComponentsInChildren<Renderer>(true);
      if (num != 0)
      {
        foreach (Component component in componentsInChildren)
        {
          GameObject gameObject = component.gameObject;
          if (gameObject.activeSelf && (UnityEngine.Object) gameObject.GetComponent<ObjectTag>() == (UnityEngine.Object) null)
            gameObject.SetActive(false);
        }
      }
      else
      {
        foreach (Component component in componentsInChildren)
        {
          GameObject gameObject = component.gameObject;
          if (!gameObject.activeSelf && (UnityEngine.Object) gameObject.GetComponent<ObjectTag>() == (UnityEngine.Object) null)
            gameObject.SetActive(true);
        }
      }
    }
  }
}
