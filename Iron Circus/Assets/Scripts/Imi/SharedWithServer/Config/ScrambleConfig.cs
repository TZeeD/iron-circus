// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Config.ScrambleConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Game.Skills;
using Jitter.LinearMath;
using System;
using UnityEngine;

namespace Imi.SharedWithServer.Config
{
  [CreateAssetMenu(fileName = "ScrambleConfig", menuName = "SteelCircus/SkillConfigs/ScrambleConfig")]
  public class ScrambleConfig : SkillGraphConfig
  {
    public Imi.SharedWithServer.ScEntitas.Components.ButtonType button;
    public string iconName;
    public float aoeOffset;
    public float sweepWidth;
    public float sweepDistance;
    public float sweepSpeed;
    public float scrambleDuration;
    public float cooldown;
    public const float SweepThickness = 1f;
    public VfxPrefab previewPrefab;
    public VfxPrefab scrambleWavePrefab;

    protected override void SetupSkillGraph(SkillGraph skillGraph)
    {
      SkillUiState skillUiState = skillGraph.AddState<SkillUiState>("Ui");
      ButtonState buttonState = skillGraph.AddState<ButtonState>("Input");
      BooleanSwitchState booleanSwitchState1 = skillGraph.AddState<BooleanSwitchState>("WhileButtonDown");
      ShowAoeState showAoeState1 = skillGraph.AddState<ShowAoeState>("ShowAoE");
      PlayVfxState playVfxState = skillGraph.AddState<PlayVfxState>("showSweepState");
      ModVarOverTimeState modSweepDistance = skillGraph.AddState<ModVarOverTimeState>("ModSweepDistance");
      WhileTrueState whileTrueState1 = skillGraph.AddState<WhileTrueState>("CooldownState");
      BooleanSwitchState booleanSwitchState2 = skillGraph.AddState<BooleanSwitchState>("WhileProgressCooldown");
      ModVarOverTimeState varOverTimeState1 = skillGraph.AddState<ModVarOverTimeState>("ProgressCooldown");
      CheckAreaOfEffectState checkHitState = skillGraph.AddState<CheckAreaOfEffectState>("checkHitState");
      UpdateAimDirAndMagnitude aimDirAndMagnitude = skillGraph.AddState<UpdateAimDirAndMagnitude>("UpdateAim");
      PlayAnimationState playAnimationState1 = skillGraph.AddState<PlayAnimationState>("TurnToAim");
      PlayAnimationState playAnimationState2 = skillGraph.AddState<PlayAnimationState>("PlaySkillAnim");
      AudioState audioState = skillGraph.AddState<AudioState>("Scramble Aim Audio Loop");
      LockGraphsState lockGraphsState = skillGraph.AddState<LockGraphsState>("LockGraphsState");
      SetVar<float> setVar1 = skillGraph.AddAction<SetVar<float>>("RestartCooldown");
      SetVar<float> setVar2 = skillGraph.AddAction<SetVar<float>>("ResetCooldown");
      SetVar<bool> setVar3 = skillGraph.AddAction<SetVar<bool>>("SetOnCooldown");
      SetVar<bool> setVar4 = skillGraph.AddAction<SetVar<bool>>("SetCooldownDone");
      SetVar<JVector> setVar5 = skillGraph.AddAction<SetVar<JVector>>("SetStartPos");
      SetVar<float> setVar6 = skillGraph.AddAction<SetVar<float>>("resetSweepOffset");
      SetVar<JVector> setVar7 = skillGraph.AddAction<SetVar<JVector>>("SetSweepPos");
      SetVar<int> setVar8 = skillGraph.AddAction<SetVar<int>>("ResetHitCounter");
      OnEventAction onEventAction1 = skillGraph.AddAction<OnEventAction>("OnMatchStart");
      OnEventAction onEventAction2 = skillGraph.AddAction<OnEventAction>("OnPickup");
      OnEventAction onEventAction3 = skillGraph.AddAction<OnEventAction>("OnInterrupt");
      OnEventAction onEventAction4 = skillGraph.AddAction<OnEventAction>("OnOvertime");
      ConditionAction conditionAction = skillGraph.AddAction<ConditionAction>("OnCanActivate");
      RumbleControllerAction controllerAction1 = skillGraph.AddAction<RumbleControllerAction>("Rumble");
      RumbleControllerAction controllerAction2 = skillGraph.AddAction<RumbleControllerAction>("RumbleSelf");
      ApplyScrambleAction applyScrambleAction1 = skillGraph.AddAction<ApplyScrambleAction>("ApplyScramble");
      PlayAudioAction playAudioAction1 = skillGraph.AddAction<PlayAudioAction>("Play Scramble Voice Audio");
      PlayAudioAction playAudioAction2 = skillGraph.AddAction<PlayAudioAction>("Play Scramble Shoot Audio");
      PlayAudioAction playAudioAction3 = skillGraph.AddAction<PlayAudioAction>("Play Scramble Start Audio");
      PlayAudioAction playAudioAction4 = skillGraph.AddAction<PlayAudioAction>("Play Scramble Hit Enemy1 Audio");
      PlayAudioAction playAudioAction5 = skillGraph.AddAction<PlayAudioAction>("Play Scramble Hit Enemy2 Audio");
      PlayAudioAction playAudioAction6 = skillGraph.AddAction<PlayAudioAction>("Play Scramble Hit Enemy3 Audio");
      PlayAudioAction[] scrambleHitEnemyAudioArray = new PlayAudioAction[3]
      {
        playAudioAction4,
        playAudioAction5,
        playAudioAction6
      };
      SkillVar<float> currentCooldown = skillGraph.AddVar<float>("CurrentCooldown");
      SkillVar<float> sweepOffset = skillGraph.AddVar<float>("sweepOffset");
      SkillVar<bool> isOnCooldown = skillGraph.AddVar<bool>("IsOnCooldown");
      SkillVar<bool> isActive = skillGraph.AddVar<bool>("IsActive");
      SkillVar<bool> canActivate = skillGraph.AddVar<bool>("CanActivate");
      SkillVar<UniqueId> skillVar1 = skillGraph.AddVar<UniqueId>("HitEntities", true);
      SkillVar<JVector> startPosition = skillGraph.AddVar<JVector>("SweepStartPos");
      SkillVar<JVector> aimDir = skillGraph.AddVar<JVector>("AimDir");
      SkillVar<JVector> skillVar2 = skillGraph.AddVar<JVector>("SweepPos");
      SkillVar<int> hitCounter = skillGraph.AddVar<int>("hitCounter");
      PlayRazerAnimation playRazerAnimation1 = skillGraph.AddAction<PlayRazerAnimation>("PlayAimScrambleRazer");
      PlayRazerAnimation playRazerAnimation2 = skillGraph.AddAction<PlayRazerAnimation>("PlayPlaceScrambleRazer");
      PlayRazerAnimation playRazerAnimation3 = skillGraph.AddAction<PlayRazerAnimation>("ResetRazer");
      currentCooldown.Set(this.cooldown);
      canActivate.Expression((Func<bool>) (() => !(bool) isOnCooldown && !(bool) isActive && !skillGraph.IsSkillUseDisabled() && !skillGraph.IsGraphLocked() && !skillGraph.OwnerHasBall()));
      isActive.Expression((Func<bool>) (() => modSweepDistance.IsActive));
      skillGraph.AddEntryState((SkillState) buttonState);
      skillGraph.AddEntryState((SkillState) skillUiState);
      skillUiState.buttonType.Constant(this.button);
      skillUiState.iconName.Constant(this.iconName);
      skillUiState.coolDownLeftAmount.Expression((Func<float>) (() => (float) currentCooldown));
      skillUiState.fillAmount.Expression((Func<float>) (() => (float) (1.0 - (double) (float) currentCooldown / (double) this.cooldown)));
      audioState.audioResourceName.Constant("GalenaSkillScrambleAimLoop");
      playAudioAction1.audioResourceName.Constant("GalenaVoiceScramble");
      playAudioAction2.audioResourceName.Constant("GalenaSkillScrambleShot");
      playAudioAction3.audioResourceName.Constant("GalenaSkillScrambleStart");
      playAudioAction4.audioResourceName.Constant("GalenaSkillScrambleHitEnemy1");
      playAudioAction4.doNotTrack.Constant(true);
      playAudioAction5.audioResourceName.Constant("GalenaSkillScrambleHitEnemy2");
      playAudioAction5.doNotTrack.Constant(true);
      playAudioAction6.audioResourceName.Constant("GalenaSkillScrambleHitEnemy3");
      playAudioAction6.doNotTrack.Constant(true);
      playRazerAnimation1.razerAnimType = RazerAnimType.Champion;
      playRazerAnimation1.animationIndex = 0;
      playRazerAnimation2.razerAnimType = RazerAnimType.Champion;
      playRazerAnimation2.animationIndex = 1;
      playRazerAnimation3.razerAnimType = RazerAnimType.Team;
      buttonState.buttonType.Constant(this.button);
      buttonState.buttonDownSubStates += (SkillState) booleanSwitchState1;
      buttonState.OnButtonUp += conditionAction.Do;
      booleanSwitchState1.condition = (Func<bool>) (() => (bool) canActivate);
      booleanSwitchState1.WhileTrueSubState += (SkillState) showAoeState1;
      booleanSwitchState1.WhileTrueSubState += (SkillState) lockGraphsState;
      booleanSwitchState1.OnTrue += playAudioAction3.Do;
      booleanSwitchState1.OnTrue += playRazerAnimation1.Do;
      showAoeState1.aoe.Expression((Func<AreaOfEffect>) (() => new AreaOfEffect()
      {
        shape = AoeShape.Rectangle,
        rectLength = this.sweepDistance,
        rectWidth = this.sweepWidth,
        vfxPrefab = this.previewPrefab
      }));
      showAoeState1.position.Expression((Func<JVector>) (() => skillGraph.GetPosition()));
      showAoeState1.lookDir.Expression((Func<JVector>) (() => (JVector) aimDir));
      showAoeState1.offset.Expression((Func<JVector>) (() => JVector.Forward * this.aoeOffset));
      ShowAoeState showAoeState2 = showAoeState1;
      showAoeState2.SubState = showAoeState2.SubState + (SkillState) aimDirAndMagnitude;
      ShowAoeState showAoeState3 = showAoeState1;
      showAoeState3.SubState = showAoeState3.SubState + (SkillState) playAnimationState1;
      ShowAoeState showAoeState4 = showAoeState1;
      showAoeState4.SubState = showAoeState4.SubState + (SkillState) playAnimationState2;
      ShowAoeState showAoeState5 = showAoeState1;
      showAoeState5.SubState = showAoeState5.SubState + (SkillState) audioState;
      playAnimationState1.animationType.Constant(AnimationStateType.TurnHeadToAim);
      playAnimationState2.animationType.Constant(AnimationStateType.PrimarySkill);
      aimDirAndMagnitude.aimDir = aimDir;
      aimDirAndMagnitude.dontCacheLastAim = true;
      conditionAction.condition = (Func<bool>) (() => (bool) canActivate);
      conditionAction.OnTrue += setVar5.Do;
      conditionAction.OnTrue += playAudioAction2.Do;
      conditionAction.OnTrue += playAudioAction1.Do;
      conditionAction.OnTrue += setVar8.Do;
      conditionAction.OnTrue += playRazerAnimation2.Do;
      conditionAction.OnTrue += setVar2.Do;
      setVar2.var = currentCooldown;
      setVar2.value.Expression((Func<float>) (() => this.cooldown));
      setVar5.var = startPosition;
      setVar5.value.Expression(new Func<JVector>(skillGraph.GetPosition));
      SetVar<JVector> setVar9 = setVar5;
      setVar9.Then = setVar9.Then + setVar6.Do;
      setVar6.var = sweepOffset;
      setVar6.value.Set(0.0f);
      SetVar<float> setVar10 = setVar6;
      setVar10.Then = setVar10.Then + modSweepDistance.Enter;
      modSweepDistance.var = sweepOffset;
      modSweepDistance.amountPerSecond.Expression((Func<float>) (() => this.sweepSpeed));
      modSweepDistance.targetValue.Expression((Func<float>) (() => this.sweepDistance - 0.5f));
      ModVarOverTimeState varOverTimeState2 = modSweepDistance;
      varOverTimeState2.SubState = varOverTimeState2.SubState + (SkillState) checkHitState;
      ModVarOverTimeState varOverTimeState3 = modSweepDistance;
      varOverTimeState3.SubState = varOverTimeState3.SubState + (SkillState) playVfxState;
      playVfxState.vfxPrefab = this.scrambleWavePrefab;
      playVfxState.parentToOwner = false;
      setVar7.var = skillVar2;
      setVar7.value.Expression((Func<JVector>) (() => (JVector) startPosition + aimDir.Get() * (float) ((double) this.aoeOffset + 0.5 + (double) (float) sweepOffset - (double) this.sweepDistance * 0.5)));
      ModVarOverTimeState varOverTimeState4 = modSweepDistance;
      varOverTimeState4.OnUpdate = varOverTimeState4.OnUpdate + setVar7.Do;
      checkHitState.aoe.Expression((Func<AreaOfEffect>) (() => new AreaOfEffect()
      {
        shape = AoeShape.Rectangle,
        rectLength = 1f,
        rectWidth = this.sweepWidth
      }));
      checkHitState.position.Expression((Func<JVector>) (() => (JVector) startPosition + aimDir.Get() * (float) ((double) this.aoeOffset + 0.5 + (double) (float) sweepOffset - (double) this.sweepDistance * 0.5)));
      checkHitState.lookDir.Expression((Func<JVector>) (() => (JVector) aimDir));
      checkHitState.hitEntities = skillVar1;
      checkHitState.filterHit = (Func<GameEntity, bool>) (entity => entity.HasModifier(StatusModifier.Flying));
      checkHitState.includeEnemies = true;
      checkHitState.singleHitPerEntity = true;
      checkHitState.OnHit += controllerAction2.Do;
      checkHitState.OnHit += applyScrambleAction1.Do;
      CheckAreaOfEffectState areaOfEffectState = checkHitState;
      areaOfEffectState.OnExit = areaOfEffectState.OnExit + whileTrueState1.Enter;
      setVar8.var = hitCounter;
      setVar8.value = (SyncableValue<int>) 0;
      checkHitState.onHitDelegate = (Action) (() =>
      {
        for (int index = 0; index < checkHitState.hitEntities.Length && index <= 2; ++index)
        {
          scrambleHitEnemyAudioArray[(int) hitCounter % 3].PerformAction();
          hitCounter.Set((int) hitCounter + 1);
        }
      });
      applyScrambleAction1.targetEntities = skillVar1;
      applyScrambleAction1.duration.Expression((Func<float>) (() => this.scrambleDuration));
      ApplyScrambleAction applyScrambleAction2 = applyScrambleAction1;
      applyScrambleAction2.Then = applyScrambleAction2.Then + controllerAction1.Do;
      controllerAction1.entities = skillVar1;
      controllerAction1.duration = (SyncableValue<float>) 1f;
      controllerAction1.strength = (SyncableValue<float>) 1f;
      controllerAction2.playerId = (SyncableValue<ulong>) skillGraph.GetOwnerId();
      controllerAction2.duration = (SyncableValue<float>) 0.5f;
      controllerAction2.strength = (SyncableValue<float>) 1f;
      setVar1.var = currentCooldown;
      setVar1.value.Expression((Func<float>) (() => this.cooldown));
      SetVar<float> setVar11 = setVar1;
      setVar11.Then = setVar11.Then + whileTrueState1.Enter;
      whileTrueState1.condition = (Func<bool>) (() => (double) (float) currentCooldown > 0.0);
      WhileTrueState whileTrueState2 = whileTrueState1;
      whileTrueState2.SubState = whileTrueState2.SubState + (SkillState) booleanSwitchState2;
      WhileTrueState whileTrueState3 = whileTrueState1;
      whileTrueState3.OnEnter = whileTrueState3.OnEnter + setVar3.Do;
      WhileTrueState whileTrueState4 = whileTrueState1;
      whileTrueState4.OnEnter = whileTrueState4.OnEnter + playRazerAnimation3.Do;
      WhileTrueState whileTrueState5 = whileTrueState1;
      whileTrueState5.OnExit = whileTrueState5.OnExit + setVar4.Do;
      setVar3.var = isOnCooldown;
      setVar3.value.Set(true);
      setVar4.var = isOnCooldown;
      setVar4.value.Set(false);
      booleanSwitchState2.condition = (Func<bool>) (() => !skillGraph.IsSkillUseDisabled());
      booleanSwitchState2.WhileTrueSubState += (SkillState) varOverTimeState1;
      varOverTimeState1.var = currentCooldown;
      varOverTimeState1.amountPerSecond.Constant(-1f);
      varOverTimeState1.targetValue = (SyncableValue<float>) 0.0f;
      onEventAction1.EventType = SkillGraphEvent.MatchStart;
      onEventAction1.OnTrigger += setVar1.Do;
      onEventAction2.EventType = SkillGraphEvent.SkillPickupCollected;
      onEventAction2.onTriggerDelegate = (Action) (() => currentCooldown.Set(SkillGraph.CalculateRefreshCooldown((float) currentCooldown, this.cooldown)));
      onEventAction4.EventType = SkillGraphEvent.Overtime;
      onEventAction4.OnTrigger += setVar1.Do;
      onEventAction3.EventType = SkillGraphEvent.Interrupt;
      onEventAction3.OnTrigger += audioState.Exit;
      onEventAction3.OnTrigger += buttonState.Reset;
    }
  }
}
