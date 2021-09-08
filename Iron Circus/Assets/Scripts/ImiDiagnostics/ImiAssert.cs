// Decompiled with JetBrains decompiler
// Type: Imi.Diagnostics.ImiAssert
// Assembly: ImiDiagnostics, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 9CCF0324-3C3A-43B7-BFB6-8D5767C31D69
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\ImiDiagnostics.dll

using System.Diagnostics;

namespace Imi.Diagnostics
{
  public class ImiAssert
  {
    [Conditional("DEBUG")]
    [Conditional("UNITY_ASSERTIONS")]
    public static void IsTrue(bool isTrue, string message = "", params string[] p0)
    {
      if (!isTrue)
        throw new AssertionFailedException(string.Format(message, (object[]) p0));
    }

    [Conditional("DEBUG")]
    [Conditional("UNITY_ASSERTIONS")]
    public static void Fail(string message) => throw new AssertionFailedException(message);
  }
}
