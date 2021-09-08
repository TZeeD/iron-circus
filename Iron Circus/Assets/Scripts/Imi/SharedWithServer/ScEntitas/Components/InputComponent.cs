// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Components.InputComponent
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Networking.reliable;

namespace Imi.SharedWithServer.ScEntitas.Components
{
  [Game]
  public class InputComponent : ImiComponent
  {
    public SequenceBuffer32<Input> value;

    public void Duplicate(int currentTick)
    {
      if (currentTick > 1)
      {
        Input result;
        if (!this.value.Get((uint) (currentTick - 1), out result))
        {
          Log.Warning("Could not find input to be duplicated.");
        }
        else
        {
          if (this.value.Add((uint) currentTick, result))
            return;
          Log.Warning("Could not insert the duplicated input. #0");
        }
      }
      else
      {
        if (this.value.Add((uint) currentTick, Input.Zero))
          return;
        Log.Warning("Could not insert the duplicated input. #1");
      }
    }

    public void SetInput(int tick, Input input)
    {
      if (this.value.Add((uint) tick, input))
        return;
      Log.Warning("Could not insert the duplicated input. #2");
    }

    public Input GetInput(int tick)
    {
      if (tick < 0)
      {
        Log.Warning("Can not fetch input for negative indices.");
        return Input.Zero;
      }
      Input result;
      if (!this.value.Get((uint) tick, out result))
        result = Input.Zero;
      return result;
    }

    public bool ButtonWentDown(ButtonType btn, int tick) => tick != 0 && (this.GetInput(tick).downButtons & btn) > ButtonType.None && (this.GetInput(tick - 1).downButtons & btn) == ButtonType.None;

    public bool ButtonIsDown(ButtonType btn, int tick) => tick != 0 && (this.GetInput(tick).downButtons & btn) > ButtonType.None;

    public bool ButtonWentUp(ButtonType btn, int tick) => tick != 0 && (this.GetInput(tick).downButtons & btn) == ButtonType.None && (this.GetInput(tick - 1).downButtons & btn) > ButtonType.None;

    public bool ButtonIsUp(ButtonType btn, int tick) => tick != 0 && (this.GetInput(tick).downButtons & btn) == ButtonType.None;
  }
}
