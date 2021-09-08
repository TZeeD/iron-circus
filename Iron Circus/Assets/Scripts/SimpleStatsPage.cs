// Decompiled with JetBrains decompiler
// Type: SimpleStatsPage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SteelCircus.UI.Network;
using Newtonsoft.Json.Linq;
using Steamworks;
using SteelCircus.Core.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class SimpleStatsPage : MonoBehaviour
{
  [Header("Stats Objects")]
  public RecentMatchObject[] recentMatchesEntries;
  public StatsPageEntry matchCount;
  public StatsPageEntry drawCount;
  public StatsPageEntry winRatio;
  public StatsPageEntry mvpCount;
  public StatsPageEntry[] FrequentRewardObjects;
  [Header("XP Objects")]
  public Image xpBarFill;
  public TextMeshProUGUI levelTextObject;
  public TextMeshProUGUI playerNameObject;
  [Header("ParentObjects")]
  public GameObject loadingObject;
  public CanvasGroup statPageParent;

  private void Start()
  {
    this.SetStatsLoading();
    this.StartCoroutine(MetaServiceHelpers.GetPlayerStatisctics(ImiServices.Instance.LoginService.GetPlayerId(), new Action<ulong, JObject>(this.OnGetPlayerStats)));
  }

  private void SetStatsLoading()
  {
    this.loadingObject.SetActive(true);
    this.statPageParent.alpha = 0.0f;
  }

  private void SetStatsDoneLoading()
  {
    this.loadingObject.SetActive(false);
    this.statPageParent.alpha = 1f;
  }

  private void ParsePlayerProgress(JToken progressToken)
  {
    int num1 = this.TryParseInt(progressToken[(object) "currentLevel"]);
    int num2 = this.TryParseInt(progressToken[(object) "experienceThisLvl"]);
    int num3 = this.TryParseInt(progressToken[(object) "xpNeeded"][(object) "xpNeeded"]);
    this.levelTextObject.text = ImiServices.Instance.LocaService.GetLocalizedValue("@lvl") + " " + (object) num1;
    this.xpBarFill.fillAmount = (float) num2 / (float) num3;
  }

  private void OnGetPlayerStats(ulong playerId, JObject stats)
  {
    if (stats["error"] != null || stats["msg"] != null || stats["playerProgress"] == null || stats["playerRewards"] == null || stats["matches"] == null)
    {
      Log.Error("Error loading player statistics: " + (object) stats);
    }
    else
    {
      this.SetStatsDoneLoading();
      this.ParsePlayerProgress(stats["playerProgress"]);
      this.playerNameObject.text = SteamFriends.GetPersonaName();
      if (stats["matches"] != null)
      {
        JArray stat = (JArray) stats["matches"];
        for (int index = 0; index < this.recentMatchesEntries.Length; ++index)
        {
          if (stat.Count > index && stat[index] != null)
          {
            JToken jtoken = stat[index];
            this.recentMatchesEntries[index].SetRecentMatchValues((int) jtoken[(object) "outcome"], jtoken[(object) "awardId"].ToString(), (bool) jtoken[(object) "mvpStatus"]);
            this.recentMatchesEntries[index].gameObject.SetActive(true);
          }
          else
            this.recentMatchesEntries[index].gameObject.SetActive(false);
        }
      }
      if (stats["matchesPlayedInfo"] != null)
      {
        int num1 = 0;
        int num2 = 0;
        int num3 = 0;
        foreach (JToken jtoken in (IEnumerable<JToken>) stats["matchesPlayedInfo"])
        {
          switch ((int) jtoken[(object) "outcome"])
          {
            case 0:
              num1 = (int) jtoken[(object) "count"];
              continue;
            case 1:
              num2 = (int) jtoken[(object) "count"];
              continue;
            default:
              num3 = (int) jtoken[(object) "count"];
              continue;
          }
        }
        int num4 = num1 + num2 + num3;
        int num5 = 0;
        if (num4 > 0)
          num5 = (int) ((double) num1 / (double) num4 * 100.0);
        this.matchCount.SetStatValues(ImiServices.Instance.LocaService.GetLocalizedValue("@MatchesPlayed"), num4.ToString());
        this.winRatio.SetStatValues(ImiServices.Instance.LocaService.GetLocalizedValue("@WinRatio"), num5.ToString() + "%");
        this.drawCount.SetStatValues(ImiServices.Instance.LocaService.GetLocalizedValue("@DrawCount"), num3.ToString());
      }
      else
      {
        this.matchCount.gameObject.SetActive(false);
        this.winRatio.gameObject.SetActive(false);
      }
      Dictionary<string, int> source = new Dictionary<string, int>();
      if (stats["playerRewards"] != null)
      {
        foreach (JToken jtoken in (IEnumerable<JToken>) stats["playerRewards"])
          source.Add(jtoken[(object) "awardId"].ToString(), (int) jtoken[(object) "awardCount"]);
      }
      int num6 = 0;
      if (source.ContainsKey("MVP"))
        num6 = source["MVP"];
      this.mvpCount.SetStatValues(ImiServices.Instance.LocaService.GetLocalizedValue("@MVPCount"), num6.ToString());
      if (source.ContainsKey("MVP"))
        source.Remove("MVP");
      KeyValuePair<string, int>[] array = source.OrderByDescending<KeyValuePair<string, int>, int>((Func<KeyValuePair<string, int>, int>) (entry => entry.Value)).ToArray<KeyValuePair<string, int>>();
      string[] strArray = new string[4]
      {
        "team_player",
        "top_scorer",
        "collector",
        "ballhog"
      };
      for (int index = 0; index < this.FrequentRewardObjects.Length; ++index)
      {
        if (array.Length > index)
        {
          string key = array[index].Key;
          int num7 = array[index].Value;
          this.FrequentRewardObjects[index].SetStatValues(ImiServices.Instance.LocaService.GetLocalizedValue("@" + key), num7.ToString(), UnityEngine.Resources.Load<Sprite>("UI/matchAwardIcons/" + key + "_icon_ui"));
        }
        else
          this.FrequentRewardObjects[index].gameObject.SetActive(false);
      }
    }
  }

  private int TryParseInt(JToken token)
  {
    if (token == null)
      return 0;
    try
    {
      return (int) token;
    }
    catch (Exception ex)
    {
      Log.Error("Error parsing int " + ex.Message);
      return 0;
    }
  }
}
