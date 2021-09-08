// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Components.SkillGraphComponent
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game.Skills;

namespace Imi.SharedWithServer.ScEntitas.Components
{
  [global::Game]
  public class SkillGraphComponent : ImiComponent
  {
    public SkillGraphConfig[] skillGraphConfigs;
    public SerializedSkillGraphInfo[] serializationLayout;
    public SkillGraph[] skillGraphs;
    public int lockingGraph;
    public GraphVarList ownerVars;

    public SkillVar<T> AddVar<T>(string name, bool isArray = false) where T : struct => this.ownerVars.AddVar<T>(name, isArray);

    public SkillVar<T> GetVar<T>(string name) where T : struct => this.ownerVars.GetVar<T>(name);
  }
}
