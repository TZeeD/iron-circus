// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.EntitasSetup
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using SharedWithServer.ScEvents;

namespace Imi.SharedWithServer.ScEntitas
{
  public class EntitasSetup
  {
    public EntitasSetup(
      Contexts contexts,
      GameEntityFactory gameEntityFactory,
      ConfigProvider configProvider,
      Events events,
      int numPlayers = -1)
    {
      this.Contexts = contexts;
      this.GameEntityFactory = gameEntityFactory;
      this.ConfigProvider = configProvider;
      this.Events = events;
      if (numPlayers == -1)
        this.NumPlayers = configProvider.debugConfig.numLocalPlayers;
      else
        this.NumPlayers = numPlayers;
    }

    public Contexts Contexts { get; }

    public GameEntityFactory GameEntityFactory { get; }

    public ConfigProvider ConfigProvider { get; }

    public Events Events { get; }

    public int NumPlayers { get; }
  }
}
