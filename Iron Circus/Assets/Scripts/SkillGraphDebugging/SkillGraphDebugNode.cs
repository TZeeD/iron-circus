// Decompiled with JetBrains decompiler
// Type: SkillGraphDebugging.SkillGraphDebugNode
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Collections.Generic;

namespace SkillGraphDebugging
{
  [Serializable]
  public struct SkillGraphDebugNode
  {
    public string displayName;
    public List<SkillGraphDebugPlug> inPlugs;
    public List<SkillGraphDebugPlug> outPlugs;
    public List<SkillGraphDebugPlug> subStates;
    public List<SkillGraphDebugVar> nodeVariables;
  }
}
