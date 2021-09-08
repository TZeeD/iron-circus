// Decompiled with JetBrains decompiler
// Type: SharedWithServer.ScEvents.GameplayEvent
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Newtonsoft.Json.Linq;

namespace SharedWithServer.ScEvents
{
  public class GameplayEvent
  {
    public readonly double timestamp;
    public readonly GameplayEventType type;
    public JObject payload;

    public GameplayEvent(double timestamp, GameplayEventType type)
    {
      this.timestamp = timestamp;
      this.type = type;
    }

    public GameplayEvent(double timestamp, GameplayEventType type, JObject payload)
    {
      this.timestamp = timestamp;
      this.type = type;
      this.payload = payload;
    }
  }
}
