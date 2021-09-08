// Decompiled with JetBrains decompiler
// Type: UserReportingXRExtensions
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Unity.Cloud.UserReporting.Plugin;
using UnityEngine;
using UnityEngine.XR;

public class UserReportingXRExtensions : MonoBehaviour
{
  private void Start()
  {
    if (!XRDevice.isPresent)
      return;
    UnityUserReporting.CurrentClient.AddDeviceMetadata("XRDeviceModel", XRDevice.model);
  }

  private void Update()
  {
    if (!XRDevice.isPresent)
      return;
    int droppedFrameCount;
    if (XRStats.TryGetDroppedFrameCount(out droppedFrameCount))
      UnityUserReporting.CurrentClient.SampleMetric("XR.DroppedFrameCount", (double) droppedFrameCount);
    int framePresentCount;
    if (XRStats.TryGetFramePresentCount(out framePresentCount))
      UnityUserReporting.CurrentClient.SampleMetric("XR.FramePresentCount", (double) framePresentCount);
    float gpuTimeLastFrame;
    if (!XRStats.TryGetGPUTimeLastFrame(out gpuTimeLastFrame))
      return;
    UnityUserReporting.CurrentClient.SampleMetric("XR.GPUTimeLastFrame", (double) gpuTimeLastFrame);
  }
}
