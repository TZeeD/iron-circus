// Decompiled with JetBrains decompiler
// Type: Imi.Diagnostics.AssertionFailedException
// Assembly: ImiDiagnostics, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 9CCF0324-3C3A-43B7-BFB6-8D5767C31D69
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\ImiDiagnostics.dll

using System;

namespace Imi.Diagnostics
{
  public class AssertionFailedException : Exception
  {
    public AssertionFailedException()
    {
    }

    public AssertionFailedException(string message)
      : base(message)
    {
    }

    public AssertionFailedException(string message, Exception inner)
      : base(message, inner)
    {
    }
  }
}
