// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEvents.StatEvents.GameLogEvent
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace Imi.SharedWithServer.ScEvents.StatEvents
{
  public class GameLogEvent
  {
    [JsonProperty]
    private readonly string table;
    [JsonProperty]
    private readonly JObject fields;

    public GameLogEvent(string table, JObject fields)
    {
      this.table = table;
      this.fields = fields;
    }

    public JObject ToJson() => JObject.FromObject((object) this);
  }
}
