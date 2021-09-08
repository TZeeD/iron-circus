// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.ChampionTypeHelper
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using System;

namespace Imi.SharedWithServer.Game
{
  public static class ChampionTypeHelper
  {
    public static ChampionConfig GetChampionConfigFor(
      ChampionType championType,
      ConfigProvider configProvider)
    {
      ChampionConfig championConfig = (ChampionConfig) null;
      switch (championType)
      {
        case ChampionType.Servitor:
          championConfig = configProvider.servitor;
          break;
        case ChampionType.Bagpipes:
          championConfig = configProvider.bagpipes;
          break;
        case ChampionType.Li:
          championConfig = configProvider.li;
          break;
        case ChampionType.Mali:
          championConfig = configProvider.mali;
          break;
        case ChampionType.Hildegard:
          championConfig = configProvider.hildegard;
          break;
        case ChampionType.Acrid:
          championConfig = configProvider.acrid;
          break;
        case ChampionType.Galena:
          championConfig = configProvider.galena;
          break;
        case ChampionType.Kenny:
          championConfig = configProvider.kenny;
          break;
        case ChampionType.Robot:
          championConfig = configProvider.robot;
          break;
      }
      return !((UnityEngine.Object) championConfig == (UnityEngine.Object) null) ? championConfig : throw new Exception(string.Format("No ChampionConfig found in ConfigProvider for ChampionType: '{0}'", (object) championType));
    }
  }
}
