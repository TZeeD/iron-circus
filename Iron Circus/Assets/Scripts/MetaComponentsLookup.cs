// Decompiled with JetBrains decompiler
// Type: MetaComponentsLookup
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.ScEntitas.Components;
using SteelCircus.ScEntitas.Components;
using System;

public static class MetaComponentsLookup
{
  public const int MetaChampionsUnlocked = 0;
  public const int MetaIsArenaLoaded = 1;
  public const int MetaIsChampionUnlockedDataLoaded = 2;
  public const int MetaIsConnected = 3;
  public const int MetaIsReady = 4;
  public const int MetaIsTokenVerified = 5;
  public const int MetaMatch = 6;
  public const int MetaPickOrder = 7;
  public const int MetaPlayerId = 8;
  public const int MetaState = 9;
  public const int MetaTeam = 10;
  public const int MetaLoadout = 11;
  public const int MetaNetwork = 12;
  public const int MetaUsername = 13;
  public const int TotalComponents = 14;
  public static readonly string[] componentNames = new string[14]
  {
    nameof (MetaChampionsUnlocked),
    nameof (MetaIsArenaLoaded),
    nameof (MetaIsChampionUnlockedDataLoaded),
    nameof (MetaIsConnected),
    nameof (MetaIsReady),
    nameof (MetaIsTokenVerified),
    nameof (MetaMatch),
    nameof (MetaPickOrder),
    nameof (MetaPlayerId),
    nameof (MetaState),
    nameof (MetaTeam),
    nameof (MetaLoadout),
    nameof (MetaNetwork),
    nameof (MetaUsername)
  };
  public static readonly Type[] componentTypes = new Type[14]
  {
    typeof (MetaChampionsUnlockedComponent),
    typeof (MetaIsArenaLoadedComponent),
    typeof (Imi.ScEntitas.Components.MetaIsChampionUnlockedDataLoaded),
    typeof (MetaIsConnectedComponent),
    typeof (MetaIsReadyComponent),
    typeof (MetaIsTokenVerifiedComponent),
    typeof (MetaMatchComponent),
    typeof (MetaPickOrderComponent),
    typeof (MetaPlayerIdComponent),
    typeof (MetaStateComponent),
    typeof (MetaTeamComponent),
    typeof (MetaLoadoutComponent),
    typeof (MetaNetworkComponent),
    typeof (MetaUsernameComponent)
  };
}
