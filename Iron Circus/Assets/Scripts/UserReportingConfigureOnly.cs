// Decompiled with JetBrains decompiler
// Type: UserReportingConfigureOnly
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Unity.Cloud.UserReporting.Plugin;
using UnityEngine;

public class UserReportingConfigureOnly : MonoBehaviour
{
  private void Start()
  {
    if (UnityUserReporting.CurrentClient != null)
      return;
    UnityUserReporting.Configure();
  }
}
