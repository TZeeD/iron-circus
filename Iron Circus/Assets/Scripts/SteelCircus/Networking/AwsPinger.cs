// Decompiled with JetBrains decompiler
// Type: SteelCircus.Networking.AwsPinger
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using UnityEngine;

namespace SteelCircus.Networking
{
  public static class AwsPinger
  {
    private const string Ireland = "eu-west-1";
    private const string Frankfurt = "eu-central-1";
    private const string CanadaCentral = "ca-central-1";
    private const string NVirginia = "us-east-1";
    private const string NCalifornia = "us-west-1";
    private const string Oregon = "us-west-2";
    private const string SaoPaulo = "sa-east-1";
    private const string Tokyo = "ap-northeast-1";
    private const string Seoul = "ap-northeast-2";
    private const string Singapore = "ap-southeast-1";
    private const string Sydney = "ap-southeast-2";
    private const string Mumbai = "ap-south-1";
    private static readonly Dictionary<string, string> RegionEndpoints;
    public static Dictionary<string, long> RegionLatencies;
    private static readonly object mutex = new object();

    static AwsPinger()
    {
      lock (AwsPinger.mutex)
      {
        AwsPinger.RegionLatencies = new Dictionary<string, long>();
        AwsPinger.RegionEndpoints = new Dictionary<string, string>()
        {
          ["eu-west-1"] = "18.203.80.136",
          ["eu-central-1"] = "18.194.189.178",
          ["us-east-1"] = "34.227.145.93",
          ["us-west-1"] = "13.52.145.89",
          ["us-west-2"] = "54.149.28.184",
          ["ap-northeast-2"] = "13.209.183.63",
          ["ca-central-1"] = "99.79.28.10",
          ["ap-southeast-1"] = "3.1.140.77",
          ["sa-east-1"] = "18.228.91.238",
          ["ap-northeast-1"] = "13.115.146.48",
          ["ap-southeast-2"] = "3.106.16.244",
          ["ap-south-1"] = "13.126.129.96"
        };
      }
    }

    private static IEnumerator PingPingPing()
    {
      Stopwatch stopwatch = Stopwatch.StartNew();
      Imi.Diagnostics.Log.Debug("AwsPinger start ping.");
      foreach (KeyValuePair<string, string> regionEndpoint in AwsPinger.RegionEndpoints)
      {
        KeyValuePair<string, string> pair = regionEndpoint;
        WaitForSeconds f = new WaitForSeconds(0.05f);
        Ping ping = new Ping(pair.Value);
        while (!ping.isDone)
          yield return (object) f;
        lock (AwsPinger.mutex)
          AwsPinger.RegionLatencies[pair.Key] = ping.time == -1 ? long.MaxValue : (long) ping.time;
        f = (WaitForSeconds) null;
        ping = (Ping) null;
        pair = new KeyValuePair<string, string>();
      }
      Imi.Diagnostics.Log.Debug(string.Format("AwsPinger finished ping: {0}", (object) (uint) stopwatch.Elapsed.TotalMilliseconds));
    }

    public static void PingAll(MonoBehaviour coRoutineRunner) => coRoutineRunner.StartCoroutine(AwsPinger.PingPingPing());

    public static IEnumerator GetPingAll() => AwsPinger.PingPingPing();
  }
}
