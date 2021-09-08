// Decompiled with JetBrains decompiler
// Type: UserReportingMonitor
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using Unity.Cloud.UserReporting;
using Unity.Cloud.UserReporting.Plugin;
using UnityEngine;

public class UserReportingMonitor : MonoBehaviour
{
  public bool IsEnabled;
  public bool IsEnabledAfterTrigger;
  public bool IsHiddenWithoutDimension;
  public string MonitorName;
  public string Summary;

  public UserReportingMonitor()
  {
    this.IsEnabled = true;
    this.IsHiddenWithoutDimension = true;
    this.MonitorName = this.GetType().Name;
  }

  private void Start()
  {
    if (UnityUserReporting.CurrentClient != null)
      return;
    UnityUserReporting.Configure();
  }

  public void Trigger()
  {
    if (!this.IsEnabledAfterTrigger)
      this.IsEnabled = false;
    UnityUserReporting.CurrentClient.TakeScreenshot(2048, 2048, (Action<UserReportScreenshot>) (s => { }));
    UnityUserReporting.CurrentClient.TakeScreenshot(512, 512, (Action<UserReportScreenshot>) (s => { }));
    UnityUserReporting.CurrentClient.CreateUserReport((Action<UserReport>) (br =>
    {
      if (string.IsNullOrEmpty(br.ProjectIdentifier))
        Debug.LogWarning((object) "The user report's project identifier is not set. Please setup cloud services using the Services tab or manually specify a project identifier when calling UnityUserReporting.Configure().");
      br.Summary = this.Summary;
      br.DeviceMetadata.Add(new UserReportNamedValue("Monitor", this.MonitorName));
      string str1 = "Unknown";
      string str2 = "0.0";
      foreach (UserReportNamedValue reportNamedValue in br.DeviceMetadata)
      {
        if (reportNamedValue.Name == "Platform")
          str1 = reportNamedValue.Value;
        if (reportNamedValue.Name == "Version")
          str2 = reportNamedValue.Value;
      }
      br.Dimensions.Add(new UserReportNamedValue("Monitor.Platform.Version", string.Format("{0}.{1}.{2}", (object) this.MonitorName, (object) str1, (object) str2)));
      br.Dimensions.Add(new UserReportNamedValue("Monitor", this.MonitorName));
      br.IsHiddenWithoutDimension = this.IsHiddenWithoutDimension;
      UnityUserReporting.CurrentClient.SendUserReport(br, (Action<bool, UserReport>) ((success, br2) => this.Triggered()));
    }));
  }

  protected virtual void Triggered()
  {
  }
}
