// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.UI.Network.MetaServiceHelpers
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Game;
using Imi.SteelCircus.Core;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Steamworks;
using SteelCircus.Core.Services;
using SteelCircus.UI;
using SteelCircus.UI.Popups;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using UnityEngine.Networking;
using UnityEngine.UI;

namespace Imi.SteelCircus.UI.Network
{
  public class MetaServiceHelpers : SingletonManager<MetaServiceHelpers>
  {
    public static Dictionary<ShopManager.ShopItemType, string> progressionServiceItemTypeStrings = new Dictionary<ShopManager.ShopItemType, string>()
    {
      {
        ShopManager.ShopItemType.spray,
        "sprayTag"
      },
      {
        ShopManager.ShopItemType.champion,
        "champion"
      },
      {
        ShopManager.ShopItemType.skin,
        "skin"
      },
      {
        ShopManager.ShopItemType.emote,
        "emote"
      },
      {
        ShopManager.ShopItemType.victoryPose,
        "pose"
      },
      {
        ShopManager.ShopItemType.avatarIcon,
        "avatarIcon"
      }
    };
    private static int ConnectTokenRequestErrors = 0;
    private static string userCookie = (string) null;

    public static IEnumerator LoginToUserService(
      string userName,
      string steamAuthSessionTicket,
      HAuthTicket authTicket,
      Action<ulong> OnLoginSuccessful,
      Action<string> OnLoginError,
      Action<string> onClientVersionMismatch)
    {
      Log.Debug("Clearing CookieChache before Login");
      UnityWebRequest.ClearCookieCache();
      Log.Debug(steamAuthSessionTicket ?? "");
      JObject jsonParams = new JObject()
      {
        ["username"] = (JToken) userName,
        ["version"] = (JToken) "20191126-216_live_Update_0.8"
      };
      if (authTicket != HAuthTicket.Invalid)
        jsonParams["steam_auth_session_ticket"] = (JToken) steamAuthSessionTicket;
      return MetaServiceHelpers.HttpPostJsonWithAuth("https://sc-live-progression.steelcircus.net/public/login", jsonParams, (Action<string>) (error =>
      {
        MetaServiceHelpers.CancelSteamAuthTicket(authTicket);
        ImiServices.Instance.Analytics.OnLoginFailed("ServicesNotReachable");
        OnLoginError("Servers are Offline!");
        Log.Error("Could not contact login service: " + error);
      }), (Action<JObject>) (resultJson =>
      {
        MetaServiceHelpers.CancelSteamAuthTicket(authTicket);
        if (resultJson["error"] != null)
        {
          if (resultJson["error"].ToString() != "maintenance" && resultJson["error"].ToString() != "banned")
            ImiServices.Instance.Analytics.OnLoginFailed("LoginReturnedError");
          Log.Error("Login service returned error: " + resultJson["error"].ToString());
          OnLoginError(resultJson["error"].ToString());
        }
        else if (resultJson["version"] != null)
        {
          Log.Debug("Checking client Version against Database Version: Client: 20191126-216_live_Update_0.8 - Database: " + resultJson["version"].ToString());
          if (resultJson["version"].ToString().Equals("20191126-216_live_Update_0.8"))
          {
            Log.Debug("Login success!");
            OnLoginSuccessful((ulong) resultJson["playerId"]);
          }
          else
            onClientVersionMismatch(resultJson["version"].ToString());
        }
        else
          Log.Error("Login service returned no Version");
      }));
    }

    public static IEnumerator LoginToFakeUserService(
      string userName,
      string steamAuthSessionTicket,
      Action<ulong> OnLoginSuccessful,
      Action<string> OnLoginError,
      Action<string> onClientVersionMismatch)
    {
      Log.Debug(steamAuthSessionTicket ?? "");
      JObject jsonParams = new JObject()
      {
        ["username"] = (JToken) userName,
        ["version"] = (JToken) "20191126-216_live_Update_0.8"
      };
      jsonParams["steam_auth_session_ticket"] = (JToken) steamAuthSessionTicket;
      return MetaServiceHelpers.HttpPostJsonWithAuth("https://sc-live-progression.steelcircus.net/public/login", jsonParams, (Action<string>) (error => Log.Error("Could not contact login service: " + error + ".")), (Action<JObject>) (resultJson =>
      {
        if (resultJson["error"] != null)
        {
          Log.Error("Login service returned error: " + resultJson["error"].ToString());
          OnLoginError(resultJson["error"].ToString());
        }
        else if (resultJson["version"] == null)
        {
          Log.Debug("Login success!");
          OnLoginSuccessful((ulong) resultJson["playerId"]);
        }
        else if (resultJson["version"].ToString().Equals("20191126-216_live_Update_0.8"))
        {
          Log.Debug("Login success!");
          OnLoginSuccessful((ulong) resultJson["playerId"]);
        }
        else
          onClientVersionMismatch(resultJson["version"].ToString());
      }));
    }

    public static IEnumerator LogoutFromUserService(
      ulong playerId,
      Action OnLogoutSuccessful,
      Action<string> OnLogoutError)
    {
      Log.Debug(string.Format("{0} Logout", (object) playerId));
      JObject jsonParams = new JObject()
      {
        [nameof (playerId)] = (JToken) playerId
      };
      string url = MetaServiceHelpers.ReplaceParametersInUrl("https://sc-live-progression.steelcircus.net/protected/player/:playerId/logout", new JObject()
      {
        [":playerId"] = (JToken) playerId
      });
      try
      {
        return MetaServiceHelpers.HttpPostJson(url, jsonParams, (Action<string>) (error => Log.Error("Could not contact logout service: " + error + ".")), (Action<JObject>) (resultJson =>
        {
          if (resultJson["error"] != null)
          {
            Log.Error(string.Format("Logout service returned error: {0}", (object) resultJson["error"]));
            OnLogoutError(resultJson["error"].ToString());
          }
          else
            Log.Debug("Logout success!");
          OnLogoutSuccessful();
        }));
      }
      catch (JsonReaderException ex)
      {
        OnLogoutError(string.Format("LOGOUT: Could not read JSON. {0}", (object) ex));
        return (IEnumerator) null;
      }
    }

    private static void CancelSteamAuthTicket(HAuthTicket authTicket)
    {
      if (!(authTicket != HAuthTicket.Invalid))
        return;
      SteamUser.CancelAuthTicket(authTicket);
    }

    public void GetPlayerIdFromSteamCoroutine(
      ulong steamId,
      Action<ulong, ulong> onSuccess,
      Action<ulong> onError)
    {
      this.StartCoroutine(this.GetPlayerIdFromSteam(steamId, onSuccess, onError));
    }

    private IEnumerator GetPlayerIdFromSteam(
      ulong steamId,
      Action<ulong, ulong> onSuccess,
      Action<ulong> onError)
    {
      Log.Api(string.Format("Look for playerId with {0} (local: {1}", (object) steamId, (object) SteamUser.GetSteamID().m_SteamID));
      yield return (object) MetaServiceHelpers.HttpGetJsonWithoutBody(MetaServiceHelpers.ReplaceParametersInUrl("https://sc-live-progression.steelcircus.net/protected/steam_player/:steamId/playerId", new JObject()
      {
        [":steamId"] = (JToken) steamId
      }), (Action<string>) (error =>
      {
        Log.Error("Could not contact user service: " + error + ".");
        onError(steamId);
      }), (Action<JObject>) (resultJson =>
      {
        if (MetaServiceHelpers.HasLoginError(resultJson))
          return;
        if (resultJson["error"] != null)
        {
          Log.Error(string.Format("Username service returned error: {0}.", (object) resultJson));
          onError(steamId);
        }
        else
        {
          Log.Debug("GetPlayerIdFromSteam::" + (object) (ulong) resultJson["playerId"]);
          onSuccess(steamId, (ulong) resultJson["playerId"]);
        }
      }));
    }

    public void GetConnectTokenFromService(
      ConnectionInfo connectionInfo,
      Action<ConnectionInfo, byte[]> connectDelegate,
      Action onError)
    {
      MetaServiceHelpers.ConnectTokenRequestErrors = 0;
      SingletonManager<MetaServiceHelpers>.Instance.StartCoroutine(MetaServiceHelpers.GetConnectTokenFromServiceCR(connectionInfo, connectDelegate, onError));
    }

    private static IEnumerator GetConnectTokenFromServiceCR(
      ConnectionInfo connectionInfo,
      Action<ConnectionInfo, byte[]> connectDelegate,
      Action onError)
    {
      byte[] token = (byte[]) null;
      yield return (object) MetaServiceHelpers.HttpGetJson("https://sc-live-token.steelcircus.net/api/get_connect_token", MetaServiceHelpers.ConnectionInfoAsJson(connectionInfo), (Action<string>) (error =>
      {
        Log.Debug("Could not contact token service: " + error);
        if (MetaServiceHelpers.ConnectTokenRequestErrors < 3)
        {
          SingletonManager<MetaServiceHelpers>.Instance.StartCoroutine(MetaServiceHelpers.GetConnectTokenFromServiceCR(connectionInfo, connectDelegate, onError));
        }
        else
        {
          Log.Error("Getting token from Token Service failed 3 times.");
          onError();
          PopupManager.Instance.ShowPopup(PopupManager.Popup.OneButton, (IPopupSettings) new Popup("Failed to get a connection Token from Service 3 times. Connection to match failed!.", "OK", title: "TOKEN SERVICE ERROR"), (Action) null, (Action) null, (Action) null, (Action) null, (Selectable) null);
        }
        ++MetaServiceHelpers.ConnectTokenRequestErrors;
      }), (Action<JObject>) (resultJson =>
      {
        if (resultJson["token"] == null)
        {
          Log.Error(string.Format("TokenService did not return a Token: {0}", (object) resultJson));
          onError();
        }
        else
        {
          Log.Debug("Got connect token from token service");
          token = Convert.FromBase64String(resultJson["token"].ToString());
          connectDelegate(connectionInfo, token);
        }
      }));
    }

    public void GetPlayerLoadoutCoroutine(ulong playerId, Action<ulong, JObject> onSuccess) => this.StartCoroutine(MetaServiceHelpers.GetPlayerLoadout(playerId, onSuccess));

    public static IEnumerator GetPlayerLoadout(
      ulong playerId,
      Action<ulong, JObject> onSuccess)
    {
      yield return (object) MetaServiceHelpers.HttpGetJsonWithoutBody(MetaServiceHelpers.ReplaceParametersInUrl("https://sc-live-progression.steelcircus.net/protected/player/:playerId/items/loadouts", new JObject()
      {
        [":playerId"] = (JToken) playerId
      }), (Action<string>) (error =>
      {
        Log.Debug("Could not contact loadout service: " + error + ".");
        onSuccess(playerId, (JObject) null);
      }), (Action<JObject>) (resultJson =>
      {
        if (MetaServiceHelpers.HasLoginError(resultJson))
          return;
        if (resultJson["error"] != null)
          onSuccess(playerId, resultJson);
        else
          onSuccess(playerId, resultJson);
      }));
    }

    public void GetPlayerLoadoutsCoroutine(ulong[] playerIds, Action<JObject> onSuccess) => this.StartCoroutine(MetaServiceHelpers.GetPlayerLoadouts(playerIds, onSuccess));

    public static IEnumerator GetMainMenuNewsText(Action<JObject> onSuccess)
    {
      yield return (object) MetaServiceHelpers.HttpGetJsonWithoutBody("https://sc-live-progression.steelcircus.net/protected/news", (Action<string>) (error =>
      {
        Log.Debug("Could not contact news service: " + error + ".");
        onSuccess((JObject) null);
      }), (Action<JObject>) (resultJson =>
      {
        if (MetaServiceHelpers.HasLoginError(resultJson))
          return;
        if (resultJson["error"] != null)
        {
          Log.Debug(string.Format("Player loadout news returned error: {0}.", (object) resultJson));
          onSuccess(resultJson);
        }
        else
        {
          Log.Debug(string.Format("News service returned news: {0}", (object) resultJson));
          onSuccess(resultJson);
        }
      }));
    }

    public static IEnumerator GetTwitchUserInfo(
      ulong playerId,
      Action<ulong, JObject> onSuccess)
    {
      yield return (object) null;
      yield return (object) MetaServiceHelpers.HttpGetJsonWithoutBody(MetaServiceHelpers.ReplaceParametersInUrl("https://sc-live-progression.steelcircus.net/protected/player/:playerId/twitch/user", new JObject()
      {
        [":playerId"] = (JToken) playerId
      }), (Action<string>) (error =>
      {
        Log.Debug("Could not get TwitchUserInfo: " + error + ".");
        onSuccess(playerId, (JObject) null);
      }), (Action<JObject>) (resultJson =>
      {
        if (MetaServiceHelpers.HasLoginError(resultJson))
          return;
        if (resultJson["error"] != null)
        {
          Log.Error(string.Format("Get TwitchUserInfo returned error: {0}.", (object) resultJson));
          onSuccess(playerId, resultJson);
        }
        else
        {
          Log.Debug("Received Twitch user:" + resultJson.ToString());
          onSuccess(playerId, resultJson);
        }
      }));
    }

    public static IEnumerator SetTwitchUISettings(
      ulong playerId,
      bool showTwitchName,
      bool showTwitchViewerCount,
      Action<JObject> onSuccess)
    {
      JObject jsonParams = new JObject()
      {
        ["twitchShowUsername"] = (JToken) showTwitchName,
        ["twitchShowViewerCount"] = (JToken) showTwitchViewerCount
      };
      yield return (object) MetaServiceHelpers.HttpPostJson(MetaServiceHelpers.ReplaceParametersInUrl("https://sc-live-progression.steelcircus.net/protected/player/:playerId/twitch/settings", new JObject()
      {
        [":playerId"] = (JToken) playerId
      }), jsonParams, (Action<string>) (error => onSuccess(new JObject()
      {
        [nameof (error)] = (JToken) "Connection ERROR"
      })), (Action<JObject>) (resultJson =>
      {
        if (MetaServiceHelpers.HasLoginError(resultJson))
          return;
        if (resultJson["error"] != null)
        {
          Log.Error("ProgressionService (SetTwitchUISettings) returned error: " + (object) resultJson);
          onSuccess(resultJson);
        }
        else
        {
          Log.Debug("ProgressionService (SetTwitchUISettings) returned: " + (object) resultJson);
          onSuccess(resultJson);
        }
      }));
    }

    public static IEnumerator GetTwitchUISettings(
      ulong playerId,
      Action<JObject> onSuccess)
    {
      Log.Debug("Get Twitch UI Settings");
      yield return (object) MetaServiceHelpers.HttpGetJsonWithoutBody(MetaServiceHelpers.ReplaceParametersInUrl("https://sc-live-progression.steelcircus.net/protected/player/:playerId/twitch/settings", new JObject()
      {
        [":playerId"] = (JToken) playerId
      }), (Action<string>) (error =>
      {
        Log.Error("Progression service (GetTwitchUISettings) could not connect.");
        onSuccess(new JObject()
        {
          [nameof (error)] = (JToken) "Connection ERROR"
        });
      }), (Action<JObject>) (resultJson =>
      {
        if (MetaServiceHelpers.HasLoginError(resultJson))
          return;
        if (resultJson["error"] != null)
        {
          Log.Error("Progression service (GetTwitchUISettings) returned error:" + (object) resultJson);
          onSuccess(resultJson);
        }
        else
        {
          Log.Debug("Progression service (GetTwitchUISettings) returned:" + (object) resultJson);
          onSuccess(resultJson);
        }
      }));
    }

    public static IEnumerator GetMatchmakingSystem(Action<int> onSuccess)
    {
      yield return (object) MetaServiceHelpers.HttpGetJsonWithoutBody("https://sc-live-progression.steelcircus.net/protected/gamelift/matchmakingSystem", (Action<string>) (error =>
      {
        Log.Debug("Could not get MatchmakingSystem: " + error + ".");
        onSuccess(1);
      }), (Action<JObject>) (resultJson =>
      {
        if (MetaServiceHelpers.HasLoginError(resultJson))
          return;
        if (resultJson["error"] != null)
        {
          Log.Debug(string.Format("Get MatchmakingSystem returned error: {0}.", (object) resultJson));
          onSuccess(1);
        }
        else
        {
          int num = (int) resultJson["matchmakingSystem"];
          Log.Debug(string.Format("GetMatchmakingSystem returned MatchmakingSystem: {0}", (object) num));
          onSuccess(num);
        }
      }));
    }

    public void StartVoiceChatTokenCoroutine(
      JObject payload,
      Action<JObject> onSuccess,
      Action<JObject> onError)
    {
      this.StartCoroutine(MetaServiceHelpers.GetVoiceChatToken(payload, onSuccess, onError));
    }

    public static IEnumerator GetVoiceChatToken(
      JObject payload,
      Action<JObject> onSuccess,
      Action<JObject> onError)
    {
      yield return (object) MetaServiceHelpers.HttpPostJson("https://sc-live-progression.steelcircus.net/protected/voiceChat/generateToken", payload, (Action<string>) (error =>
      {
        Log.Debug("Could not contact token service (voiceChat): " + error + ".");
        onError((JObject) null);
      }), (Action<JObject>) (resultJson =>
      {
        if (MetaServiceHelpers.HasLoginError(resultJson))
          return;
        if (resultJson["error"] != null)
        {
          Log.Debug(string.Format("VoiceChat Generate Token returned error: {0}.", (object) resultJson));
          onError(resultJson);
        }
        else
        {
          Log.Debug(string.Format("VoiceChat Generate Token returned token: {0}", (object) resultJson));
          onSuccess(resultJson);
        }
      }));
    }

    public static IEnumerator GetTwitchConnectToken(
      ulong playerId,
      Action<JObject> onSuccess,
      Action<JObject> onError)
    {
      yield return (object) MetaServiceHelpers.HttpPostJsonWithoutBody(MetaServiceHelpers.ReplaceParametersInUrl("https://sc-live-progression.steelcircus.net/protected/player/:playerId/twitch/auth/start/", new JObject()
      {
        [":playerId"] = (JToken) playerId
      }), (Action<string>) (error =>
      {
        Log.Debug("Could not contact twitch token service: " + error + ".");
        onError((JObject) null);
      }), (Action<JObject>) (resultJson =>
      {
        if (MetaServiceHelpers.HasLoginError(resultJson))
          return;
        if (resultJson["error"] != null)
        {
          Log.Error(string.Format("Twitch Generate Token returned error: {0}.", (object) resultJson));
          onError(resultJson);
        }
        else
        {
          Log.Debug(string.Format("Twitch Generate Token returned token: {0}", (object) resultJson));
          onSuccess(resultJson);
        }
      }));
    }

    public static IEnumerator GetPlayerLoadouts(
      ulong[] playerIds,
      Action<JObject> onSuccess)
    {
      yield return (object) MetaServiceHelpers.HttpGetJsonWithoutBody(MetaServiceHelpers.AddPlayerIdsArrayParametersToUrl("https://sc-live-progression.steelcircus.net/protected/players/loadouts", playerIds), (Action<string>) (error =>
      {
        Log.Debug("Could not contact loadout service: " + error + ".");
        onSuccess((JObject) null);
      }), (Action<JObject>) (resultJson =>
      {
        if (MetaServiceHelpers.HasLoginError(resultJson))
          return;
        if (resultJson["error"] != null)
        {
          Log.Debug(string.Format("Player loadout service returned error: {0}.", (object) resultJson));
          onSuccess(resultJson);
        }
        else
          onSuccess(resultJson);
      }));
    }

    public void GetPlayersSteamIdsCoroutine(ulong[] playerIds, Action<JObject> onSuccess) => this.StartCoroutine(MetaServiceHelpers.GetPlayersSteamIds(playerIds, onSuccess));

    public static IEnumerator GetPlayersSteamIds(
      ulong[] playerIds,
      Action<JObject> onSuccess)
    {
      yield return (object) MetaServiceHelpers.HttpGetJsonWithoutBody(MetaServiceHelpers.AddPlayerIdsArrayParametersToUrl("https://sc-live-progression.steelcircus.net/protected/players/steamId", playerIds), (Action<string>) (error =>
      {
        Log.Debug("Could not contact PlayersSteamIdsService: " + error + ".");
        onSuccess((JObject) null);
      }), (Action<JObject>) (resultJson =>
      {
        if (resultJson["error"] != null)
        {
          Log.Debug(string.Format("PlayersSteamIdsService returned error: {0}.", (object) resultJson));
          onSuccess(resultJson);
        }
        else
        {
          Log.Debug(string.Format("PlayersSteamIdsService returned Ids: {0}", (object) resultJson));
          onSuccess(resultJson);
        }
      }));
    }

    public void GetPlayerLevelsCoroutine(ulong[] playerIds, Action<JObject> onSuccess) => this.StartCoroutine(MetaServiceHelpers.GetPlayerLevels(playerIds, onSuccess));

    public static IEnumerator GetPlayerLevels(
      ulong[] playerIds,
      Action<JObject> onSuccess)
    {
      yield return (object) MetaServiceHelpers.HttpGetJsonWithoutBody(MetaServiceHelpers.AddPlayerIdsArrayParametersToUrl("https://sc-live-progression.steelcircus.net/protected/players/levels", playerIds), (Action<string>) (error =>
      {
        Log.Debug("Could not contact loadout service: " + error + ".");
        onSuccess((JObject) null);
      }), (Action<JObject>) (resultJson =>
      {
        if (resultJson["error"] != null)
        {
          Log.Debug(string.Format("Player loadout service returned error: {0}.", (object) resultJson));
          onSuccess(resultJson);
        }
        else
        {
          Log.Debug(string.Format("Player Level service returned Levels: {0}", (object) resultJson));
          onSuccess(resultJson);
        }
      }));
    }

    public static IEnumerator GetShopCreditPacks(Action<JObject> onSuccess)
    {
      yield return (object) MetaServiceHelpers.HttpGetJsonWithoutBody("https://sc-live-progression.steelcircus.net/protected/shop/credit_packs", (Action<string>) (error =>
      {
        Log.Debug("Could not load shop credit packs: " + error + ".");
        onSuccess((JObject) null);
      }), (Action<JObject>) (resultJson =>
      {
        if (MetaServiceHelpers.HasLoginError(resultJson))
          return;
        if (resultJson["error"] != null)
        {
          Log.Debug(string.Format("Shop credit pack service returned error: {0}.", (object) resultJson));
          onSuccess(resultJson);
        }
        else
        {
          Log.Debug(string.Format("Shop credit pack service returned packs: {0}", (object) resultJson));
          onSuccess(resultJson);
        }
      }));
    }

    public static IEnumerator InitiateShopTransaction(
      ulong playerId,
      int itemId,
      Action<JObject> onSuccess)
    {
      JObject jobject = new JObject();
      jobject.Add((object) new JProperty("creditPackId", (object) itemId));
      JObject jsonParams = jobject;
      string url = MetaServiceHelpers.ReplaceParametersInUrl("https://sc-live-progression.steelcircus.net/protected/player/:playerId/shop/credit_packs/init_micro_transaction", new JObject()
      {
        [":playerId"] = (JToken) playerId
      });
      Log.Debug("Initializing Shop Transaction: " + (object) jsonParams);
      yield return (object) MetaServiceHelpers.HttpPostJson(url, jsonParams, (Action<string>) (error =>
      {
        Log.Debug("ShopTransaction service returned error (could not contact service): " + error + ".");
        onSuccess(new JObject()
        {
          ["msg"] = (JToken) "Connection ERROR"
        });
      }), (Action<JObject>) (resultJson =>
      {
        if (MetaServiceHelpers.HasLoginError(resultJson))
          return;
        if (resultJson["error"] != null)
        {
          Log.Debug(string.Format("ShopTransaction service returned error: {0}.", (object) resultJson));
          onSuccess(resultJson);
        }
        else
          onSuccess(resultJson);
      }));
    }

    public static IEnumerator FinalizeShopTransaction(
      ulong playerId,
      ulong orderId,
      Action<JObject> onSuccess)
    {
      JObject jobject = new JObject();
      jobject.Add((object) new JProperty(nameof (orderId), (object) orderId));
      JObject jsonParams = jobject;
      string url = MetaServiceHelpers.ReplaceParametersInUrl("https://sc-live-progression.steelcircus.net/protected/player/:playerId/shop/credit_packs/finalize_micro_transaction", new JObject()
      {
        [":playerId"] = (JToken) playerId
      });
      Log.Debug("Finalizing Shop Transaction: " + (object) jsonParams);
      yield return (object) MetaServiceHelpers.HttpPostJson(url, jsonParams, (Action<string>) (error =>
      {
        Log.Debug("ShopTransaction service returned error (could not contact service): " + error + ".");
        onSuccess(new JObject()
        {
          ["msg"] = (JToken) "Connection ERROR"
        });
      }), (Action<JObject>) (resultJson =>
      {
        if (MetaServiceHelpers.HasLoginError(resultJson))
          return;
        if (resultJson["error"] != null)
        {
          Log.Debug(string.Format("ShopTransaction service returned error: {0}.", (object) resultJson));
          onSuccess(resultJson);
        }
        else
          onSuccess(resultJson);
      }));
    }

    public void StartGetWeeklyShopRotationCoroutine(
      Action<JObject> onSuccess,
      Action<JObject> onError)
    {
      this.StartCoroutine(MetaServiceHelpers.GetWeeklyShopRotation(onSuccess, onError));
    }

    public static IEnumerator GetWeeklyShopRotation(
      Action<JObject> onSuccess,
      Action<JObject> onError)
    {
      yield return (object) MetaServiceHelpers.HttpGetJsonWithoutBody("https://sc-live-progression.steelcircus.net/protected/shop/items/weekly", (Action<string>) (error =>
      {
        Log.Debug("Could not contact progression service (itemDefinitions): " + error + ".");
        onError((JObject) null);
      }), (Action<JObject>) (resultJson =>
      {
        if (MetaServiceHelpers.HasLoginError(resultJson))
          return;
        if (resultJson["error"] != null)
        {
          Log.Debug(string.Format("Progression service (itemDefinitions) returned error: {0}.", (object) resultJson));
          onError(resultJson);
        }
        else
          onSuccess(resultJson);
      }));
    }

    public static IEnumerator GetQuestsProgress(
      ulong playerId,
      Action<JObject> onSuccess)
    {
      Log.Debug("Get Daily Quest");
      yield return (object) MetaServiceHelpers.HttpGetJsonWithoutBody(MetaServiceHelpers.ReplaceParametersInUrl("https://sc-live-progression.steelcircus.net/protected/player/:playerId/progress/quests/daily", new JObject()
      {
        [":playerId"] = (JToken) playerId
      }), (Action<string>) (error =>
      {
        Log.Error("Could not contact progression service (quests): " + error + ".");
        onSuccess(new JObject()
        {
          ["msg"] = (JToken) "Connection ERROR"
        });
      }), (Action<JObject>) (resultJson =>
      {
        if (MetaServiceHelpers.HasLoginError(resultJson))
          return;
        if (resultJson["error"] != null)
        {
          Log.Error(string.Format("Progression service (quests) returned error: {0}.", (object) resultJson));
          onSuccess(resultJson);
        }
        else
          onSuccess(resultJson);
      }));
    }

    public static IEnumerator GetTutorialProgress(
      ulong playerId,
      Action<JObject> onSuccess)
    {
      Log.Debug("Get Tutorial Progress");
      yield return (object) MetaServiceHelpers.HttpGetJsonWithoutBody(MetaServiceHelpers.ReplaceParametersInUrl("https://sc-live-progression.steelcircus.net/protected/player/:playerId/progress/quests/once", new JObject()
      {
        [":playerId"] = (JToken) playerId
      }), (Action<string>) (error =>
      {
        Log.Error("Could not contact progression service (quests): " + error + ".");
        onSuccess(new JObject()
        {
          ["msg"] = (JToken) "Connection ERROR"
        });
      }), (Action<JObject>) (resultJson =>
      {
        if (MetaServiceHelpers.HasLoginError(resultJson))
          return;
        if (resultJson["error"] != null)
        {
          Log.Error(string.Format("Progression service (tutorials) returned error: {0}.", (object) resultJson));
          onSuccess(resultJson);
        }
        else
          onSuccess(resultJson);
      }));
    }

    public static IEnumerator GetMilestonesProgress(
      ulong playerId,
      Action<JObject> onSuccess)
    {
      yield return (object) MetaServiceHelpers.HttpGetJsonWithoutBody(MetaServiceHelpers.ReplaceParametersInUrl("https://sc-live-progression.steelcircus.net/protected/player/:playerId/progress/levelmilestone", new JObject()
      {
        [":playerId"] = (JToken) playerId
      }), (Action<string>) (error =>
      {
        Log.Error("Could not contact progression service (milestones): " + error + ".");
        onSuccess(new JObject()
        {
          ["msg"] = (JToken) "Connection ERROR"
        });
      }), (Action<JObject>) (resultJson =>
      {
        if (MetaServiceHelpers.HasLoginError(resultJson))
          return;
        if (resultJson["error"] != null)
        {
          Log.Error(string.Format("Progression service (milestones) returned error: {0}.", (object) resultJson));
          onSuccess(resultJson);
        }
        else
          onSuccess(resultJson);
      }));
    }

    public static IEnumerator CollectQuestReward(
      ulong playerId,
      int rewardId,
      DailyChallengeEntry.ChallengeRewardType rewardType,
      int rewardAmount,
      Action<JObject, DailyChallengeEntry.ChallengeRewardType, int> onSuccess)
    {
      JObject jsonParams = new JObject()
      {
        [":playerId"] = (JToken) playerId,
        [":rewardId"] = (JToken) rewardId
      };
      yield return (object) MetaServiceHelpers.HttpPostJson(MetaServiceHelpers.ReplaceParametersInUrl("https://sc-live-progression.steelcircus.net/protected/player/:playerId/progress/reward/:rewardId/collect", new JObject()
      {
        [":playerId"] = (JToken) playerId,
        [":rewardId"] = (JToken) rewardId
      }), jsonParams, (Action<string>) (error =>
      {
        Log.Error("Could not contact progression service (quests): " + error + ".");
        Action<JObject, DailyChallengeEntry.ChallengeRewardType, int> action = onSuccess;
        JObject jobject = new JObject();
        jobject["msg"] = (JToken) "Connection ERROR";
        int num1 = (int) rewardType;
        int num2 = rewardAmount;
        action(jobject, (DailyChallengeEntry.ChallengeRewardType) num1, num2);
      }), (Action<JObject>) (resultJson =>
      {
        if (MetaServiceHelpers.HasLoginError(resultJson))
          return;
        if (resultJson["error"] != null)
        {
          Log.Error(string.Format("Progression service (quests) returned error: {0}.", (object) resultJson));
          onSuccess(resultJson, rewardType, rewardAmount);
        }
        else
          onSuccess(resultJson, rewardType, rewardAmount);
      }));
    }

    public static IEnumerator GetAllItemDefinitions(
      Action<JObject, Action<string>> onSuccess,
      Action<string> onError)
    {
      yield return (object) MetaServiceHelpers.HttpGetJsonWithoutBody("https://sc-live-progression.steelcircus.net/protected/items", (Action<string>) (error =>
      {
        Log.Debug("Could not contact progression service (itemDefinitions): " + error + ".");
        onError("Connection ERROR. Can't get item definitions.");
      }), (Action<JObject>) (resultJson =>
      {
        if (MetaServiceHelpers.HasLoginError(resultJson))
          return;
        if (resultJson["error"] != null)
        {
          Log.Debug(string.Format("Progression service (itemDefinitions) returned error: {0}.", (object) resultJson));
          onError(resultJson.ToString());
        }
        else
          onSuccess(resultJson, onError);
      }));
    }

    public void StartGetAllItemsForPlayerCoroutine(ulong playerId, Action<JObject> onSuccess) => this.StartCoroutine(MetaServiceHelpers.GetAllItemsForPlayer(playerId, onSuccess));

    public static IEnumerator GetAllItemsForPlayer(
      ulong playerId,
      Action<JObject> onSuccess)
    {
      yield return (object) MetaServiceHelpers.HttpGetJsonWithoutBody(MetaServiceHelpers.ReplaceParametersInUrl("https://sc-live-progression.steelcircus.net/protected/player/:playerId/items", new JObject()
      {
        [":playerId"] = (JToken) playerId
      }), (Action<string>) (error =>
      {
        Log.Debug("Could not contact progression service (items): " + error + ".");
        onSuccess(new JObject()
        {
          ["msg"] = (JToken) "Connection ERROR"
        });
      }), (Action<JObject>) (resultJson =>
      {
        if (MetaServiceHelpers.HasLoginError(resultJson))
          return;
        if (resultJson["error"] != null)
        {
          Log.Debug(string.Format("Progression service (items) returned error: {0}.", (object) resultJson));
          onSuccess(resultJson);
        }
        else
          onSuccess(resultJson);
      }));
    }

    public void StartGetItemSubsetCoroutine(
      ulong playerId,
      ShopManager.ShopItemType itemType,
      Action<JObject, ShopManager.ShopItemType> onSuccess,
      Action<JObject, ShopManager.ShopItemType> onError)
    {
      this.StartCoroutine(MetaServiceHelpers.GetItemSubset(playerId, itemType, onSuccess, onError));
    }

    public static IEnumerator GetItemSubset(
      ulong playerId,
      ShopManager.ShopItemType itemType,
      Action<JObject, ShopManager.ShopItemType> onSuccess,
      Action<JObject, ShopManager.ShopItemType> onError)
    {
      if (MetaServiceHelpers.progressionServiceItemTypeStrings.ContainsKey(itemType))
        yield return (object) MetaServiceHelpers.HttpGetJsonWithoutBody(MetaServiceHelpers.ReplaceParametersInUrl("https://sc-live-progression.steelcircus.net/protected/player/:playerId/items/type/:type", new JObject()
        {
          [":playerId"] = (JToken) playerId,
          [":type"] = (JToken) MetaServiceHelpers.progressionServiceItemTypeStrings[itemType]
        }), (Action<string>) (error =>
        {
          Log.Debug("Could not contact progression service (items - " + MetaServiceHelpers.progressionServiceItemTypeStrings[itemType] + "): {error}.");
          Action<JObject, ShopManager.ShopItemType> action = onSuccess;
          JObject jobject = new JObject();
          jobject["msg"] = (JToken) "Connection ERROR";
          int num = (int) itemType;
          action(jobject, (ShopManager.ShopItemType) num);
        }), (Action<JObject>) (resultJson =>
        {
          if (MetaServiceHelpers.HasLoginError(resultJson))
            return;
          if (resultJson["error"] != null)
          {
            Log.Debug("Progression service (items - " + MetaServiceHelpers.progressionServiceItemTypeStrings[itemType] + ") returned error: {resultJson}.");
            onSuccess(resultJson, itemType);
          }
          else
            onSuccess(resultJson, itemType);
        }));
      else
        Log.Error("No network message to get items of type " + (object) itemType);
    }

    public void StartGetShopPageCoroutine(
      ulong playerId,
      ShopManager.ShopItemType itemType,
      Action<JObject, ShopManager.ShopItemType> onSuccess,
      Action<JObject, ShopManager.ShopItemType> onError)
    {
      this.StartCoroutine(MetaServiceHelpers.GetShopPage(playerId, itemType, onSuccess, onError));
    }

    public static IEnumerator GetShopPage(
      ulong playerId,
      ShopManager.ShopItemType itemType,
      Action<JObject, ShopManager.ShopItemType> onSuccess,
      Action<JObject, ShopManager.ShopItemType> onError)
    {
      if (MetaServiceHelpers.progressionServiceItemTypeStrings.ContainsKey(itemType))
        yield return (object) MetaServiceHelpers.HttpGetJsonWithoutBody(MetaServiceHelpers.ReplaceParametersInUrl("https://sc-live-progression.steelcircus.net/protected/shop/items/type/:type", new JObject()
        {
          [":type"] = (JToken) MetaServiceHelpers.progressionServiceItemTypeStrings[itemType]
        }), (Action<string>) (error =>
        {
          Log.Debug("Could not contact progression service (shop page - " + MetaServiceHelpers.progressionServiceItemTypeStrings[itemType] + "): {error}.");
          Action<JObject, ShopManager.ShopItemType> action = onError;
          JObject jobject = new JObject();
          jobject["msg"] = (JToken) "Connection ERROR";
          int num = (int) itemType;
          action(jobject, (ShopManager.ShopItemType) num);
        }), (Action<JObject>) (resultJson =>
        {
          if (MetaServiceHelpers.HasLoginError(resultJson))
            return;
          if (resultJson["error"] != null)
          {
            Log.Debug("Progression service (shop page - " + MetaServiceHelpers.progressionServiceItemTypeStrings[itemType] + ") returned error: {resultJson}.");
            onError(resultJson, itemType);
          }
          else
            onSuccess(resultJson, itemType);
        }));
      else
        Log.Error("No network message to get items of type " + (object) itemType);
    }

    public void StartUnlockItemCoroutine(
      ulong playerId,
      int itemId,
      Action<JObject, int> onSuccess)
    {
      this.StartCoroutine(MetaServiceHelpers.UnlockItem(playerId, itemId, onSuccess));
    }

    public static IEnumerator UnlockItem(
      ulong playerId,
      int itemId,
      Action<JObject, int> onSuccess)
    {
      JObject jsonParams = new JObject()
      {
        [":playerId"] = (JToken) playerId,
        [":itemId"] = (JToken) itemId
      };
      yield return (object) MetaServiceHelpers.HttpPostJson(MetaServiceHelpers.ReplaceParametersInUrl("https://sc-live-progression.steelcircus.net/protected/player/:playerId/shop/items/:itemId/buy", new JObject()
      {
        [":playerId"] = (JToken) playerId,
        [":itemId"] = (JToken) itemId
      }), jsonParams, (Action<string>) (error =>
      {
        Log.Debug("Could not contact progression service (unlock items): " + error + ".");
        Action<JObject, int> action = onSuccess;
        JObject jobject = new JObject();
        jobject["msg"] = (JToken) "Connection ERROR";
        int num = itemId;
        action(jobject, num);
      }), (Action<JObject>) (resultJson =>
      {
        if (MetaServiceHelpers.HasLoginError(resultJson))
          return;
        if (resultJson["error"] != null)
        {
          Log.Debug(string.Format("Progression service (unlock items) returned error: {0}.", (object) resultJson));
          onSuccess(resultJson, itemId);
        }
        else
          onSuccess(resultJson, itemId);
      }));
    }

    public void StartUnlockItemWithSteelCoroutine(
      ulong playerId,
      int itemId,
      Action<JObject, int> onSuccess)
    {
      this.StartCoroutine(MetaServiceHelpers.UnlockItemWithSteel(playerId, itemId, onSuccess));
    }

    public static IEnumerator UnlockItemWithSteel(
      ulong playerId,
      int itemId,
      Action<JObject, int> onSuccess)
    {
      JObject jsonParams = new JObject()
      {
        [nameof (playerId)] = (JToken) playerId,
        ["id"] = (JToken) itemId
      };
      yield return (object) MetaServiceHelpers.HttpPostJson(MetaServiceHelpers.ReplaceParametersInUrl("https://sc-live-progression.steelcircus.net/protected/player/:playerId/shop/items/weekly/:itemId/buy", new JObject()
      {
        [":playerId"] = (JToken) playerId,
        [":itemId"] = (JToken) itemId
      }), jsonParams, (Action<string>) (error =>
      {
        Log.Debug("Could not contact progression service (unlock item with Steel): " + error + ".");
        Action<JObject, int> action = onSuccess;
        JObject jobject = new JObject();
        jobject["msg"] = (JToken) "Connection ERROR";
        int num = itemId;
        action(jobject, num);
      }), (Action<JObject>) (resultJson =>
      {
        if (MetaServiceHelpers.HasLoginError(resultJson))
          return;
        if (resultJson["error"] != null)
        {
          Log.Debug(string.Format("Progression service (unlock item with Steel) returned error: {0}.", (object) resultJson));
          onSuccess(resultJson, itemId);
        }
        else
          onSuccess(resultJson, itemId);
      }));
    }

    public static IEnumerator CheckDlcStatus(Action<JObject> onSuccess)
    {
      yield return (object) MetaServiceHelpers.HttpPostJson("https://sc-live-progression.steelcircus.net/protected/shop/dlcs/update", new JObject(), (Action<string>) (error => Log.Debug("Could not contact progression service (CheckChampionDlcStatus): " + error + ".")), (Action<JObject>) (resultJson =>
      {
        if (MetaServiceHelpers.HasLoginError(resultJson))
          return;
        if (resultJson["error"] != null)
          Log.Debug(string.Format("Progression service (CheckChampionDlcStatus) returned error: {0}.", (object) resultJson));
        else
          onSuccess(resultJson);
      }));
    }

    public static IEnumerator GetShopDlc(Action<JObject> onSuccess)
    {
      yield return (object) MetaServiceHelpers.HttpGetJson("https://sc-live-progression.steelcircus.net/protected/shop/dlcs", new JObject(), (Action<string>) (error => Log.Debug("Could not contact progression service (GetShopDlc): " + error + ".")), (Action<JObject>) (resultJson =>
      {
        if (MetaServiceHelpers.HasLoginError(resultJson))
          return;
        if (resultJson["error"] != null)
          Log.Debug(string.Format("Progression service (GetShopDlc) returned error: {0}.", (object) resultJson));
        else
          onSuccess(resultJson);
      }));
    }

    public static IEnumerator GetDlcItemList(
      int bundleId,
      Action<int, JObject> onSuccess)
    {
      yield return (object) MetaServiceHelpers.HttpGetJson(MetaServiceHelpers.ReplaceParametersInUrl("https://sc-live-progression.steelcircus.net/protected/shop/dlcs/:dlcId/items", new JObject()
      {
        [":dlcId"] = (JToken) bundleId
      }), new JObject(), (Action<string>) (error => Log.Debug("Could not contact progression service (GetShopDlc): " + error + ".")), (Action<JObject>) (resultJson =>
      {
        if (MetaServiceHelpers.HasLoginError(resultJson))
          return;
        if (resultJson["error"] != null)
          Log.Debug(string.Format("Progression service (GetShopDlc) returned error: {0}.", (object) resultJson));
        else
          onSuccess(bundleId, resultJson);
      }));
    }

    public void StartEquipItemCoroutine(
      ulong playerId,
      int itemId,
      ChampionType champion,
      int slot,
      Action<JObject, int> onSuccess)
    {
      this.StartCoroutine(MetaServiceHelpers.EquipItem(playerId, itemId, champion, slot, onSuccess));
    }

    public static IEnumerator EquipItem(
      ulong playerId,
      int itemId,
      ChampionType champion,
      int slot,
      Action<JObject, int> onSuccess)
    {
      JObject jsonParams = new JObject()
      {
        ["id"] = (JToken) itemId,
        [nameof (champion)] = (JToken) (int) champion,
        [nameof (slot)] = (JToken) slot
      };
      yield return (object) MetaServiceHelpers.HttpPostJson(MetaServiceHelpers.ReplaceParametersInUrl("https://sc-live-progression.steelcircus.net/protected/player/:playerId/items/equip", new JObject()
      {
        [":playerId"] = (JToken) playerId
      }), jsonParams, (Action<string>) (error =>
      {
        Log.Debug("Could not contact progression service (items): " + error + ".");
        Action<JObject, int> action = onSuccess;
        JObject jobject = new JObject();
        jobject["msg"] = (JToken) "Connection ERROR";
        int num = itemId;
        action(jobject, num);
      }), (Action<JObject>) (resultJson =>
      {
        if (MetaServiceHelpers.HasLoginError(resultJson))
          return;
        if (resultJson["error"] != null)
        {
          Log.Debug(string.Format("Progression service (items) returned error: {0}.", (object) resultJson));
          onSuccess(resultJson, itemId);
        }
        else
          onSuccess(resultJson, itemId);
      }));
    }

    public void StartEquipAvatarCoroutine(
      ulong playerId,
      int itemId,
      Action<JObject, int> onSuccess)
    {
      this.StartCoroutine(MetaServiceHelpers.EquipAvatar(playerId, itemId, onSuccess));
    }

    public static IEnumerator EquipAvatar(
      ulong playerId,
      int itemId,
      Action<JObject, int> onSuccess)
    {
      JObject jsonParams = new JObject()
      {
        ["id"] = (JToken) itemId,
        ["champion"] = (JToken) -1,
        ["slot"] = (JToken) -1
      };
      yield return (object) MetaServiceHelpers.HttpPostJson(MetaServiceHelpers.ReplaceParametersInUrl("https://sc-live-progression.steelcircus.net/protected/player/:playerId/items/equip", new JObject()
      {
        [":playerId"] = (JToken) playerId
      }), jsonParams, (Action<string>) (error =>
      {
        Log.Debug("Could not contact progression service (equip avatar): " + error + ".");
        Action<JObject, int> action = onSuccess;
        JObject jobject = new JObject();
        jobject["msg"] = (JToken) "Connection ERROR";
        int num = itemId;
        action(jobject, num);
      }), (Action<JObject>) (resultJson =>
      {
        if (MetaServiceHelpers.HasLoginError(resultJson))
          return;
        if (resultJson["error"] != null)
        {
          Log.Debug(string.Format("Progression service (equip avatar) returned error: {0}.", (object) resultJson));
          onSuccess(resultJson, itemId);
        }
        else
          onSuccess(resultJson, itemId);
      }));
    }

    public void GetPlayerProgressCoroutine(ulong playerId, Action<ulong, JObject> onSuccess) => this.StartCoroutine(MetaServiceHelpers.GetPlayerProgress(playerId, onSuccess));

    public static IEnumerator GetPlayerProgress(
      ulong playerId,
      Action<ulong, JObject> onSuccess)
    {
      yield return (object) MetaServiceHelpers.HttpGetJsonWithoutBody(MetaServiceHelpers.ReplaceParametersInUrl("https://sc-live-progression.steelcircus.net/protected/player/:playerId/progress", new JObject()
      {
        [":playerId"] = (JToken) playerId
      }), (Action<string>) (error =>
      {
        Log.Debug("Could not contact progression service (profile): " + error + ".");
        onSuccess(playerId, new JObject()
        {
          ["msg"] = (JToken) "Connection ERROR"
        });
      }), (Action<JObject>) (resultJson =>
      {
        if (MetaServiceHelpers.HasLoginError(resultJson))
          return;
        if (resultJson["error"] != null)
        {
          Log.Debug(string.Format("Progression service (profile) returned error: {0}.", (object) resultJson));
          onSuccess(playerId, resultJson);
        }
        else
          onSuccess(playerId, resultJson);
      }));
    }

    public static IEnumerator GetPlayerStatisctics(
      ulong playerId,
      Action<ulong, JObject> onSuccess)
    {
      yield return (object) MetaServiceHelpers.HttpGetJsonWithoutBody(MetaServiceHelpers.ReplaceParametersInUrl("https://sc-live-progression.steelcircus.net/protected/player/:playerId/progress/stats", new JObject()
      {
        [":playerId"] = (JToken) playerId
      }), (Action<string>) (error =>
      {
        Log.Debug("Could not contact progression service (profile): " + error + ".");
        onSuccess(playerId, new JObject()
        {
          ["msg"] = (JToken) "Connection ERROR"
        });
      }), (Action<JObject>) (resultJson =>
      {
        if (MetaServiceHelpers.HasLoginError(resultJson))
          return;
        if (resultJson["error"] != null)
        {
          Log.Debug(string.Format("Progression service (profile) returned error: {0}.", (object) resultJson));
          onSuccess(playerId, resultJson);
        }
        else
          onSuccess(playerId, resultJson);
      }));
    }

    public static IEnumerator GetPlayerPenalty(ulong playerId, Action<int> onSuccess)
    {
      yield return (object) MetaServiceHelpers.HttpGetJsonWithoutBody(MetaServiceHelpers.ReplaceParametersInUrl("https://sc-live-progression.steelcircus.net/protected/player/:playerId/progress/penalty", new JObject()
      {
        [":playerId"] = (JToken) playerId
      }), (Action<string>) (error =>
      {
        Log.Debug("Could not contact progression service (PlayerPenalty): " + error + ".");
        onSuccess(0);
      }), (Action<JObject>) (resultJson =>
      {
        if (MetaServiceHelpers.HasLoginError(resultJson))
          return;
        if (resultJson["error"] != null)
        {
          Log.Debug(string.Format("Progression service (PlayerPenalty) returned error: {0}.", (object) resultJson));
          onSuccess(0);
        }
        else
          onSuccess((int) resultJson["playerPenaltyCount"]);
      }));
    }

    public static IEnumerator GetMatchStatistics(
      ulong playerId,
      string matchId,
      Action<JObject> onSuccess)
    {
      yield return (object) MetaServiceHelpers.HttpGetJsonWithoutBody(MetaServiceHelpers.ReplaceParametersInUrl("https://sc-live-progression.steelcircus.net/public/player/:playerId/progress/match/:matchId", new JObject()
      {
        [":playerId"] = (JToken) playerId,
        [":matchId"] = (JToken) matchId
      }), (Action<string>) (error =>
      {
        Log.Debug("Could not contact progression service: " + error + ".");
        onSuccess(new JObject()
        {
          ["msg"] = (JToken) "Connection ERROR"
        });
      }), (Action<JObject>) (resultJson =>
      {
        if (MetaServiceHelpers.HasLoginError(resultJson))
          return;
        if (resultJson["error"] != null)
        {
          Log.Debug(string.Format("Progression service returned error: {0}.", (object) resultJson));
          onSuccess(resultJson);
        }
        else
          onSuccess(resultJson);
      }));
    }

    private static JObject ConnectionInfoAsJson(ConnectionInfo ci) => new JObject()
    {
      ["playerId"] = (JToken) ci.playerId,
      ["serverIp"] = (JToken) ci.ip.ToString(),
      ["serverPort"] = (JToken) ci.port
    };

    public static bool HasLoginError(JObject jObj)
    {
      if (jObj["LOGIN_ERROR"] == null)
        return false;
      ImiServices.Instance.LoginSessionExpiredPopup();
      return true;
    }

    private static string ReplaceParametersInUrl(string url, JObject parameters)
    {
      string str = url;
      foreach (KeyValuePair<string, JToken> parameter in parameters)
        str = str.Replace(parameter.Key, parameter.Value.ToString());
      return str;
    }

    private static string AddPlayerIdsArrayParametersToUrl(string url, ulong[] playerIds)
    {
      string str = string.Join<ulong>(",", (IEnumerable<ulong>) playerIds);
      return url + "?playerIds=[" + str + "]";
    }

    public static IEnumerator HttpGetJsonWithAuth(
      string url,
      JObject jsonParams,
      Action<string> onError,
      Action<JObject> onSuccess)
    {
      return MetaServiceHelpers.HttpGetJson(url, jsonParams, onError, onSuccess);
    }

    public static IEnumerator HttpGetJsonWithAuth(
      string url,
      Action<string> onError,
      Action<JObject> onSuccess)
    {
      return MetaServiceHelpers.HttpGetJson(url, onError, onSuccess);
    }

    public static IEnumerator HttpGetJsonWithAuthCleanUrl(
      string url,
      JObject jsonParams,
      Action<string> onError,
      Action<JObject> onSuccess,
      string additionalQueryString = "")
    {
      string parameters = "";
      if (jsonParams.Count > 1)
      {
        foreach (KeyValuePair<string, JToken> jsonParam in jsonParams)
          parameters = parameters + jsonParam.Key + "/" + (object) jsonParam.Value;
      }
      else
      {
        foreach (KeyValuePair<string, JToken> jsonParam in jsonParams)
          parameters = jsonParam.Value.ToString();
      }
      string additionalQueryString1 = additionalQueryString ?? "";
      return MetaServiceHelpers.HttpGetJsonCleanUrl(url, parameters, onError, onSuccess, additionalQueryString1);
    }

    public static IEnumerator HttpPostJsonWithoutBody(
      string url,
      Action<string> onError,
      Action<JObject> onSuccess)
    {
      using (UnityWebRequest www = new UnityWebRequest(url, "POST"))
      {
        www.uploadHandler = (UploadHandler) null;
        www.downloadHandler = (DownloadHandler) new DownloadHandlerBuffer();
        www.SetRequestHeader("Content-Type", "application/json");
        MetaServiceHelpers.SetCookieHeader(www);
        Log.Netcode(url);
        yield return (object) www.SendWebRequest();
        if (!string.IsNullOrEmpty(www.error))
        {
          onError(www.error);
        }
        else
        {
          string text = www.downloadHandler.text;
          MetaServiceHelpers.LogAndCacheCookieInfo(www);
          Log.Debug("RECEIVED JSON:" + text);
          try
          {
            onSuccess(JObject.Parse(text));
          }
          catch (Exception ex)
          {
            Log.Error(ex.ToString());
            onError("HTTP Response Error.");
          }
        }
      }
    }

    public static IEnumerator HttpGetJsonWithoutBody(
      string url,
      Action<string> onError,
      Action<JObject> onSuccess,
      string additionalQueryString = "")
    {
      Log.Netcode(url + (additionalQueryString != "" ? "?" + additionalQueryString : ""));
      using (UnityWebRequest www = UnityWebRequest.Get(url))
      {
        MetaServiceHelpers.SetCookieHeader(www);
        yield return (object) www.SendWebRequest();
        if (!string.IsNullOrEmpty(www.error))
        {
          onError(www.error);
        }
        else
        {
          string text = www.downloadHandler.text;
          MetaServiceHelpers.LogAndCacheCookieInfo(www);
          Log.Debug("RECEIVED JSON:" + text);
          onSuccess(JObject.Parse(text));
        }
      }
    }

    public static IEnumerator HttpPostJsonWithAuth(
      string url,
      JObject jsonParams,
      Action<string> onError,
      Action<JObject> onSuccess)
    {
      JObject jsonParams1 = new JObject(jsonParams);
      return MetaServiceHelpers.HttpPostJson(url, jsonParams1, onError, onSuccess);
    }

    public static IEnumerator HttpGetJson(
      string url,
      JObject jsonParams,
      Action<string> onError,
      Action<JObject> onSuccess,
      string additionalQueryString = "")
    {
      string str = string.Format("{0}?p={1}{2}", (object) url, (object) jsonParams, additionalQueryString != "" ? (object) ("&" + additionalQueryString) : (object) "");
      Log.Netcode(str);
      using (UnityWebRequest www = UnityWebRequest.Get(str))
      {
        MetaServiceHelpers.SetCookieHeader(www);
        yield return (object) www.SendWebRequest();
        if (!string.IsNullOrEmpty(www.error))
        {
          onError(www.error);
        }
        else
        {
          string text = www.downloadHandler.text;
          MetaServiceHelpers.LogAndCacheCookieInfo(www);
          Log.Debug("RECEIVED JSON:" + text);
          onSuccess(JObject.Parse(text));
        }
      }
    }

    public static IEnumerator HttpGetJsonCleanUrl(
      string url,
      string parameters,
      Action<string> onError,
      Action<JObject> onSuccess,
      string additionalQueryString = "")
    {
      string str = url + "/" + parameters + (additionalQueryString != "" ? additionalQueryString ?? "" : "");
      Log.Netcode(str);
      using (UnityWebRequest www = UnityWebRequest.Get(str))
      {
        MetaServiceHelpers.SetCookieHeader(www);
        yield return (object) www.SendWebRequest();
        if (!string.IsNullOrEmpty(www.error))
        {
          onError(www.error);
        }
        else
        {
          string text = www.downloadHandler.text;
          MetaServiceHelpers.LogAndCacheCookieInfo(www);
          Log.Debug("RECEIVED JSON:" + text);
          onSuccess(JObject.Parse(text));
        }
      }
    }

    public static IEnumerator HttpGetJson(
      string url,
      Action<string> onError,
      Action<JObject> onSuccess,
      string additionalQueryString = "")
    {
      string str = url + (additionalQueryString != "" ? "?" + additionalQueryString : "");
      Log.Netcode(str);
      using (UnityWebRequest www = UnityWebRequest.Get(str))
      {
        MetaServiceHelpers.SetCookieHeader(www);
        yield return (object) www.SendWebRequest();
        if (!string.IsNullOrEmpty(www.error))
        {
          onError(www.error);
        }
        else
        {
          string text = www.downloadHandler.text;
          MetaServiceHelpers.LogAndCacheCookieInfo(www);
          Log.Debug("RECEIVED JSON:" + text);
          onSuccess(JObject.Parse(text));
        }
      }
    }

    public static IEnumerator HttpPostJson(
      string url,
      JObject jsonParams,
      Action<string> onError,
      Action<JObject> onSuccess)
    {
      using (UnityWebRequest www = new UnityWebRequest(url, "POST"))
      {
        www.uploadHandler = (UploadHandler) new UploadHandlerRaw(Encoding.UTF8.GetBytes(jsonParams.ToString()));
        www.downloadHandler = (DownloadHandler) new DownloadHandlerBuffer();
        www.SetRequestHeader("Content-Type", "application/json");
        MetaServiceHelpers.SetCookieHeader(www);
        Log.Netcode(url + jsonParams.ToString());
        yield return (object) www.SendWebRequest();
        if (!string.IsNullOrEmpty(www.error))
        {
          onError(www.error);
        }
        else
        {
          string text = www.downloadHandler.text;
          MetaServiceHelpers.LogAndCacheCookieInfo(www);
          Log.Debug("RECEIVED JSON:" + text);
          try
          {
            onSuccess(JObject.Parse(text));
          }
          catch (Exception ex)
          {
            Log.Error(ex.ToString());
            onError("HTTP Response Error.");
          }
        }
      }
    }

    private static void SetCookieHeader(UnityWebRequest www)
    {
      if (string.IsNullOrEmpty(MetaServiceHelpers.userCookie))
        return;
      www.SetRequestHeader("Cookie", MetaServiceHelpers.userCookie);
      if (MetaServiceHelpers.userCookie.Length < 27)
        return;
      MetaServiceHelpers.userCookie.Substring(12, 15);
    }

    private static void LogAndCacheCookieInfo(UnityWebRequest www)
    {
      if (string.IsNullOrEmpty(www.GetResponseHeader("Set-Cookie")))
        return;
      MetaServiceHelpers.userCookie = www.GetResponseHeader("Set-Cookie");
    }

    private static IEnumerator GetJsonResponse(
      UnityWebRequest webRequest,
      Action<string> onError,
      Action<JObject> onSuccess)
    {
      yield return (object) webRequest.SendWebRequest();
      if (!string.IsNullOrEmpty(webRequest.error))
      {
        onError(webRequest.error);
      }
      else
      {
        Log.Debug("GetJsonResponse Success! Parsing json.");
        onSuccess(JObject.Parse(webRequest.downloadHandler.text));
      }
    }
  }
}
