// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.ButtonState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.ScEntitas.Components;
using System;

namespace Imi.SharedWithServer.Game.Skills
{
  public class ButtonState : SkillState
  {
    public ConfigValue<Imi.SharedWithServer.ScEntitas.Components.ButtonType> buttonType;
    public InPlug Reset;
    public Action onButtonDownDelegate;
    public Action onButtonUpDelegate;
    public OutPlug OnButtonDown;
    public OutPlug OnButtonUp;
    public SubStates buttonDownSubStates;
    public SubStates buttonUpSubStates;
    private bool btnIsDown;

    public ButtonState()
    {
      this.Reset = this.AddInPlug(new Action(this.ResetInput));
      this.OnButtonDown = this.AddOutPlug();
      this.OnButtonUp = this.AddOutPlug();
    }

    protected override void EnterDerived()
    {
      GameEntity owner = this.GetOwner();
      if (!owner.hasInput)
        return;
      InputComponent input = owner.input;
      int tick1 = this.skillGraph.GetTick();
      int num = (int) this.buttonType.Get();
      int tick2 = tick1;
      if (input.ButtonIsDown((Imi.SharedWithServer.ScEntitas.Components.ButtonType) num, tick2))
        this.OnBtnDown();
      else
        this.OnBtnUp();
    }

    protected override void TickDerived()
    {
      GameEntity owner = this.GetOwner();
      if (!owner.hasInput)
        return;
      InputComponent input = owner.input;
      int tick = this.skillGraph.GetTick();
      if (input.ButtonWentDown(this.buttonType.Get(), tick))
      {
        this.OnBtnDown();
      }
      else
      {
        if (!input.ButtonWentUp(this.buttonType.Get(), tick))
          return;
        this.OnBtnUp();
      }
    }

    private void OnBtnDown()
    {
      this.btnIsDown = true;
      this.buttonDownSubStates.Fire(this.skillGraph);
      this.buttonUpSubStates.Abort(this.skillGraph);
      Action buttonDownDelegate = this.onButtonDownDelegate;
      if (buttonDownDelegate != null)
        buttonDownDelegate();
      this.OnButtonDown.Fire(this.skillGraph);
    }

    private void OnBtnUp()
    {
      this.btnIsDown = false;
      this.buttonDownSubStates.Abort(this.skillGraph);
      this.buttonUpSubStates.Fire(this.skillGraph);
      Action buttonUpDelegate = this.onButtonUpDelegate;
      if (buttonUpDelegate != null)
        buttonUpDelegate();
      this.OnButtonUp.Fire(this.skillGraph);
    }

    public void ResetInput()
    {
      if (!this.btnIsDown)
        return;
      this.btnIsDown = false;
      Action buttonUpDelegate = this.onButtonUpDelegate;
      if (buttonUpDelegate != null)
        buttonUpDelegate();
      this.buttonUpSubStates.Fire(this.skillGraph);
      this.buttonDownSubStates.Abort(this.skillGraph);
    }

    protected override void ExitDerived()
    {
      this.buttonDownSubStates.Abort(this.skillGraph);
      this.buttonUpSubStates.Abort(this.skillGraph);
    }
  }
}
