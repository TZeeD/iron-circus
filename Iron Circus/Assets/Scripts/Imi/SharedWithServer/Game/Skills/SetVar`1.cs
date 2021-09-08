// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.SetVar`1
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

namespace Imi.SharedWithServer.Game.Skills
{
  public class SetVar<T> : SkillAction where T : struct
  {
    public SkillVar<T> var;
    public SyncableValue<T> value;
    private string nullMsg;

    protected override bool DoOnRepredict => true;

    protected override void PerformActionInternal() => this.var.Set(this.value.Get());
  }
}
