// Decompiled with JetBrains decompiler
// Type: SharedWithServer.Debug.SkillGraphCallStackEntry
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

namespace SharedWithServer.Debug
{
  public struct SkillGraphCallStackEntry
  {
    public SkillGraphCallType type;
    public string info;

    public override string ToString()
    {
      if (this.type == SkillGraphCallType.EnterState)
        return string.Format("<color=#00ff00>[{0}] {1}</color>", (object) this.type, (object) this.info);
      return this.type == SkillGraphCallType.ExitState ? string.Format("<color=#ff0000>[{0}] {1}</color>", (object) this.type, (object) this.info) : string.Format("[{0}] {1}", (object) this.type, (object) this.info);
    }
  }
}
