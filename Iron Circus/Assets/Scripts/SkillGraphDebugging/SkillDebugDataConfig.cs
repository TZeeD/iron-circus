// Decompiled with JetBrains decompiler
// Type: SkillGraphDebugging.SkillDebugDataConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections.Generic;
using UnityEngine;

namespace SkillGraphDebugging
{
  [PreferBinarySerialization]
  public class SkillDebugDataConfig : GameConfigEntry
  {
    public List<SkillGraphDebugVar> variableValueRefs;
    public List<SkillGraphDebugNode> nodes;
    [HideInInspector]
    public int debugStateSize;
    public List<SkillGraphDebugState> debugStates;

    public SkillDebugDataConfig()
    {
      this.variableValueRefs = new List<SkillGraphDebugVar>();
      this.nodes = new List<SkillGraphDebugNode>();
      this.debugStates = new List<SkillGraphDebugState>();
    }
  }
}
