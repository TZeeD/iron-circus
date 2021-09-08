// Decompiled with JetBrains decompiler
// Type: SteelCircus.Analytics.AdConversionAnalytics
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SteelCircus.Core.Services;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Text;
using UnityEngine;

namespace SteelCircus.Analytics
{
  public class AdConversionAnalytics : MonoBehaviour
  {
    private static readonly string _AnalyticsEndpoint = "https://app.exomx.com/api/v1/data/sefg";
    private static readonly string _CampaignID = "27";
    private static readonly string _Token = "8iOcIPTl7ZlStbKtF9l2n86jSdHntZQYxgXFedpG2Vshakqrab";

    private void Awake() => ImiServices.Instance.OnMetaLoginSuccessful += new ImiServices.OnMetaLoginSuccessfulEventHandler(this.SendGameStartAnalytics);

    public void SendGameStartAnalytics(ulong playerid)
    {
      Dictionary<string, string> header = new Dictionary<string, string>();
      header["Content-Type"] = "application/json; charset=UTF-8";
      AdConversionAnalytics.AdConversionAnalyticsParameters analyticsParameters = new AdConversionAnalytics.AdConversionAnalyticsParameters()
      {
        os = this.GetOSString(),
        resolution = this.GetResolutionString(),
        language = this.GetSystemLocale(),
        timezone = this.GetTimezoneOffset()
      };
      AdConversionAnalytics.AdConversionAnalyticsRequest request = new AdConversionAnalytics.AdConversionAnalyticsRequest()
      {
        campaign_id = AdConversionAnalytics._CampaignID,
        token = AdConversionAnalytics._Token,
        player_id = this.GetPlayerID(),
        parameters = analyticsParameters
      };
      this.StartCoroutine(this.SendHTTPRequest(header, request));
    }

    private IEnumerator SendHTTPRequest(
      Dictionary<string, string> header,
      AdConversionAnalytics.AdConversionAnalyticsRequest request)
    {
      AdConversionAnalytics conversionAnalytics = this;
      string json = JsonUtility.ToJson((object) request);
      Debug.Log((object) ("Sending analytics request: " + json));
      WWW www = new WWW(AdConversionAnalytics._AnalyticsEndpoint, Encoding.UTF8.GetBytes(json), header);
      yield return (object) www;
      if (string.IsNullOrEmpty(www.error))
        Debug.Log((object) "Success sending ad campaign analytics");
      else
        Debug.Log((object) ("Failure sending ad campaign analytics: " + www.error));
      UnityEngine.Object.Destroy((UnityEngine.Object) conversionAnalytics.gameObject);
    }

    private string GetOSString()
    {
      string str;
      switch (SystemInfo.operatingSystemFamily)
      {
        case OperatingSystemFamily.MacOSX:
          str = "mac";
          break;
        case OperatingSystemFamily.Windows:
          str = "win";
          break;
        case OperatingSystemFamily.Linux:
          str = "linux";
          break;
        default:
          str = "other";
          break;
      }
      return IntPtr.Size != 8 ? str + "32" : str + "64";
    }

    private string GetResolutionString()
    {
      int num = Display.main.systemWidth;
      string str1 = num.ToString();
      num = Display.main.systemHeight;
      string str2 = num.ToString();
      return str1 + "x" + str2;
    }

    private string GetSystemLocale() => CultureInfo.CurrentCulture.TwoLetterISOLanguageName;

    private int GetTimezoneOffset() => (int) TimeZone.CurrentTimeZone.GetUtcOffset(DateTime.Now).TotalMinutes;

    private string GetPlayerID() => string.Concat((object) ImiServices.Instance.LoginService.GetPlayerId());

    private void OnDestroy() => ImiServices.Instance.OnMetaLoginSuccessful -= new ImiServices.OnMetaLoginSuccessfulEventHandler(this.SendGameStartAnalytics);

    [Serializable]
    public struct AdConversionAnalyticsRequest
    {
      public string campaign_id;
      public string token;
      public string player_id;
      public AdConversionAnalytics.AdConversionAnalyticsParameters parameters;
    }

    [Serializable]
    public struct AdConversionAnalyticsParameters
    {
      public string os;
      public string resolution;
      public string language;
      public int timezone;
    }
  }
}
