// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Components.Input
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages.SerDes;
using Jitter.LinearMath;
using System;

namespace Imi.SharedWithServer.ScEntitas.Components
{
  public struct Input : IEquatable<Input>
  {
    public static Input Zero = new Input(JVector.Zero, JVector.Zero, ButtonType.None);
    public static Input Invalid = new Input(new JVector((float) ushort.MaxValue), new JVector((float) ushort.MaxValue), ButtonType.None);
    public JVector moveDir;
    public JVector aimDir;
    public ButtonType downButtons;

    public Input(JVector moveDir, ButtonType downButtons)
    {
      this.moveDir = moveDir;
      this.aimDir = moveDir;
      this.downButtons = downButtons;
    }

    public Input(JVector moveDir, JVector aimDir, ButtonType downButtons)
    {
      this.moveDir = moveDir;
      this.aimDir = aimDir;
      this.downButtons = downButtons;
    }

    public Input(Input input)
    {
      this.moveDir = input.moveDir;
      this.aimDir = input.aimDir;
      this.downButtons = input.downButtons;
    }

    public ButtonType GetStatePlusButton(ButtonType btn) => this.downButtons | btn;

    public ButtonType GetStateMinusButton(ButtonType btn) => this.downButtons & ~btn;

    public void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.Float(ref this.moveDir.X);
      this.moveDir.Y = 0.0f;
      messageSerDes.Float(ref this.moveDir.Z);
      messageSerDes.Float(ref this.aimDir.X);
      this.aimDir.Y = 0.0f;
      messageSerDes.Float(ref this.aimDir.Z);
      ushort downButtons = (ushort) this.downButtons;
      messageSerDes.UShort(ref downButtons);
      this.downButtons = (ButtonType) downButtons;
    }

    public bool Equals(Input other) => this.moveDir.Equals(other.moveDir) && this.aimDir.Equals(other.aimDir) && this.downButtons == other.downButtons;

    public bool Equals(Input other, float epsilon) => (double) Math.Abs(this.moveDir.X - other.moveDir.X) < (double) epsilon && (double) Math.Abs(this.moveDir.Y - other.moveDir.Y) < (double) epsilon && (double) Math.Abs(this.moveDir.Z - other.moveDir.Z) < (double) epsilon && (double) Math.Abs(this.aimDir.X - other.aimDir.X) < (double) epsilon && (double) Math.Abs(this.aimDir.Y - other.aimDir.Y) < (double) epsilon && (double) Math.Abs(this.aimDir.Z - other.aimDir.Z) < (double) epsilon && this.downButtons == other.downButtons;

    public override bool Equals(object obj) => obj != null && obj is Input other && this.Equals(other);

    public override int GetHashCode() => (int) ((ButtonType) ((this.moveDir.GetHashCode() * 397 ^ this.aimDir.GetHashCode()) * 397) ^ this.downButtons);

    public override string ToString() => string.Format("Dir[{0}] AimDir[{1}] ButtonsDown[{2}]", (object) this.moveDir, (object) this.aimDir, (object) this.downButtons);
  }
}
