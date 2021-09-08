// Decompiled with JetBrains decompiler
// Type: MetaMatcher
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;

public sealed class MetaMatcher
{
  private static IMatcher<MetaEntity> _matcherMetaChampionsUnlocked;
  private static IMatcher<MetaEntity> _matcherMetaIsArenaLoaded;
  private static IMatcher<MetaEntity> _matcherMetaIsChampionUnlockedDataLoaded;
  private static IMatcher<MetaEntity> _matcherMetaIsConnected;
  private static IMatcher<MetaEntity> _matcherMetaIsReady;
  private static IMatcher<MetaEntity> _matcherMetaIsTokenVerified;
  private static IMatcher<MetaEntity> _matcherMetaLoadout;
  private static IMatcher<MetaEntity> _matcherMetaMatch;
  private static IMatcher<MetaEntity> _matcherMetaNetwork;
  private static IMatcher<MetaEntity> _matcherMetaPickOrder;
  private static IMatcher<MetaEntity> _matcherMetaPlayerId;
  private static IMatcher<MetaEntity> _matcherMetaState;
  private static IMatcher<MetaEntity> _matcherMetaTeam;
  private static IMatcher<MetaEntity> _matcherMetaUsername;

  public static IMatcher<MetaEntity> MetaChampionsUnlocked
  {
    get
    {
      if (MetaMatcher._matcherMetaChampionsUnlocked == null)
      {
        Matcher<MetaEntity> matcher = (Matcher<MetaEntity>) Matcher<MetaEntity>.AllOf(new int[1]);
        matcher.componentNames = MetaComponentsLookup.componentNames;
        MetaMatcher._matcherMetaChampionsUnlocked = (IMatcher<MetaEntity>) matcher;
      }
      return MetaMatcher._matcherMetaChampionsUnlocked;
    }
  }

  public static IMatcher<MetaEntity> MetaIsArenaLoaded
  {
    get
    {
      if (MetaMatcher._matcherMetaIsArenaLoaded == null)
      {
        Matcher<MetaEntity> matcher = (Matcher<MetaEntity>) Matcher<MetaEntity>.AllOf(1);
        matcher.componentNames = MetaComponentsLookup.componentNames;
        MetaMatcher._matcherMetaIsArenaLoaded = (IMatcher<MetaEntity>) matcher;
      }
      return MetaMatcher._matcherMetaIsArenaLoaded;
    }
  }

  public static IMatcher<MetaEntity> MetaIsChampionUnlockedDataLoaded
  {
    get
    {
      if (MetaMatcher._matcherMetaIsChampionUnlockedDataLoaded == null)
      {
        Matcher<MetaEntity> matcher = (Matcher<MetaEntity>) Matcher<MetaEntity>.AllOf(2);
        matcher.componentNames = MetaComponentsLookup.componentNames;
        MetaMatcher._matcherMetaIsChampionUnlockedDataLoaded = (IMatcher<MetaEntity>) matcher;
      }
      return MetaMatcher._matcherMetaIsChampionUnlockedDataLoaded;
    }
  }

  public static IMatcher<MetaEntity> MetaIsConnected
  {
    get
    {
      if (MetaMatcher._matcherMetaIsConnected == null)
      {
        Matcher<MetaEntity> matcher = (Matcher<MetaEntity>) Matcher<MetaEntity>.AllOf(3);
        matcher.componentNames = MetaComponentsLookup.componentNames;
        MetaMatcher._matcherMetaIsConnected = (IMatcher<MetaEntity>) matcher;
      }
      return MetaMatcher._matcherMetaIsConnected;
    }
  }

  public static IMatcher<MetaEntity> MetaIsReady
  {
    get
    {
      if (MetaMatcher._matcherMetaIsReady == null)
      {
        Matcher<MetaEntity> matcher = (Matcher<MetaEntity>) Matcher<MetaEntity>.AllOf(4);
        matcher.componentNames = MetaComponentsLookup.componentNames;
        MetaMatcher._matcherMetaIsReady = (IMatcher<MetaEntity>) matcher;
      }
      return MetaMatcher._matcherMetaIsReady;
    }
  }

  public static IMatcher<MetaEntity> MetaIsTokenVerified
  {
    get
    {
      if (MetaMatcher._matcherMetaIsTokenVerified == null)
      {
        Matcher<MetaEntity> matcher = (Matcher<MetaEntity>) Matcher<MetaEntity>.AllOf(5);
        matcher.componentNames = MetaComponentsLookup.componentNames;
        MetaMatcher._matcherMetaIsTokenVerified = (IMatcher<MetaEntity>) matcher;
      }
      return MetaMatcher._matcherMetaIsTokenVerified;
    }
  }

  public static IMatcher<MetaEntity> MetaLoadout
  {
    get
    {
      if (MetaMatcher._matcherMetaLoadout == null)
      {
        Matcher<MetaEntity> matcher = (Matcher<MetaEntity>) Matcher<MetaEntity>.AllOf(11);
        matcher.componentNames = MetaComponentsLookup.componentNames;
        MetaMatcher._matcherMetaLoadout = (IMatcher<MetaEntity>) matcher;
      }
      return MetaMatcher._matcherMetaLoadout;
    }
  }

  public static IMatcher<MetaEntity> MetaMatch
  {
    get
    {
      if (MetaMatcher._matcherMetaMatch == null)
      {
        Matcher<MetaEntity> matcher = (Matcher<MetaEntity>) Matcher<MetaEntity>.AllOf(6);
        matcher.componentNames = MetaComponentsLookup.componentNames;
        MetaMatcher._matcherMetaMatch = (IMatcher<MetaEntity>) matcher;
      }
      return MetaMatcher._matcherMetaMatch;
    }
  }

  public static IMatcher<MetaEntity> MetaNetwork
  {
    get
    {
      if (MetaMatcher._matcherMetaNetwork == null)
      {
        Matcher<MetaEntity> matcher = (Matcher<MetaEntity>) Matcher<MetaEntity>.AllOf(12);
        matcher.componentNames = MetaComponentsLookup.componentNames;
        MetaMatcher._matcherMetaNetwork = (IMatcher<MetaEntity>) matcher;
      }
      return MetaMatcher._matcherMetaNetwork;
    }
  }

  public static IMatcher<MetaEntity> MetaPickOrder
  {
    get
    {
      if (MetaMatcher._matcherMetaPickOrder == null)
      {
        Matcher<MetaEntity> matcher = (Matcher<MetaEntity>) Matcher<MetaEntity>.AllOf(7);
        matcher.componentNames = MetaComponentsLookup.componentNames;
        MetaMatcher._matcherMetaPickOrder = (IMatcher<MetaEntity>) matcher;
      }
      return MetaMatcher._matcherMetaPickOrder;
    }
  }

  public static IMatcher<MetaEntity> MetaPlayerId
  {
    get
    {
      if (MetaMatcher._matcherMetaPlayerId == null)
      {
        Matcher<MetaEntity> matcher = (Matcher<MetaEntity>) Matcher<MetaEntity>.AllOf(8);
        matcher.componentNames = MetaComponentsLookup.componentNames;
        MetaMatcher._matcherMetaPlayerId = (IMatcher<MetaEntity>) matcher;
      }
      return MetaMatcher._matcherMetaPlayerId;
    }
  }

  public static IMatcher<MetaEntity> MetaState
  {
    get
    {
      if (MetaMatcher._matcherMetaState == null)
      {
        Matcher<MetaEntity> matcher = (Matcher<MetaEntity>) Matcher<MetaEntity>.AllOf(9);
        matcher.componentNames = MetaComponentsLookup.componentNames;
        MetaMatcher._matcherMetaState = (IMatcher<MetaEntity>) matcher;
      }
      return MetaMatcher._matcherMetaState;
    }
  }

  public static IMatcher<MetaEntity> MetaTeam
  {
    get
    {
      if (MetaMatcher._matcherMetaTeam == null)
      {
        Matcher<MetaEntity> matcher = (Matcher<MetaEntity>) Matcher<MetaEntity>.AllOf(10);
        matcher.componentNames = MetaComponentsLookup.componentNames;
        MetaMatcher._matcherMetaTeam = (IMatcher<MetaEntity>) matcher;
      }
      return MetaMatcher._matcherMetaTeam;
    }
  }

  public static IMatcher<MetaEntity> MetaUsername
  {
    get
    {
      if (MetaMatcher._matcherMetaUsername == null)
      {
        Matcher<MetaEntity> matcher = (Matcher<MetaEntity>) Matcher<MetaEntity>.AllOf(13);
        matcher.componentNames = MetaComponentsLookup.componentNames;
        MetaMatcher._matcherMetaUsername = (IMatcher<MetaEntity>) matcher;
      }
      return MetaMatcher._matcherMetaUsername;
    }
  }

  public static IAllOfMatcher<MetaEntity> AllOf(params int[] indices) => Matcher<MetaEntity>.AllOf(indices);

  public static IAllOfMatcher<MetaEntity> AllOf(
    params IMatcher<MetaEntity>[] matchers)
  {
    return Matcher<MetaEntity>.AllOf(matchers);
  }

  public static IAnyOfMatcher<MetaEntity> AnyOf(params int[] indices) => Matcher<MetaEntity>.AnyOf(indices);

  public static IAnyOfMatcher<MetaEntity> AnyOf(
    params IMatcher<MetaEntity>[] matchers)
  {
    return Matcher<MetaEntity>.AnyOf(matchers);
  }
}
