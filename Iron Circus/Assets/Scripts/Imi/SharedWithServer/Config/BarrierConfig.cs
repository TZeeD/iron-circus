// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Config.BarrierConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Game.Skills;
using Jitter.LinearMath;
using Newtonsoft.Json;
using System;
using UnityEngine;

namespace Imi.SharedWithServer.Config
{
  [CreateAssetMenu(fileName = "BarrierConfig", menuName = "SteelCircus/SkillConfigs/BarrierConfig")]
  public class BarrierConfig : SkillGraphConfig
  {
    [Header("Button Settings")]
    public Imi.SharedWithServer.ScEntitas.Components.ButtonType button;
    public string iconName = "icon_wall_inverted_01_tex";
    public float duration = 2f;
    public float cooldown = 1f;
    public JVector barrierDimensions;
    public float barrierOffset = 1f;
    public VfxPrefab aoePrefab;
    [JsonIgnore]
    public GameObject barrierPrefab;
    public VfxPrefab rotationControlsPrefab;
    public VfxPrefab barrierConnectionPrefab;

    protected override void SetupSkillGraph(SkillGraph skillGraph)
    {
      ButtonState input = skillGraph.AddState<ButtonState>("Input");
      SkillUiState skillUiState = skillGraph.AddState<SkillUiState>("Ui");
      WaitState waitState1 = skillGraph.AddState<WaitState>("Barri Duration");
      WhileTrueState whileTrueState1 = skillGraph.AddState<WhileTrueState>("CooldownState");
      ModVarOverTimeState varOverTimeState = skillGraph.AddState<ModVarOverTimeState>("UpdateCooldown");
      BooleanSwitchState booleanSwitchState1 = skillGraph.AddState<BooleanSwitchState>("WhileUpdateCooldown");
      BarrierActiveState barrierActiveState1 = skillGraph.AddState<BarrierActiveState>("Barri State");
      BooleanSwitchState booleanSwitchState2 = skillGraph.AddState<BooleanSwitchState>("While sh Preview");
      ShowAoeState showAoeState1 = skillGraph.AddState<ShowAoeState>("Preview");
      PlayAnimationState playAnimationState1 = skillGraph.AddState<PlayAnimationState>("PlayPlaceAnimation");
      PlayAnimationState playAnimationState2 = skillGraph.AddState<PlayAnimationState>("TurnToAim");
      AudioState audioState1 = skillGraph.AddState<AudioState>("StartAudio");
      AudioState audioState2 = skillGraph.AddState<AudioState>("StartVoice");
      PlayVfxState playVfxState = skillGraph.AddState<PlayVfxState>("RotationControls");
      LockGraphsState lockGraphsState = skillGraph.AddState<LockGraphsState>("LockGraphs");
      OnEventAction onEventAction1 = skillGraph.AddAction<OnEventAction>("OnPickup");
      OnEventAction onEventAction2 = skillGraph.AddAction<OnEventAction>("OnInterrupt");
      OnEventAction onEventAction3 = skillGraph.AddAction<OnEventAction>("OnMatchStart");
      OnEventAction onEventAction4 = skillGraph.AddAction<OnEventAction>("OnOvertime");
      ConditionAction conditionAction = skillGraph.AddAction<ConditionAction>("CanPlaceWall");
      SetVar<float> setVar1 = skillGraph.AddAction<SetVar<float>>("ResetAndStartCooldown");
      SetVar<JVector> setVar2 = skillGraph.AddAction<SetVar<JVector>>("UpdateAimDirection");
      SpawnVfxAction spawnVfxAction = skillGraph.AddAction<SpawnVfxAction>("ShowBarrierConnection");
      SkillVar<JVector> aimDir = skillGraph.AddVar<JVector>("AimDir");
      SkillVar<bool> isBarrierActive = skillGraph.AddVar<bool>("IsBarrierActive");
      SkillVar<bool> isOnCooldown = skillGraph.AddVar<bool>("IsOnCooldown");
      SkillVar<float> currentCooldown = skillGraph.AddVar<float>("CurrentCooldown");
      SkillVar<bool> isReady = skillGraph.AddVar<bool>("IsReady");
      SkillVar<JVector> barrierPos = skillGraph.AddVar<JVector>("BarrierPos");
      currentCooldown.Set(this.cooldown);
      isReady.Expression((Func<bool>) (() => !(bool) isOnCooldown && !(bool) isBarrierActive && !skillGraph.OwnerHasBall() && !skillGraph.IsSkillUseDisabled() && !skillGraph.IsGraphLocked()));
      barrierPos.Expression((Func<JVector>) (() => skillGraph.GetOwner().transform.position + aimDir.Get() * (this.barrierOffset + this.barrierDimensions.Z / 2f)));
      skillGraph.AddEntryState((SkillState) input);
      skillGraph.AddEntryState((SkillState) skillUiState);
      playVfxState.vfxPrefab = this.rotationControlsPrefab;
      playVfxState.parentToOwner = true;
      playVfxState.args = (object) showAoeState1;
      skillGraph.AddEntryState((SkillState) playVfxState);
      skillUiState.fillAmount.Expression((Func<float>) (() => (float) (1.0 - (double) (float) currentCooldown / (double) this.cooldown)));
      skillUiState.coolDownLeftAmount.Expression((Func<float>) (() => (float) currentCooldown));
      skillUiState.iconName.Expression((Func<string>) (() => this.iconName));
      skillUiState.buttonType.Expression((Func<Imi.SharedWithServer.ScEntitas.Components.ButtonType>) (() => this.button));
      audioState1.audioResourceName.Constant("Capx02SkillBarrier");
      audioState2.audioResourceName.Constant("Capx02VoiceBarrier");
      input.buttonType.Expression((Func<Imi.SharedWithServer.ScEntitas.Components.ButtonType>) (() => this.button));
      input.buttonDownSubStates += (SkillState) booleanSwitchState2;
      input.OnButtonUp += conditionAction.Do;
      booleanSwitchState2.condition = (Func<bool>) (() => (bool) isReady);
      booleanSwitchState2.WhileTrueSubState += (SkillState) showAoeState1;
      booleanSwitchState2.WhileTrueSubState += (SkillState) playAnimationState1;
      booleanSwitchState2.WhileTrueSubState += (SkillState) lockGraphsState;
      playAnimationState1.animationType.Constant(AnimationStateType.PrimarySkill);
      conditionAction.condition = (Func<bool>) (() => (bool) isReady);
      conditionAction.OnTrue += waitState1.Enter;
      showAoeState1.aoe.Expression((Func<AreaOfEffect>) (() => new AreaOfEffect()
      {
        shape = AoeShape.Rectangle,
        rectWidth = this.barrierDimensions.X,
        rectLength = this.barrierDimensions.Z,
        vfxPrefab = this.aoePrefab
      }));
      showAoeState1.trackOwnerPosition = (SyncableValue<bool>) false;
      ShowAoeState showAoeState2 = showAoeState1;
      showAoeState2.OnUpdate = showAoeState2.OnUpdate + setVar2.Do;
      ShowAoeState showAoeState3 = showAoeState1;
      showAoeState3.SubState = showAoeState3.SubState + (SkillState) playAnimationState2;
      playAnimationState2.animationType.Constant(AnimationStateType.TurnHeadToAim);
      setVar2.var = aimDir;
      setVar2.value.Expression((Func<JVector>) (() => skillGraph.GetAimInputOrLookDir()));
      waitState1.duration.Expression((Func<float>) (() => this.duration));
      WaitState waitState2 = waitState1;
      waitState2.SubState = waitState2.SubState + (SkillState) audioState1;
      WaitState waitState3 = waitState1;
      waitState3.SubState = waitState3.SubState + (SkillState) audioState2;
      WaitState waitState4 = waitState1;
      waitState4.SubState = waitState4.SubState + (SkillState) barrierActiveState1;
      waitState1.onEnterDelegate = (Action) (() => isBarrierActive.Set(true));
      waitState1.onExitDelegate = (Action) (() => isBarrierActive.Set(false));
      WaitState waitState5 = waitState1;
      waitState5.OnEnter = waitState5.OnEnter + setVar1.Do;
      WaitState waitState6 = waitState1;
      waitState6.OnExit = waitState6.OnExit + whileTrueState1.Enter;
      setVar1.var = currentCooldown;
      setVar1.value.Expression((Func<float>) (() => this.cooldown));
      barrierActiveState1.prefab.Constant(this.barrierPrefab);
      barrierActiveState1.barrierPosition = (Func<JVector>) (() => (JVector) barrierPos);
      barrierActiveState1.barrierLookDir = (Func<JVector>) (() => skillGraph.GetAimInputOrLookDir());
      barrierActiveState1.barrierDimensions.Expression((Func<JVector>) (() => this.barrierDimensions));
      BarrierActiveState barrierActiveState2 = barrierActiveState1;
      barrierActiveState2.OnEnter = barrierActiveState2.OnEnter + spawnVfxAction.Do;
      spawnVfxAction.vfxPrefab = this.barrierConnectionPrefab;
      spawnVfxAction.lookDir.Expression((Func<JVector>) (() => skillGraph.GetAimInputOrLookDir() * -1f));
      spawnVfxAction.position.Expression((Func<JVector>) (() => (JVector) barrierPos - skillGraph.GetAimInputOrLookDir() * this.barrierDimensions.Z * 0.5f));
      whileTrueState1.condition = (Func<bool>) (() => (double) (float) currentCooldown > 1.40129846432482E-45);
      WhileTrueState whileTrueState2 = whileTrueState1;
      whileTrueState2.SubState = whileTrueState2.SubState + (SkillState) booleanSwitchState1;
      booleanSwitchState1.condition = (Func<bool>) (() => !skillGraph.IsSkillUseDisabled());
      booleanSwitchState1.WhileTrueSubState += (SkillState) varOverTimeState;
      varOverTimeState.var = currentCooldown;
      varOverTimeState.targetValue = (SyncableValue<float>) 0.0f;
      varOverTimeState.amountPerSecond.Constant(-1f);
      varOverTimeState.onEnterDelegate = (Action) (() => isOnCooldown.Set(true));
      varOverTimeState.onExitDelegate = (Action) (() => isOnCooldown.Set(false));
      onEventAction1.EventType = SkillGraphEvent.SkillPickupCollected;
      onEventAction1.onTriggerDelegate = (Action) (() => currentCooldown.Set(SkillGraph.CalculateRefreshCooldown((float) currentCooldown, this.cooldown)));
      onEventAction2.EventType = SkillGraphEvent.Interrupt;
      onEventAction2.onTriggerDelegate = (Action) (() => input.ResetInput());
      onEventAction3.EventType = SkillGraphEvent.MatchStart;
      onEventAction3.OnTrigger += whileTrueState1.Enter;
      onEventAction4.EventType = SkillGraphEvent.Overtime;
      onEventAction4.OnTrigger += setVar1.Do;
    }
  }
}
