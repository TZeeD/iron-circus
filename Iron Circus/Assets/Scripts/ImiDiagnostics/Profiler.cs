// Decompiled with JetBrains decompiler
// Type: Imi.Diagnostics.Profiler
// Assembly: ImiDiagnostics, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 9CCF0324-3C3A-43B7-BFB6-8D5767C31D69
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\ImiDiagnostics.dll

using System.Diagnostics;

namespace Imi.Diagnostics
{
  public class Profiler
  {
    [Conditional("ENABLE_PROFILER")]
    public static void BeginSample(string sampleName)
    {
    }

    [Conditional("ENABLE_PROFILER")]
    public static void EndSample()
    {
    }
  }
}
