// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.GraphVarList
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.Skills
{
  public class GraphVarList
  {
    public List<SkillVar> skillVars = new List<SkillVar>();
    private Dictionary<string, int> skillVarLookup = new Dictionary<string, int>(16);
    private string varOwnerName;
    private byte instanceIdx;
    private UniqueId ownerId;

    public GraphVarList(string varOwnerName, UniqueId ownerId, byte instanceIdx)
    {
      this.varOwnerName = varOwnerName;
      this.ownerId = ownerId;
      this.instanceIdx = instanceIdx;
    }

    public bool HasVarName(string name) => this.skillVarLookup.ContainsKey(name);

    public SkillVar<T> AddVar<T>(string varName, bool isArray = false) where T : struct
    {
      int count = this.skillVars.Count;
      this.skillVarLookup[varName] = count;
      SkillVar<T> skillVar = new SkillVar<T>(varName, isArray);
      skillVar.SetAddress(this.ownerId, this.instanceIdx, (byte) count);
      this.skillVars.Add((SkillVar) skillVar);
      return skillVar;
    }

    public SkillVar<T> GetVar<T>(string name) where T : struct => (SkillVar<T>) this.skillVars[this.skillVarLookup[name]];

    public T GetValue<T>(string name) where T : struct => this.GetVar<T>(name).Get();

    public SerializedSkillGraphInfo Parse()
    {
      List<SerializedSyncValueInfo> serializationInfo = new List<SerializedSyncValueInfo>();
      int valueIndex = 0;
      foreach (SkillVar skillVar in this.skillVars)
        skillVar.Parse(serializationInfo, ref valueIndex);
      int num;
      if ((double) (num = (int) ((double) serializationInfo.Count / 8.0)) - (double) num > 0.0)
        ++num;
      return new SerializedSkillGraphInfo()
      {
        name = this.varOwnerName,
        numDirtyBytes = num,
        numSyncActions = 0,
        sizeInBytes = 8 + valueIndex,
        serializedSyncValueInfos = serializationInfo
      };
    }

    public void Serialize(byte[] target, ref int writeIndex)
    {
      foreach (SkillVar skillVar in this.skillVars)
        skillVar.Serialize(target, ref writeIndex);
    }

    public void Deserialize(byte[] source, ref int readIndex)
    {
      foreach (SkillVar skillVar in this.skillVars)
        skillVar.Deserialize(source, ref readIndex);
    }
  }
}
