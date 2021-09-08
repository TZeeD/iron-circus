// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Rumpfield.Utils.Budget
// Assembly: _Rumpfield_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 2AEA7BF5-2F28-40B9-90B7-2EF49603B6E2
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Rumpfield_AssemblyDefinition.dll

using System;

namespace Imi.SharedWithServer.Networking.Rumpfield.Utils
{
  public struct Budget : IEquatable<Budget>
  {
    public readonly int bytes;
    public readonly int messages;
    private const int ThresholdBytes = 8;

    public Budget(int byteBudget, int messageBudget)
    {
      this.bytes = byteBudget;
      this.messages = messageBudget;
    }

    public static Budget Substract(Budget lhs, Budget rhs) => new Budget(lhs.bytes - rhs.bytes, lhs.messages - rhs.messages);

    public static Budget Substract(Budget lhs, int rhsBytes, int rhsMessages) => Budget.Substract(lhs, new Budget(rhsBytes, rhsMessages));

    public static Budget Add(Budget lhs, Budget rhs) => new Budget(lhs.bytes + rhs.bytes, lhs.messages + rhs.messages);

    public static bool DoesFitWithoutStarvation(Budget b, Budget toFit) => !Budget.Starved(Budget.Substract(b, toFit));

    public static bool Starved(Budget b) => b.messages == 0 || b.bytes < 8;

    public bool Equals(Budget other) => this.bytes == other.bytes && this.messages == other.messages;

    public override bool Equals(object obj) => obj != null && obj is Budget other && this.Equals(other);

    public override int GetHashCode() => this.bytes * 397 ^ this.messages;
  }
}
