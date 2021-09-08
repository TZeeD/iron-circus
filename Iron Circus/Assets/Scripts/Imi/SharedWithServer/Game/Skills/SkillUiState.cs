// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.SkillUiState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.ScEntitas.Components;
using Jitter.LinearMath;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.Skills
{
  public class SkillUiState : SkillState
  {
    public ConfigValue<string> iconName;
    public ConfigValue<Imi.SharedWithServer.ScEntitas.Components.ButtonType> buttonType;
    [SyncValue]
    public SyncableValue<float> fillAmount;
    public SyncableValue<float> coolDownLeftAmount;
    public SyncableValue<bool> active;
    private bool btnIsDown;

    public override void Parse(List<SerializedSyncValueInfo> serializationInfo, ref int valueIndex) => this.fillAmount.Parse(serializationInfo, ref valueIndex, this.Name + ".fillAmount");

    public override void Serialize(byte[] target, ref int valueIndex) => this.fillAmount.Serialize(target, ref valueIndex);

    public override void Deserialize(byte[] target, ref int valueIndex) => this.fillAmount.Deserialize(target, ref valueIndex);

    protected override SkillStateExecutionFlag SkillStateExecutionFlag => SkillStateExecutionFlag.TickRemoteEntities;

    protected override void EnterDerived()
    {
    }

    protected override void TickDerived()
    {
      JVector jvector = JVector.Zero;
      GameEntity owner = this.skillGraph.GetOwner();
      bool flag1 = false;
      bool flag2 = false;
      if (this.skillGraph.IsClient() && owner.hasInput && owner.isLocalEntity)
      {
        jvector = this.skillGraph.GetAimInputOrLookDir();
        InputComponent input = owner.input;
        int tick = this.skillGraph.GetTick();
        if (input.ButtonWentDown(this.buttonType.Get(), tick))
        {
          this.btnIsDown = true;
          flag1 = true;
        }
        else if (input.ButtonWentUp(this.buttonType.Get(), tick) && this.btnIsDown)
          this.btnIsDown = false;
        flag2 = this.btnIsDown;
      }
      this.skillGraph.GetOwner().skillUi.AddReplaceState(new SkillUiStateData()
      {
        skillIdx = this.skillGraph.GetInstanceIdx(),
        iconName = this.iconName.Get(),
        buttonType = this.buttonType.Get(),
        fillAmount = this.fillAmount.Get(),
        coolDownLeft = this.coolDownLeftAmount.Get(),
        aimDirection = jvector,
        active = this.active.Get(),
        isButtonDown = flag2,
        onButtonDown = flag1
      });
    }

    protected override void ExitDerived() => this.skillGraph.GetOwner().skillUi.RemoveState(this.skillGraph.GetInstanceIdx());
  }
}
