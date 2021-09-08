// Decompiled with JetBrains decompiler
// Type: SharedWithServer.Game.MetaServiceConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

namespace SharedWithServer.Game
{
  public static class MetaServiceConfig
  {
    private const string ProgressionServiceURI = "https://sc-live-progression.steelcircus.net";
    private const string TokenServiceURI = "https://sc-live-token.steelcircus.net";
    public const string UsersServiceURI = "https://sc-live-users.steelcircus.net/";
    private const string GameliftServiceURI = "https://sc-live-gamelift.steelcircus.net";
    private const string PUBLIC_ROUTE = "/public";
    private const string PROTECTED_ROUTE = "/protected";
    private const string PRIVATE_ROUTE = "/private";
    private const string PLAYER_ROUTE = "/player/:playerId";
    private const string STEAM_PLAYER_ROUTE = "/steam_player/:steamId";
    private const string PLAYERS_ROUTE = "/players";
    public const string TokenService = "https://sc-live-token.steelcircus.net/api/get_connect_token";
    public const string GameLiftServiceProtected = "https://sc-live-progression.steelcircus.net/protected/gamelift";
    public const string GameLiftServicePublic = "https://sc-live-progression.steelcircus.net/public/gamelift";
    public const string HealthService = "/public/health";
    public const string NewsService = "https://sc-live-progression.steelcircus.net/protected/news";
    public const string VoiceChatTokenService = "https://sc-live-progression.steelcircus.net/protected/voiceChat/generateToken";
    public const string MatchmakingSystemService = "https://sc-live-progression.steelcircus.net/protected/gamelift/matchmakingSystem";
    public const string LoginService = "https://sc-live-progression.steelcircus.net/public/login";
    public const string LogoutService = "https://sc-live-progression.steelcircus.net/protected/player/:playerId/logout";
    public const string GetPlayerIdService = "https://sc-live-progression.steelcircus.net/protected/steam_player/:steamId/playerId";
    public const string GetLoadoutsService = "https://sc-live-progression.steelcircus.net/protected/players/loadouts";
    public const string GetLevelsService = "https://sc-live-progression.steelcircus.net/protected/players/levels";
    public const string GetPlayersSteamIdsService = "https://sc-live-progression.steelcircus.net/protected/players/steamId";
    public const string GetItemDefinitionsService = "https://sc-live-progression.steelcircus.net/protected/items";
    public const string GetPlayerProgressService = "https://sc-live-progression.steelcircus.net/protected/player/:playerId/progress";
    public const string GetPlayerStatiscticsService = "https://sc-live-progression.steelcircus.net/protected/player/:playerId/progress/stats";
    public const string GetPlayerPenaltyService = "https://sc-live-progression.steelcircus.net/protected/player/:playerId/progress/penalty";
    public const string GetPlayerMatchProgressService = "https://sc-live-progression.steelcircus.net/public/player/:playerId/progress/match/:matchId";
    public const string GetQuestsProgressService = "https://sc-live-progression.steelcircus.net/protected/player/:playerId/progress/quests/daily";
    public const string GetTutorialProgressService = "https://sc-live-progression.steelcircus.net/protected/player/:playerId/progress/quests/once";
    public const string GetMilestoneProgressService = "https://sc-live-progression.steelcircus.net/protected/player/:playerId/progress/levelmilestone";
    public const string CollectRewardService = "https://sc-live-progression.steelcircus.net/protected/player/:playerId/progress/reward/:rewardId/collect";
    public const string GetPlayerItemsService = "https://sc-live-progression.steelcircus.net/protected/player/:playerId/items";
    public const string GetPlayerItemByTypeService = "https://sc-live-progression.steelcircus.net/protected/player/:playerId/items/type/:type";
    public const string GetPlayerShopItemByTypeService = "https://sc-live-progression.steelcircus.net/protected/shop/items/type/:type";
    public const string EquipItemService = "https://sc-live-progression.steelcircus.net/protected/player/:playerId/items/equip";
    public const string GetPlayerLoadoutService = "https://sc-live-progression.steelcircus.net/protected/player/:playerId/items/loadouts";
    public const string GetShopCreditPacksService = "https://sc-live-progression.steelcircus.net/protected/shop/credit_packs";
    public const string GetWeeklyShopRotationService = "https://sc-live-progression.steelcircus.net/protected/shop/items/weekly";
    public const string GetShopItemsService = "https://sc-live-progression.steelcircus.net/protected/shop/items";
    public const string InitShopMicroTransactionService = "https://sc-live-progression.steelcircus.net/protected/player/:playerId/shop/credit_packs/init_micro_transaction";
    public const string FinalizeShopMicroTransactionService = "https://sc-live-progression.steelcircus.net/protected/player/:playerId/shop/credit_packs/finalize_micro_transaction";
    public const string UnlockItemWithCreditsService = "https://sc-live-progression.steelcircus.net/protected/player/:playerId/shop/items/:itemId/buy";
    public const string UnlockWeeklyRotationItemWithSteelService = "https://sc-live-progression.steelcircus.net/protected/player/:playerId/shop/items/weekly/:itemId/buy";
    public const string CheckDlcStatusService = "https://sc-live-progression.steelcircus.net/protected/shop/dlcs/update";
    public const string DlcShopContentService = "https://sc-live-progression.steelcircus.net/protected/shop/dlcs";
    public const string DlcItemListService = "https://sc-live-progression.steelcircus.net/protected/shop/dlcs/:dlcId/items";
    public const string GetTwitchAuthTokenService = "https://sc-live-progression.steelcircus.net/protected/player/:playerId/twitch/auth/start/";
    public const string TwitchUISettingsService = "https://sc-live-progression.steelcircus.net/protected/player/:playerId/twitch/settings";
    public const string TwitchUserInfoService = "https://sc-live-progression.steelcircus.net/protected/player/:playerId/twitch/user";
    public const string GetUserNameServerService = "https://sc-live-progression.steelcircus.net/private/player/:playerId/user";
    public const string GetTwitchInfoServerService = "https://sc-live-progression.steelcircus.net/private/player/:playerId/twitch/user";
    public const string GetUnlockedChampionsServerService = "https://sc-live-progression.steelcircus.net/private/player/:playerId/items/type/:type";
    private const string ServerManagerAddress = "192.168.1.74";
    public static readonly string ServerManager = "http://192.168.1.74:5000";
  }
}
