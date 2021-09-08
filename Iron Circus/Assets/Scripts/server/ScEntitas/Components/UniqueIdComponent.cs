// Decompiled with JetBrains decompiler
// Type: server.ScEntitas.Components.UniqueIdComponent
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas.CodeGeneration.Attributes;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas.Components;

namespace server.ScEntitas.Components
{
  [global::Game]
  public class UniqueIdComponent : ImiComponent
  {
    [EntityIndex]
    public UniqueId id;

    public override string ToString() => string.Format("UniqueId[{0}]", (object) this.id);
  }
}
