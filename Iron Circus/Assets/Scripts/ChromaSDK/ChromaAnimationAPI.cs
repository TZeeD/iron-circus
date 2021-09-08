// Decompiled with JetBrains decompiler
// Type: ChromaSDK.ChromaAnimationAPI
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Runtime.InteropServices;
using System.Text;
using UnityEngine;

namespace ChromaSDK
{
  public class ChromaAnimationAPI
  {
    private const string DLL_NAME = "CChromaEditorLibrary64";

    public static string GetVersion() => "1.11";

    public static bool IsPlatformSupported()
    {
      try
      {
        return ChromaAnimationAPI.PluginIsPlatformSupported();
      }
      catch (Exception ex)
      {
        return false;
      }
    }

    public static int Init()
    {
      if (!ChromaAnimationAPI.IsPlatformSupported())
        return -1;
      bool flag = false;
      try
      {
        flag = ChromaAnimationAPI.PluginIsInitialized();
      }
      catch (Exception ex)
      {
      }
      if (flag)
        return 0;
      int num = -1;
      try
      {
        num = ChromaAnimationAPI.PluginInit();
      }
      catch (Exception ex)
      {
      }
      return num;
    }

    public static int Uninit()
    {
      if (!ChromaAnimationAPI.IsPlatformSupported())
        return -1;
      bool flag = false;
      try
      {
        flag = ChromaAnimationAPI.PluginIsInitialized();
      }
      catch (Exception ex)
      {
      }
      if (!flag)
        return 0;
      int num = -1;
      try
      {
        num = ChromaAnimationAPI.PluginUninit();
      }
      catch (Exception ex)
      {
      }
      return num;
    }

    public static string GetAnimationNameWithExtension(string animation)
    {
      if (string.IsNullOrEmpty(animation))
        return string.Empty;
      return animation.EndsWith(".chroma") ? animation : string.Format("{0}.chroma", (object) animation);
    }

    public static int GetAnimation(string animation)
    {
      if (string.IsNullOrEmpty(animation))
        return -1;
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      int num = -1;
      try
      {
        if (intPtr != IntPtr.Zero)
          num = ChromaAnimationAPI.PluginGetAnimation(intPtr);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("GetAnimation: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
      return num;
    }

    public static (int, IntPtr) GetAnimationForCaching(string animation)
    {
      if (string.IsNullOrEmpty(animation))
        return (-1, IntPtr.Zero);
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      int num = -1;
      try
      {
        if (intPtr != IntPtr.Zero)
          num = ChromaAnimationAPI.PluginGetAnimation(intPtr);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("GetAnimation: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      return (num, intPtr);
    }

    public static void PlayAnimationName(string animation)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginPlayAnimationName(intPtr, false);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("PlayAnimationName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void PlayAnimationName(string animation, bool loop)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginPlayAnimationName(intPtr, loop);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("PlayAnimationName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void PlayAnimation_sc(int animation, bool loop)
    {
      try
      {
        ChromaAnimationAPI.PluginPlayAnimationLoop(animation, loop);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("PluginPlayAnimationLoop: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
    }

    public static void PlayComposite(string name, bool loop)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(name));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginPlayComposite(intPtr, loop);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("Failed to play composite: {0} exception={1}", (object) name, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void StopComposite(string name)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(name));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginStopComposite(intPtr);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("Failed to stop composite: {0} exception={1}", (object) name, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static bool IsPlaying(string animation)
    {
      int animation1 = ChromaAnimationAPI.GetAnimation(animation);
      return animation1 >= 0 && ChromaAnimationAPI.PluginIsPlaying(animation1);
    }

    public static bool IsPlayingType(ChromaAnimationAPI.Device device)
    {
      bool flag = false;
      switch (device)
      {
        case ChromaAnimationAPI.Device.ChromaLink:
          flag = ChromaAnimationAPI.PluginIsPlayingType(0, 0);
          break;
        case ChromaAnimationAPI.Device.Headset:
          flag = ChromaAnimationAPI.PluginIsPlayingType(0, 1);
          break;
        case ChromaAnimationAPI.Device.Keyboard:
          flag = ChromaAnimationAPI.PluginIsPlayingType(1, 0);
          break;
        case ChromaAnimationAPI.Device.Keypad:
          flag = ChromaAnimationAPI.PluginIsPlayingType(1, 1);
          break;
        case ChromaAnimationAPI.Device.Mouse:
          flag = ChromaAnimationAPI.PluginIsPlayingType(1, 2);
          break;
        case ChromaAnimationAPI.Device.Mousepad:
          flag = ChromaAnimationAPI.PluginIsPlayingType(0, 2);
          break;
      }
      return flag;
    }

    public static void StopAnimationName(string animation)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginStopAnimationName(intPtr);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("StopAnimationName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void StopAnimationType(ChromaAnimationAPI.Device device)
    {
      switch (device)
      {
        case ChromaAnimationAPI.Device.ChromaLink:
          ChromaAnimationAPI.PluginStopAnimationType(0, 0);
          break;
        case ChromaAnimationAPI.Device.Headset:
          ChromaAnimationAPI.PluginStopAnimationType(0, 1);
          break;
        case ChromaAnimationAPI.Device.Keyboard:
          ChromaAnimationAPI.PluginStopAnimationType(1, 0);
          break;
        case ChromaAnimationAPI.Device.Keypad:
          ChromaAnimationAPI.PluginStopAnimationType(1, 1);
          break;
        case ChromaAnimationAPI.Device.Mouse:
          ChromaAnimationAPI.PluginStopAnimationType(1, 2);
          break;
        case ChromaAnimationAPI.Device.Mousepad:
          ChromaAnimationAPI.PluginStopAnimationType(0, 2);
          break;
      }
    }

    public static void SetKeyColorName(string animation, int frameId, int rzkey, Color color)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginSetKeyColorName(intPtr, frameId, rzkey, ChromaAnimationAPI.ToBGR(color));
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("Failed to set key color: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void SetKeyColorAllFramesName(string animation, int rzkey, Color color)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
        {
          int frameCountName = ChromaAnimationAPI.GetFrameCountName(animation);
          for (int frameId = 0; frameId < frameCountName; ++frameId)
            ChromaAnimationAPI.PluginSetKeyColorName(intPtr, frameId, rzkey, ChromaAnimationAPI.ToBGR(color));
        }
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("Failed to set key color: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void SetKeysColorName(string animation, int frameId, int[] keys, Color color)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
        {
          foreach (int key in keys)
            ChromaAnimationAPI.PluginSetKeyColorName(intPtr, frameId, key, ChromaAnimationAPI.ToBGR(color));
        }
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("Failed to set keys color: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void SetKeysColorAllFramesName(string animation, int[] keys, Color color)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
        {
          int frameCountName = ChromaAnimationAPI.GetFrameCountName(animation);
          foreach (int key in keys)
          {
            for (int frameId = 0; frameId < frameCountName; ++frameId)
              ChromaAnimationAPI.PluginSetKeyColorName(intPtr, frameId, key, ChromaAnimationAPI.ToBGR(color));
          }
        }
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("Failed to set keys color: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void CopyKeyColorName(
      string sourceAnimation,
      string targetAnimation,
      int frameId,
      int rzkey)
    {
      string streamingPath1 = ChromaAnimationAPI.GetStreamingPath(sourceAnimation);
      string streamingPath2 = ChromaAnimationAPI.GetStreamingPath(targetAnimation);
      IntPtr intPtr1 = ChromaAnimationAPI.GetIntPtr(streamingPath1);
      IntPtr intPtr2 = ChromaAnimationAPI.GetIntPtr(streamingPath2);
      try
      {
        if (intPtr1 != IntPtr.Zero)
          ChromaAnimationAPI.PluginCopyKeyColorName(intPtr1, intPtr2, frameId, rzkey);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("Failed to copy key color: source={0} target={1} exception={2}", (object) sourceAnimation, (object) targetAnimation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr1);
      ChromaAnimationAPI.FreeIntPtr(intPtr2);
    }

    public static void CopyKeyColorAllFramesName(
      string sourceAnimation,
      string targetAnimation,
      int rzkey)
    {
      string streamingPath1 = ChromaAnimationAPI.GetStreamingPath(sourceAnimation);
      string streamingPath2 = ChromaAnimationAPI.GetStreamingPath(targetAnimation);
      IntPtr intPtr1 = ChromaAnimationAPI.GetIntPtr(streamingPath1);
      IntPtr intPtr2 = ChromaAnimationAPI.GetIntPtr(streamingPath2);
      try
      {
        if (intPtr1 != IntPtr.Zero)
        {
          int frameCountName = ChromaAnimationAPI.GetFrameCountName(targetAnimation);
          for (int frameId = 0; frameId < frameCountName; ++frameId)
            ChromaAnimationAPI.PluginCopyKeyColorName(intPtr1, intPtr2, frameId, rzkey);
        }
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("Failed to copy key color: source={0} target={1} exception={2}", (object) sourceAnimation, (object) targetAnimation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr1);
      ChromaAnimationAPI.FreeIntPtr(intPtr2);
    }

    public static void CopyKeysColorName(
      string sourceAnimation,
      string targetAnimation,
      int frameId,
      int[] keys)
    {
      string streamingPath1 = ChromaAnimationAPI.GetStreamingPath(sourceAnimation);
      string streamingPath2 = ChromaAnimationAPI.GetStreamingPath(targetAnimation);
      IntPtr intPtr1 = ChromaAnimationAPI.GetIntPtr(streamingPath1);
      IntPtr intPtr2 = ChromaAnimationAPI.GetIntPtr(streamingPath2);
      try
      {
        if (intPtr1 != IntPtr.Zero)
        {
          foreach (int key in keys)
            ChromaAnimationAPI.PluginCopyKeyColorName(intPtr1, intPtr2, frameId, key);
        }
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("Failed to copy keys color: source={0} target={1} exception={2}", (object) sourceAnimation, (object) targetAnimation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr1);
      ChromaAnimationAPI.FreeIntPtr(intPtr2);
    }

    public static void CopyKeysColorAllFramesName(
      string sourceAnimation,
      string targetAnimation,
      int[] keys)
    {
      string streamingPath1 = ChromaAnimationAPI.GetStreamingPath(sourceAnimation);
      string streamingPath2 = ChromaAnimationAPI.GetStreamingPath(targetAnimation);
      IntPtr intPtr1 = ChromaAnimationAPI.GetIntPtr(streamingPath1);
      IntPtr intPtr2 = ChromaAnimationAPI.GetIntPtr(streamingPath2);
      try
      {
        if (intPtr1 != IntPtr.Zero)
        {
          if (intPtr2 != IntPtr.Zero)
          {
            int frameCountName = ChromaAnimationAPI.GetFrameCountName(targetAnimation);
            foreach (int key in keys)
            {
              for (int frameId = 0; frameId < frameCountName; ++frameId)
                ChromaAnimationAPI.PluginCopyKeyColorName(intPtr1, intPtr2, frameId, key);
            }
          }
        }
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("Failed to copy keys color: source={0} target={1} exception={2}", (object) sourceAnimation, (object) targetAnimation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr1);
      ChromaAnimationAPI.FreeIntPtr(intPtr2);
    }

    public static void CopyNonZeroAllKeysAllFramesName(
      string sourceAnimation,
      string targetAnimation)
    {
      string streamingPath1 = ChromaAnimationAPI.GetStreamingPath(sourceAnimation);
      string streamingPath2 = ChromaAnimationAPI.GetStreamingPath(targetAnimation);
      IntPtr intPtr1 = ChromaAnimationAPI.GetIntPtr(streamingPath1);
      IntPtr intPtr2 = ChromaAnimationAPI.GetIntPtr(streamingPath2);
      try
      {
        if (intPtr1 != IntPtr.Zero)
        {
          if (intPtr2 != IntPtr.Zero)
            ChromaAnimationAPI.PluginCopyNonZeroAllKeysAllFramesName(intPtr1, intPtr2);
        }
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("Failed to copy nonzero keys color: source={0} target={1} exception={2}", (object) sourceAnimation, (object) targetAnimation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr1);
      ChromaAnimationAPI.FreeIntPtr(intPtr2);
    }

    public static void OffsetNonZeroColorsAllFramesName(
      string animation,
      int red,
      int green,
      int blue)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginOffsetNonZeroColorsAllFramesName(intPtr, red, green, blue);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("OffsetNonZeroColorsAllFramesName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void MultiplyIntensityAllFramesName(string animation, float intensity)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginMultiplyIntensityAllFramesName(intPtr, intensity);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("MultiplyIntensityAllFramesName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void MultiplyIntensityAllFramesRGBName(
      string animation,
      int red,
      int green,
      int blue)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginMultiplyIntensityAllFramesRGBName(intPtr, red, green, blue);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("MultiplyIntensityAllFramesRGBName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void FillThresholdColorsMinMaxAllFramesRGBName(
      string animation,
      int minThreshold,
      int minRed,
      int minGreen,
      int minBlue,
      int maxThreshold,
      int maxRed,
      int maxGreen,
      int maxBlue)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginFillThresholdColorsMinMaxAllFramesRGBName(intPtr, minThreshold, minRed, minGreen, minBlue, maxThreshold, maxRed, maxGreen, maxBlue);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("FillThresholdColorsMinMaxAllFramesRGBName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void MakeBlankFramesRGBName(
      string animation,
      int frameCount,
      float duration,
      int red,
      int green,
      int blue)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginMakeBlankFramesRGBName(intPtr, frameCount, duration, red, green, blue);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("MakeBlankFramesRGBName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void FadeStartFramesName(string animation, int fade)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginFadeStartFramesName(intPtr, fade);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("FadeStartFramesName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void FadeEndFramesName(string animation, int fade)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginFadeEndFramesName(intPtr, fade);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("FadeEndFramesName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void MultiplyIntensityName(string animation, int frameId, float intensity)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginMultiplyIntensityName(intPtr, frameId, intensity);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("MultiplyIntensityName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void MultiplyIntensityColorName(string animation, int frameId, int color)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginMultiplyIntensityColorName(intPtr, frameId, color);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("MultiplyIntensityColorName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void FillThresholdColorsRGBName(
      string animation,
      int frameId,
      int threshold,
      int red,
      int green,
      int blue)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginFillThresholdColorsRGBName(intPtr, frameId, threshold, red, green, blue);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("FillThresholdColorsRGBName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void FillThresholdColorsAllFramesRGBName(
      string animation,
      int threshold,
      int red,
      int green,
      int blue)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginFillThresholdColorsAllFramesRGBName(intPtr, threshold, red, green, blue);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("FillThresholdColorsAllFramesRGBName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void OverrideFrameDurationName(string animation, float duration)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginOverrideFrameDurationName(intPtr, duration);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("OverrideFrameDurationName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void OverrideFrameDurationName_sc(IntPtr animation, float duration)
    {
      try
      {
        if (!(animation != IntPtr.Zero))
          return;
        ChromaAnimationAPI.PluginOverrideFrameDurationName(animation, duration);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("OverrideFrameDurationName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
    }

    public static void InvertColorsAllFramesName(string animation)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginInvertColorsAllFramesName(intPtr);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("InvertColorsAllFramesName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void ReduceFramesName(string animation, int n)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginReduceFramesName(intPtr, n);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("ReduceFramesName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void DuplicateFramesName(string animation)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginDuplicateFramesName(intPtr);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("DuplicateFramesName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void MakeBlankFramesName(
      string animation,
      int frameCount,
      float duration,
      int color)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginMakeBlankFramesName(intPtr, frameCount, duration, color);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("MakeBlankFramesName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void MakeBlankFramesName_sc(
      IntPtr animation,
      int frameCount,
      float duration,
      int color)
    {
      try
      {
        if (!(animation != IntPtr.Zero))
          return;
        ChromaAnimationAPI.PluginMakeBlankFramesName(animation, frameCount, duration, color);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("MakeBlankFramesName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
    }

    public static void TrimStartFramesName(string animation, int numberOfFrames)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginTrimStartFramesName(intPtr, numberOfFrames);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("TrimStartFramesName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void TrimEndFramesName(string animation, int numberOfFrames)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginTrimEndFramesName(intPtr, numberOfFrames);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("TrimEndFramesName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void DuplicateFirstFrameName(string animation, int frameCount)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginDuplicateFirstFrameName(intPtr, frameCount);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("DuplicateFirstFrameName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void FillZeroColorAllFramesRGBName(
      string animation,
      int red,
      int green,
      int blue)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginFillZeroColorAllFramesRGBName(intPtr, red, green, blue);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("FillZeroColorAllFramesRGBName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void ReverseAllFramesName(string animation)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginReverseAllFramesName(intPtr);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("ReverseAllFramesName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void DuplicateMirrorFramesName(string animation)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginDuplicateMirrorFramesName(intPtr);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("DuplicateMirrorFramesName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void FillRandomColorsBlackAndWhiteAllFramesName(string animation)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginFillRandomColorsBlackAndWhiteAllFramesName(intPtr);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("FillRandomColorsBlackAndWhiteAllFramesName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void MultiplyIntensityRGBName(
      string animation,
      int frameId,
      int red,
      int green,
      int blue)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginMultiplyIntensityRGBName(intPtr, frameId, red, green, blue);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("MultiplyIntensityRGBName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void FillThresholdColorsAllFramesName(string animation, int threshold, int color)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginFillThresholdColorsAllFramesName(intPtr, threshold, color);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("FillThresholdColorsAllFramesName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void InsertDelayName(string animation, int frameId, int delay)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginInsertDelayName(intPtr, frameId, delay);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("InsertDelayName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void MultiplyTargetColorLerpAllFramesName(
      string animation,
      int color1,
      int color2)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginMultiplyTargetColorLerpAllFramesName(intPtr, color1, color2);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("MultiplyTargetColorLerpAllFramesName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void SetChromaCustomFlagName(string animation, bool flag)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginSetChromaCustomFlagName(intPtr, flag);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("SetChromaCustomFlagName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void SetChromaCustomFlagName_sc(IntPtr animation, bool flag)
    {
      try
      {
        if (!(animation != IntPtr.Zero))
          return;
        ChromaAnimationAPI.PluginSetChromaCustomFlagName(animation, flag);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("SetChromaCustomFlagName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
    }

    public static void SetChromaCustomColorAllFramesName(string animation)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginSetChromaCustomColorAllFramesName(intPtr);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("SetChromaCustomColorAllFramesName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void SetChromaCustomColorAllFramesName_sc(IntPtr animation)
    {
      try
      {
        if (!(animation != IntPtr.Zero))
          return;
        ChromaAnimationAPI.PluginSetChromaCustomColorAllFramesName(animation);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("SetChromaCustomColorAllFramesName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
    }

    public static void MultiplyNonZeroTargetColorLerpAllFramesName(
      string animation,
      int color1,
      int color2)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginMultiplyNonZeroTargetColorLerpAllFramesName(intPtr, color1, color2);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("MultiplyNonZeroTargetColorLerpAllFramesName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void FillNonZeroColorAllFramesRGBName(
      string animation,
      int red,
      int green,
      int blue)
    {
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginFillNonZeroColorAllFramesRGBName(intPtr, red, green, blue);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("FillNonZeroColorAllFramesRGBName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void FillNonZeroColorAllFramesRGBName_sc(
      IntPtr animation,
      int red,
      int green,
      int blue)
    {
      try
      {
        if (animation != IntPtr.Zero)
          ChromaAnimationAPI.PluginFillNonZeroColorAllFramesRGBName(animation, red, green, blue);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("FillNonZeroColorAllFramesRGBName: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(animation);
    }

    public static void AddNonZeroAllKeysAllFramesName(
      string sourceAnimation,
      string targetAnimation)
    {
      IntPtr intPtr1 = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(sourceAnimation));
      IntPtr intPtr2 = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(targetAnimation));
      try
      {
        if (intPtr1 != IntPtr.Zero)
        {
          if (intPtr2 != IntPtr.Zero)
            ChromaAnimationAPI.PluginAddNonZeroAllKeysAllFramesName(intPtr1, intPtr2);
        }
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("AddNonZeroAllKeysAllFramesName: Add frames animation: {0} exception={1}", (object) sourceAnimation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr1);
      ChromaAnimationAPI.FreeIntPtr(intPtr2);
    }

    public static void CopyNonZeroTargetAllKeysAllFramesName(
      string sourceAnimation,
      string targetAnimation)
    {
      IntPtr intPtr1 = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(sourceAnimation));
      IntPtr intPtr2 = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(targetAnimation));
      try
      {
        if (intPtr1 != IntPtr.Zero)
        {
          if (intPtr2 != IntPtr.Zero)
            ChromaAnimationAPI.PluginCopyNonZeroTargetAllKeysAllFramesName(intPtr1, intPtr2);
        }
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("CopyNonZeroTargetAllKeysAllFramesName: Animation: {0} exception={1}", (object) sourceAnimation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr1);
      ChromaAnimationAPI.FreeIntPtr(intPtr2);
    }

    public static void SubtractNonZeroAllKeysAllFramesName(
      string sourceAnimation,
      string targetAnimation)
    {
      IntPtr intPtr1 = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(sourceAnimation));
      IntPtr intPtr2 = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(targetAnimation));
      try
      {
        if (intPtr1 != IntPtr.Zero)
        {
          if (intPtr2 != IntPtr.Zero)
            ChromaAnimationAPI.PluginSubtractNonZeroAllKeysAllFramesName(intPtr1, intPtr2);
        }
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("SubtractNonZeroAllKeysAllFramesName: Animation: {0} exception={1}", (object) sourceAnimation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr1);
      ChromaAnimationAPI.FreeIntPtr(intPtr2);
    }

    public static void CopyNonZeroAllKeysAllFramesOffsetName(
      string sourceAnimation,
      string targetAnimation,
      int offset)
    {
      IntPtr intPtr1 = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(sourceAnimation));
      IntPtr intPtr2 = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(targetAnimation));
      try
      {
        if (intPtr1 != IntPtr.Zero)
        {
          if (intPtr2 != IntPtr.Zero)
            ChromaAnimationAPI.PluginCopyNonZeroAllKeysAllFramesOffsetName(intPtr1, intPtr2, offset);
        }
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("CopyNonZeroAllKeysAllFramesOffsetName: Animation: {0} exception={1}", (object) sourceAnimation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr1);
      ChromaAnimationAPI.FreeIntPtr(intPtr2);
    }

    public static void CopyNonZeroAllKeysAllFramesOffsetName_sc(
      IntPtr sourceAnimation,
      IntPtr targetAnimation,
      int offset)
    {
      try
      {
        if (!(sourceAnimation != IntPtr.Zero) || !(targetAnimation != IntPtr.Zero))
          return;
        ChromaAnimationAPI.PluginCopyNonZeroAllKeysAllFramesOffsetName(sourceAnimation, targetAnimation, offset);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("CopyNonZeroAllKeysAllFramesOffsetName: Animation: {0} exception={1}", (object) sourceAnimation, (object) ex));
      }
    }

    public static int GetRGB(int red, int green, int blue) => red & (int) byte.MaxValue | (green & (int) byte.MaxValue) << 8 | (blue & (int) byte.MaxValue) << 16;

    public static int LerpColor(int from, int to, float t) => ChromaAnimationAPI.PluginLerpColor(from, to, t);

    [DllImport("CChromaEditorLibrary64")]
    public static extern bool PluginIsPlatformSupported();

    [DllImport("CChromaEditorLibrary64")]
    public static extern bool PluginIsInitialized();

    [DllImport("CChromaEditorLibrary64")]
    public static extern bool PluginIsDialogOpen();

    [DllImport("CChromaEditorLibrary64")]
    private static extern int PluginOpenEditorDialogAndPlay(IntPtr path);

    [DllImport("CChromaEditorLibrary64")]
    private static extern int PluginOpenAnimation(IntPtr path);

    [DllImport("CChromaEditorLibrary64")]
    public static extern int PluginLoadAnimation(int animationId);

    [DllImport("CChromaEditorLibrary64")]
    public static extern int PluginUnloadAnimation(int animationId);

    [DllImport("CChromaEditorLibrary64")]
    public static extern int PluginPlayAnimation(int animationId);

    [DllImport("CChromaEditorLibrary64")]
    public static extern bool PluginIsPlaying(int animationId);

    [DllImport("CChromaEditorLibrary64")]
    public static extern int PluginStopAnimation(int animationId);

    [DllImport("CChromaEditorLibrary64")]
    public static extern int PluginCloseAnimation(int animationId);

    [DllImport("CChromaEditorLibrary64")]
    public static extern int PluginInit();

    [DllImport("CChromaEditorLibrary64")]
    private static extern int PluginCreateAnimation(IntPtr path, int deviceType, int device);

    [DllImport("CChromaEditorLibrary64")]
    public static extern int PluginUninit();

    [DllImport("CChromaEditorLibrary64")]
    private static extern int PluginSaveAnimation(int animationId, IntPtr path);

    [DllImport("CChromaEditorLibrary64")]
    public static extern int PluginResetAnimation(int animationId);

    [DllImport("CChromaEditorLibrary64")]
    private static extern int PluginGetDeviceType(int animationId);

    [DllImport("CChromaEditorLibrary64")]
    private static extern int PluginGetDevice(int animationId);

    [DllImport("CChromaEditorLibrary64")]
    private static extern int PluginSetDevice(int animationId, int deviceType, int device);

    [DllImport("CChromaEditorLibrary64")]
    public static extern int PluginGetFrameCount(int animationId);

    [DllImport("CChromaEditorLibrary64")]
    private static extern int PluginGetFrameCountName(IntPtr path);

    [DllImport("CChromaEditorLibrary64")]
    public static extern int PluginGetCurrentFrame(int animationId);

    [DllImport("CChromaEditorLibrary64")]
    private static extern int PluginGetCurrentFrameName(IntPtr path);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginSetKeyColorName(
      IntPtr path,
      int frameId,
      int rzkey,
      int color);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginCopyKeyColorName(
      IntPtr sourcePath,
      IntPtr targetPath,
      int frameId,
      int rzkey);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginCopyNonZeroAllKeysAllFramesName(
      IntPtr sourcePath,
      IntPtr targetPath);

    [DllImport("CChromaEditorLibrary64")]
    public static extern void PluginClearAll();

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginOffsetNonZeroColorsAllFramesName(
      IntPtr path,
      int red,
      int green,
      int blue);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginMultiplyIntensityAllFramesName(IntPtr path, float intensity);

    [DllImport("CChromaEditorLibrary64")]
    private static extern int PluginGetMaxLeds(int device);

    [DllImport("CChromaEditorLibrary64")]
    private static extern int PluginGetMaxRow(int device);

    [DllImport("CChromaEditorLibrary64")]
    private static extern int PluginGetMaxColumn(int device);

    [DllImport("CChromaEditorLibrary64", CallingConvention = CallingConvention.Cdecl)]
    private static extern int PluginAddFrame(
      int animationId,
      float duration,
      int[] colors,
      int length);

    [DllImport("CChromaEditorLibrary64", CallingConvention = CallingConvention.Cdecl)]
    private static extern int PluginUpdateFrame(
      int animationId,
      int frameIndex,
      float duration,
      int[] colors,
      int length);

    [DllImport("CChromaEditorLibrary64", CallingConvention = CallingConvention.Cdecl)]
    private static extern int PluginGetFrame(
      int animationId,
      int frameIndex,
      out float duration,
      int[] colors,
      int length);

    [DllImport("CChromaEditorLibrary64")]
    public static extern int PluginPreviewFrame(int animationId, int frameIndex);

    [DllImport("CChromaEditorLibrary64")]
    public static extern int PluginOverrideFrameDuration(int animationId, float duration);

    [DllImport("CChromaEditorLibrary64")]
    public static extern int PluginReverse(int animationId);

    [DllImport("CChromaEditorLibrary64")]
    public static extern int PluginMirrorHorizontally(int animationId);

    [DllImport("CChromaEditorLibrary64")]
    public static extern int PluginMirrorVertically(int animationId);

    [DllImport("CChromaEditorLibrary64")]
    private static extern int PluginGetAnimation(IntPtr path);

    [DllImport("CChromaEditorLibrary64")]
    private static extern int PluginCloseAnimationName(IntPtr path);

    [DllImport("CChromaEditorLibrary64")]
    public static extern void PluginPlayAnimationLoop(int animationId, bool loop);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginPlayAnimationName(IntPtr path, bool loop);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginStopAnimationName(IntPtr path);

    [DllImport("CChromaEditorLibrary64")]
    public static extern void PluginStopAnimationType(int deviceType, int device);

    [DllImport("CChromaEditorLibrary64")]
    private static extern bool PluginIsPlayingName(IntPtr path);

    [DllImport("CChromaEditorLibrary64")]
    public static extern bool PluginIsPlayingType(int deviceType, int device);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginPlayComposite(IntPtr name, bool loop);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginStopComposite(IntPtr name);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginSetCurrentFrameName(IntPtr path, int frameId);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginPauseAnimationName(IntPtr path);

    [DllImport("CChromaEditorLibrary64")]
    private static extern bool PluginIsAnimationPausedName(IntPtr path);

    [DllImport("CChromaEditorLibrary64")]
    private static extern bool PluginHasAnimationLoopName(IntPtr path);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginResumeAnimationName(IntPtr path, bool loop);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginMultiplyIntensityAllFramesRGBName(
      IntPtr path,
      int red,
      int green,
      int blue);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginFillThresholdColorsMinMaxAllFramesRGBName(
      IntPtr path,
      int minThreshold,
      int minRed,
      int minGreen,
      int minBlue,
      int maxThreshold,
      int maxRed,
      int maxGreen,
      int maxBlue);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginMakeBlankFramesRGBName(
      IntPtr path,
      int frameCount,
      float duration,
      int red,
      int green,
      int blue);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginFadeStartFramesName(IntPtr path, int fade);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginFadeEndFramesName(IntPtr path, int fade);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginMultiplyIntensityName(
      IntPtr path,
      int frameId,
      float intensity);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginMultiplyIntensityColorName(
      IntPtr path,
      int frameId,
      int color);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginFillThresholdColorsRGBName(
      IntPtr path,
      int frameId,
      int threshold,
      int red,
      int green,
      int blue);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginFillThresholdColorsAllFramesRGBName(
      IntPtr path,
      int threshold,
      int red,
      int green,
      int blue);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginOverrideFrameDurationName(IntPtr path, float duration);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginInvertColorsAllFramesName(IntPtr path);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginReduceFramesName(IntPtr path, int n);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginDuplicateFramesName(IntPtr path);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginMakeBlankFramesName(
      IntPtr path,
      int frameCount,
      float duration,
      int color);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginTrimStartFramesName(IntPtr path, int numberOfFrames);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginTrimEndFramesName(IntPtr path, int lastFrameId);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginDuplicateFirstFrameName(IntPtr path, int frameCount);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginFillZeroColorAllFramesRGBName(
      IntPtr path,
      int red,
      int green,
      int blue);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginReverseAllFramesName(IntPtr path);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginDuplicateMirrorFramesName(IntPtr path);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginFillRandomColorsBlackAndWhiteAllFramesName(IntPtr path);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginMultiplyIntensityRGBName(
      IntPtr path,
      int frameId,
      int red,
      int green,
      int blue);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginFillThresholdColorsAllFramesName(
      IntPtr path,
      int threshold,
      int color);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginInsertDelayName(IntPtr path, int frameId, int delay);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginAddNonZeroAllKeysAllFramesName(
      IntPtr sourceAnimation,
      IntPtr targetAnimation);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginCopyNonZeroTargetAllKeysAllFramesName(
      IntPtr sourceAnimation,
      IntPtr targetAnimation);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginSubtractNonZeroAllKeysAllFramesName(
      IntPtr sourceAnimation,
      IntPtr targetAnimation);

    [DllImport("CChromaEditorLibrary64")]
    private static extern int PluginLerpColor(int from, int to, float t);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginMultiplyTargetColorLerpAllFramesName(
      IntPtr path,
      int color1,
      int color2);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginSetChromaCustomFlagName(IntPtr path, bool flag);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginSetChromaCustomColorAllFramesName(IntPtr path);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginMultiplyNonZeroTargetColorLerpAllFramesName(
      IntPtr path,
      int color1,
      int color2);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginFillNonZeroColorAllFramesRGBName(
      IntPtr path,
      int red,
      int green,
      int blue);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginCopyNonZeroAllKeysAllFramesOffsetName(
      IntPtr sourceAnimation,
      IntPtr targetAnimation,
      int offset);

    private static IntPtr GetIntPtr(string path)
    {
      if (string.IsNullOrEmpty(path))
        return IntPtr.Zero;
      byte[] bytes = Encoding.ASCII.GetBytes(path.Replace("/", "\\") + "\0");
      IntPtr destination = Marshal.AllocHGlobal(bytes.Length);
      Marshal.Copy(bytes, 0, destination, bytes.Length);
      return destination;
    }

    private static void FreeIntPtr(IntPtr lpData)
    {
      if (!(lpData != IntPtr.Zero))
        return;
      Marshal.FreeHGlobal(lpData);
    }

    private static int OpenAnimation(string animation)
    {
      if (string.IsNullOrEmpty(animation))
        return -1;
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      int num = 1;
      try
      {
        if (intPtr != IntPtr.Zero)
          num = ChromaAnimationAPI.PluginOpenAnimation(intPtr);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("OpenAnimation: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
      return num;
    }

    public static int PluginSaveAnimation(int animationId, string animation)
    {
      ChromaAnimationAPI.Init();
      if (string.IsNullOrEmpty(animation))
        return -1;
      int num = -1;
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          num = ChromaAnimationAPI.PluginSaveAnimation(animationId, intPtr);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("PluginSaveAnimation: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
      return num;
    }

    public static int GetMaxLeds(ChromaAnimationAPI.Device1D device) => ChromaAnimationAPI.PluginGetMaxLeds((int) device);

    public static int GetMaxRow(ChromaAnimationAPI.Device2D device) => ChromaAnimationAPI.PluginGetMaxRow((int) device);

    public static int GetMaxColumn(ChromaAnimationAPI.Device2D device) => ChromaAnimationAPI.PluginGetMaxColumn((int) device);

    public static int CreateAnimation(string animation, ChromaAnimationAPI.Device device)
    {
      ChromaAnimationAPI.Init();
      if (string.IsNullOrEmpty(animation))
        return -1;
      int deviceType = 0;
      int device1 = 0;
      switch (device)
      {
        case ChromaAnimationAPI.Device.ChromaLink:
          deviceType = 0;
          device1 = 0;
          break;
        case ChromaAnimationAPI.Device.Headset:
          deviceType = 0;
          device1 = 1;
          break;
        case ChromaAnimationAPI.Device.Keyboard:
          deviceType = 1;
          device1 = 0;
          break;
        case ChromaAnimationAPI.Device.Keypad:
          deviceType = 1;
          device1 = 1;
          break;
        case ChromaAnimationAPI.Device.Mouse:
          deviceType = 1;
          device1 = 2;
          break;
        case ChromaAnimationAPI.Device.Mousepad:
          deviceType = 0;
          device1 = 2;
          break;
      }
      int num = -1;
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      try
      {
        if (intPtr != IntPtr.Zero)
          num = ChromaAnimationAPI.PluginCreateAnimation(intPtr, deviceType, device1);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("CreateAnimation: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
      return num;
    }

    public static ChromaAnimationAPI.DeviceType GetDeviceType(int animationId)
    {
      switch (ChromaAnimationAPI.PluginGetDeviceType(animationId))
      {
        case 0:
          return ChromaAnimationAPI.DeviceType.DE_1D;
        case 1:
          return ChromaAnimationAPI.DeviceType.DE_2D;
        default:
          return ChromaAnimationAPI.DeviceType.Invalid;
      }
    }

    public static ChromaAnimationAPI.DeviceType GetDeviceType(string animation)
    {
      int animation1 = ChromaAnimationAPI.GetAnimation(animation);
      return animation1 >= 0 ? ChromaAnimationAPI.GetDeviceType(animation1) : ChromaAnimationAPI.DeviceType.Invalid;
    }

    public static ChromaAnimationAPI.Device GetDevice(int animationId)
    {
      switch (ChromaAnimationAPI.GetDeviceType(animationId))
      {
        case ChromaAnimationAPI.DeviceType.DE_1D:
          switch (ChromaAnimationAPI.PluginGetDevice(animationId))
          {
            case 0:
              return ChromaAnimationAPI.Device.ChromaLink;
            case 1:
              return ChromaAnimationAPI.Device.Headset;
            case 2:
              return ChromaAnimationAPI.Device.Mousepad;
          }
          break;
        case ChromaAnimationAPI.DeviceType.DE_2D:
          switch (ChromaAnimationAPI.PluginGetDevice(animationId))
          {
            case 0:
              return ChromaAnimationAPI.Device.Keyboard;
            case 1:
              return ChromaAnimationAPI.Device.Keypad;
            case 2:
              return ChromaAnimationAPI.Device.Mouse;
          }
          break;
      }
      return ChromaAnimationAPI.Device.Invalid;
    }

    public static ChromaAnimationAPI.Device GetDevice(string animation)
    {
      int animation1 = ChromaAnimationAPI.GetAnimation(animation);
      return animation1 >= 0 ? ChromaAnimationAPI.GetDevice(animation1) : ChromaAnimationAPI.Device.Invalid;
    }

    public static ChromaAnimationAPI.Device1D GetDevice1D(int animationId)
    {
      if (ChromaAnimationAPI.GetDeviceType(animationId) == ChromaAnimationAPI.DeviceType.DE_1D)
      {
        switch (ChromaAnimationAPI.PluginGetDevice(animationId))
        {
          case 0:
            return ChromaAnimationAPI.Device1D.ChromaLink;
          case 1:
            return ChromaAnimationAPI.Device1D.Headset;
          case 2:
            return ChromaAnimationAPI.Device1D.Mousepad;
        }
      }
      return ChromaAnimationAPI.Device1D.Invalid;
    }

    public static ChromaAnimationAPI.Device2D GetDevice2D(int animationId)
    {
      if (ChromaAnimationAPI.GetDeviceType(animationId) == ChromaAnimationAPI.DeviceType.DE_2D)
      {
        switch (ChromaAnimationAPI.PluginGetDevice(animationId))
        {
          case 0:
            return ChromaAnimationAPI.Device2D.Keyboard;
          case 1:
            return ChromaAnimationAPI.Device2D.Keypad;
          case 2:
            return ChromaAnimationAPI.Device2D.Mouse;
        }
      }
      return ChromaAnimationAPI.Device2D.Invalid;
    }

    public static int SetDevice(string animation, ChromaAnimationAPI.Device device)
    {
      int animation1 = ChromaAnimationAPI.GetAnimation(animation);
      if (animation1 >= 0)
      {
        switch (device)
        {
          case ChromaAnimationAPI.Device.ChromaLink:
            return ChromaAnimationAPI.PluginSetDevice(animation1, 0, 0);
          case ChromaAnimationAPI.Device.Headset:
            return ChromaAnimationAPI.PluginSetDevice(animation1, 0, 1);
          case ChromaAnimationAPI.Device.Keyboard:
            return ChromaAnimationAPI.PluginSetDevice(animation1, 1, 0);
          case ChromaAnimationAPI.Device.Keypad:
            return ChromaAnimationAPI.PluginSetDevice(animation1, 1, 1);
          case ChromaAnimationAPI.Device.Mouse:
            return ChromaAnimationAPI.PluginSetDevice(animation1, 1, 2);
          case ChromaAnimationAPI.Device.Mousepad:
            return ChromaAnimationAPI.PluginSetDevice(animation1, 0, 2);
        }
      }
      return animation1;
    }

    public static int GetFrameCountName(string animation)
    {
      int num = -1;
      string streamingPath = ChromaAnimationAPI.GetStreamingPath(animation);
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(streamingPath);
      try
      {
        if (intPtr != IntPtr.Zero)
          num = ChromaAnimationAPI.PluginGetFrameCountName(intPtr);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("Failed to get frame count: {0} exception={1}", (object) streamingPath, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
      return num;
    }

    public static int GetFrameCountName_sc(IntPtr animation)
    {
      int num = -1;
      try
      {
        if (animation != IntPtr.Zero)
          num = ChromaAnimationAPI.PluginGetFrameCountName(animation);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("Failed to get frame count exception={0}", (object) ex));
      }
      return num;
    }

    public static int GetCurrentFrameName(string animation)
    {
      int num = -1;
      string streamingPath = ChromaAnimationAPI.GetStreamingPath(animation);
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(streamingPath);
      try
      {
        if (intPtr != IntPtr.Zero)
          num = ChromaAnimationAPI.PluginGetCurrentFrameName(intPtr);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("Failed to get current frame: {0} exception={1}", (object) streamingPath, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
      return num;
    }

    public static void SetCurrentFrameName(string animation, int frameId)
    {
      string streamingPath = ChromaAnimationAPI.GetStreamingPath(animation);
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(streamingPath);
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginSetCurrentFrameName(intPtr, frameId);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("Failed to set current frame: {0} exception={1}", (object) streamingPath, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static bool IsAnimationPausedName(string animation)
    {
      bool flag = false;
      string streamingPath = ChromaAnimationAPI.GetStreamingPath(animation);
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(streamingPath);
      try
      {
        if (intPtr != IntPtr.Zero)
          flag = ChromaAnimationAPI.PluginIsAnimationPausedName(intPtr);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("Failed to get is animation paused: {0} exception={1}", (object) streamingPath, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
      return flag;
    }

    public static bool HasAnimationLoopName(string animation)
    {
      bool flag = false;
      string streamingPath = ChromaAnimationAPI.GetStreamingPath(animation);
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(streamingPath);
      try
      {
        if (intPtr != IntPtr.Zero)
          flag = ChromaAnimationAPI.PluginHasAnimationLoopName(intPtr);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("Failed to get has animation loop: {0} exception={1}", (object) streamingPath, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
      return flag;
    }

    public static void PauseAnimationName(string animation)
    {
      string streamingPath = ChromaAnimationAPI.GetStreamingPath(animation);
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(streamingPath);
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginPauseAnimationName(intPtr);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("PauseAnimationName: Animation: {0} exception={1}", (object) streamingPath, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static void ResumeAnimationName(string animation, bool loop)
    {
      string streamingPath = ChromaAnimationAPI.GetStreamingPath(animation);
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(streamingPath);
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginResumeAnimationName(intPtr, loop);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("ResumeAnimationName: Animation: {0} exception={1}", (object) streamingPath, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static int AddFrame(int animationId, float duration, int[] colors) => ChromaAnimationAPI.PluginAddFrame(animationId, duration, colors, colors.Length);

    public static int UpdateFrame(int animationId, int frameIndex, float duration, int[] colors) => ChromaAnimationAPI.PluginUpdateFrame(animationId, frameIndex, duration, colors, colors.Length);

    public static int GetFrame(int animationId, int frameIndex, out float duration, int[] colors) => ChromaAnimationAPI.PluginGetFrame(animationId, frameIndex, out duration, colors, colors.Length);

    [DllImport("CChromaEditorLibrary64")]
    private static extern void PluginSetLogDelegate(IntPtr logDelegate);

    static ChromaAnimationAPI() => ChromaAnimationAPI.PluginSetLogDelegate(IntPtr.Zero);

    public static string GetStreamingPath(string animation) => string.Format("{0}/{1}", (object) Application.streamingAssetsPath, (object) animation);

    public static void CloseAnimationName(string animation)
    {
      string streamingPath = ChromaAnimationAPI.GetStreamingPath(animation);
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(streamingPath);
      try
      {
        if (intPtr != IntPtr.Zero)
          ChromaAnimationAPI.PluginCloseAnimationName(intPtr);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("CloseAnimationName: Animation: {0} exception={1}", (object) streamingPath, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
    }

    public static int Reverse(string animation)
    {
      int animation1 = ChromaAnimationAPI.GetAnimation(animation);
      return animation1 >= 0 ? ChromaAnimationAPI.PluginReverse(animation1) : animation1;
    }

    public static int MirrorHorizontally(string animation)
    {
      int animation1 = ChromaAnimationAPI.GetAnimation(animation);
      return animation1 >= 0 ? ChromaAnimationAPI.PluginMirrorHorizontally(animation1) : animation1;
    }

    public static int MirrorVertically(string animation)
    {
      int animation1 = ChromaAnimationAPI.GetAnimation(animation);
      return animation1 >= 0 ? ChromaAnimationAPI.PluginMirrorVertically(animation1) : animation1;
    }

    public static int EditAnimation(string animation)
    {
      ChromaAnimationAPI.Init();
      if (string.IsNullOrEmpty(animation))
        return -1;
      IntPtr intPtr = ChromaAnimationAPI.GetIntPtr(ChromaAnimationAPI.GetStreamingPath(animation));
      int num = 1;
      try
      {
        if (intPtr != IntPtr.Zero)
          num = ChromaAnimationAPI.PluginOpenEditorDialogAndPlay(intPtr);
      }
      catch (Exception ex)
      {
        Debug.LogError((object) string.Format("EditAnimation: Animation: {0} exception={1}", (object) animation, (object) ex));
      }
      ChromaAnimationAPI.FreeIntPtr(intPtr);
      return num;
    }

    public static Color ToColor(int bgrInt) => new Color((float) (bgrInt & (int) byte.MaxValue) / (float) byte.MaxValue, (float) ((bgrInt & 65280) >> 8) / (float) byte.MaxValue, (float) ((bgrInt & 16711680) >> 16) / (float) byte.MaxValue, 1f);

    public static int ToBGR(Color color)
    {
      int num1 = (int) ((double) Mathf.Clamp01(color.r) * (double) byte.MaxValue);
      int num2 = (int) ((double) Mathf.Clamp01(color.g) * (double) byte.MaxValue) << 8;
      return (int) ((double) Mathf.Clamp01(color.b) * (double) byte.MaxValue) << 16 | num2 | num1;
    }

    public static int ToRGB(Color color)
    {
      int num1 = (int) ((double) Mathf.Clamp01(color.b) * (double) byte.MaxValue);
      int num2 = (int) ((double) Mathf.Clamp01(color.g) * (double) byte.MaxValue) << 8;
      return (int) ((double) Mathf.Clamp01(color.r) * (double) byte.MaxValue) << 16 | num2 | num1;
    }

    public static int GetLowByte(int mask) => mask & (int) byte.MaxValue;

    public static int GetHighByte(int mask) => (mask & 65280) >> 8 & (int) byte.MaxValue;

    public static int[] CreateColors1D(ChromaAnimationAPI.Device1D device)
    {
      switch (device)
      {
        case ChromaAnimationAPI.Device1D.ChromaLink:
        case ChromaAnimationAPI.Device1D.Headset:
        case ChromaAnimationAPI.Device1D.Mousepad:
          int[] numArray = new int[ChromaAnimationAPI.GetMaxLeds(device)];
          for (int index = 0; index < numArray.Length; ++index)
            numArray[0] = 0;
          return numArray;
        default:
          Debug.LogError((object) "CreateColors1D: Invalid device!");
          return (int[]) null;
      }
    }

    public static int[] CreateColors2D(ChromaAnimationAPI.Device2D device)
    {
      switch (device)
      {
        case ChromaAnimationAPI.Device2D.Keyboard:
        case ChromaAnimationAPI.Device2D.Keypad:
        case ChromaAnimationAPI.Device2D.Mouse:
          int[] numArray = new int[ChromaAnimationAPI.GetMaxRow(device) * ChromaAnimationAPI.GetMaxColumn(device)];
          for (int index = 0; index < numArray.Length; ++index)
            numArray[0] = 0;
          return numArray;
        default:
          Debug.LogError((object) "CreateColors2D: Invalid device!");
          return (int[]) null;
      }
    }

    public static int[] CreateColors(ChromaAnimationAPI.Device device)
    {
      switch (device)
      {
        case ChromaAnimationAPI.Device.ChromaLink:
          return ChromaAnimationAPI.CreateColors1D(ChromaAnimationAPI.Device1D.ChromaLink);
        case ChromaAnimationAPI.Device.Headset:
          return ChromaAnimationAPI.CreateColors1D(ChromaAnimationAPI.Device1D.Headset);
        case ChromaAnimationAPI.Device.Keyboard:
          return ChromaAnimationAPI.CreateColors2D(ChromaAnimationAPI.Device2D.Keyboard);
        case ChromaAnimationAPI.Device.Keypad:
          return ChromaAnimationAPI.CreateColors2D(ChromaAnimationAPI.Device2D.Keypad);
        case ChromaAnimationAPI.Device.Mouse:
          return ChromaAnimationAPI.CreateColors2D(ChromaAnimationAPI.Device2D.Mouse);
        case ChromaAnimationAPI.Device.Mousepad:
          return ChromaAnimationAPI.CreateColors1D(ChromaAnimationAPI.Device1D.Mousepad);
        default:
          Debug.LogError((object) "CreateColors: Invalid device!");
          return (int[]) null;
      }
    }

    public static int GetKeyboardIndex(int key)
    {
      int maxColumn = ChromaAnimationAPI.GetMaxColumn(ChromaAnimationAPI.Device2D.Keyboard);
      int highByte = ChromaAnimationAPI.GetHighByte(key);
      int lowByte = ChromaAnimationAPI.GetLowByte(key);
      int num = maxColumn;
      return highByte * num + lowByte;
    }

    public static void SetKeyboardColor(int[] colors, int key, Color color)
    {
      int keyboardIndex = ChromaAnimationAPI.GetKeyboardIndex(key);
      if (keyboardIndex >= colors.Length)
        return;
      colors[keyboardIndex] = ChromaAnimationAPI.ToBGR(color);
    }

    public static int GetMouseIndex(int led)
    {
      int maxColumn = ChromaAnimationAPI.GetMaxColumn(ChromaAnimationAPI.Device2D.Mouse);
      int highByte = ChromaAnimationAPI.GetHighByte(led);
      int lowByte = ChromaAnimationAPI.GetLowByte(led);
      int num = maxColumn;
      return highByte * num + lowByte;
    }

    public class Keyboard
    {
      public enum RZKEY
      {
        RZKEY_ESC = 1,
        RZKEY_F1 = 3,
        RZKEY_F2 = 4,
        RZKEY_F3 = 5,
        RZKEY_F4 = 6,
        RZKEY_F5 = 7,
        RZKEY_F6 = 8,
        RZKEY_F7 = 9,
        RZKEY_F8 = 10, // 0x0000000A
        RZKEY_F9 = 11, // 0x0000000B
        RZKEY_F10 = 12, // 0x0000000C
        RZKEY_F11 = 13, // 0x0000000D
        RZKEY_F12 = 14, // 0x0000000E
        RZKEY_PRINTSCREEN = 15, // 0x0000000F
        RZKEY_SCROLL = 16, // 0x00000010
        RZKEY_PAUSE = 17, // 0x00000011
        RZKEY_JPN_1 = 21, // 0x00000015
        RZKEY_KOR_1 = 21, // 0x00000015
        RZKEY_MACRO1 = 256, // 0x00000100
        RZKEY_OEM_1 = 257, // 0x00000101
        RZKEY_1 = 258, // 0x00000102
        RZKEY_2 = 259, // 0x00000103
        RZKEY_3 = 260, // 0x00000104
        RZKEY_4 = 261, // 0x00000105
        RZKEY_5 = 262, // 0x00000106
        RZKEY_6 = 263, // 0x00000107
        RZKEY_7 = 264, // 0x00000108
        RZKEY_8 = 265, // 0x00000109
        RZKEY_9 = 266, // 0x0000010A
        RZKEY_0 = 267, // 0x0000010B
        RZKEY_OEM_2 = 268, // 0x0000010C
        RZKEY_OEM_3 = 269, // 0x0000010D
        RZKEY_BACKSPACE = 270, // 0x0000010E
        RZKEY_INSERT = 271, // 0x0000010F
        RZKEY_HOME = 272, // 0x00000110
        RZKEY_PAGEUP = 273, // 0x00000111
        RZKEY_NUMLOCK = 274, // 0x00000112
        RZKEY_NUMPAD_DIVIDE = 275, // 0x00000113
        RZKEY_NUMPAD_MULTIPLY = 276, // 0x00000114
        RZKEY_NUMPAD_SUBTRACT = 277, // 0x00000115
        RZKEY_MACRO2 = 512, // 0x00000200
        RZKEY_TAB = 513, // 0x00000201
        RZKEY_Q = 514, // 0x00000202
        RZKEY_W = 515, // 0x00000203
        RZKEY_E = 516, // 0x00000204
        RZKEY_R = 517, // 0x00000205
        RZKEY_T = 518, // 0x00000206
        RZKEY_Y = 519, // 0x00000207
        RZKEY_U = 520, // 0x00000208
        RZKEY_I = 521, // 0x00000209
        RZKEY_O = 522, // 0x0000020A
        RZKEY_P = 523, // 0x0000020B
        RZKEY_OEM_4 = 524, // 0x0000020C
        RZKEY_OEM_5 = 525, // 0x0000020D
        RZKEY_OEM_6 = 526, // 0x0000020E
        RZKEY_DELETE = 527, // 0x0000020F
        RZKEY_END = 528, // 0x00000210
        RZKEY_PAGEDOWN = 529, // 0x00000211
        RZKEY_NUMPAD7 = 530, // 0x00000212
        RZKEY_NUMPAD8 = 531, // 0x00000213
        RZKEY_NUMPAD9 = 532, // 0x00000214
        RZKEY_NUMPAD_ADD = 533, // 0x00000215
        RZKEY_MACRO3 = 768, // 0x00000300
        RZKEY_CAPSLOCK = 769, // 0x00000301
        RZKEY_A = 770, // 0x00000302
        RZKEY_S = 771, // 0x00000303
        RZKEY_D = 772, // 0x00000304
        RZKEY_F = 773, // 0x00000305
        RZKEY_G = 774, // 0x00000306
        RZKEY_H = 775, // 0x00000307
        RZKEY_J = 776, // 0x00000308
        RZKEY_K = 777, // 0x00000309
        RZKEY_L = 778, // 0x0000030A
        RZKEY_OEM_7 = 779, // 0x0000030B
        RZKEY_OEM_8 = 780, // 0x0000030C
        RZKEY_EUR_1 = 781, // 0x0000030D
        RZKEY_KOR_2 = 781, // 0x0000030D
        RZKEY_ENTER = 782, // 0x0000030E
        RZKEY_NUMPAD4 = 786, // 0x00000312
        RZKEY_NUMPAD5 = 787, // 0x00000313
        RZKEY_NUMPAD6 = 788, // 0x00000314
        RZKEY_MACRO4 = 1024, // 0x00000400
        RZKEY_LSHIFT = 1025, // 0x00000401
        RZKEY_EUR_2 = 1026, // 0x00000402
        RZKEY_KOR_3 = 1026, // 0x00000402
        RZKEY_Z = 1027, // 0x00000403
        RZKEY_X = 1028, // 0x00000404
        RZKEY_C = 1029, // 0x00000405
        RZKEY_V = 1030, // 0x00000406
        RZKEY_B = 1031, // 0x00000407
        RZKEY_N = 1032, // 0x00000408
        RZKEY_M = 1033, // 0x00000409
        RZKEY_OEM_9 = 1034, // 0x0000040A
        RZKEY_OEM_10 = 1035, // 0x0000040B
        RZKEY_OEM_11 = 1036, // 0x0000040C
        RZKEY_JPN_2 = 1037, // 0x0000040D
        RZKEY_KOR_4 = 1037, // 0x0000040D
        RZKEY_RSHIFT = 1038, // 0x0000040E
        RZKEY_UP = 1040, // 0x00000410
        RZKEY_NUMPAD1 = 1042, // 0x00000412
        RZKEY_NUMPAD2 = 1043, // 0x00000413
        RZKEY_NUMPAD3 = 1044, // 0x00000414
        RZKEY_NUMPAD_ENTER = 1045, // 0x00000415
        RZKEY_MACRO5 = 1280, // 0x00000500
        RZKEY_LCTRL = 1281, // 0x00000501
        RZKEY_LWIN = 1282, // 0x00000502
        RZKEY_LALT = 1283, // 0x00000503
        RZKEY_JPN_3 = 1284, // 0x00000504
        RZKEY_KOR_5 = 1284, // 0x00000504
        RZKEY_SPACE = 1287, // 0x00000507
        RZKEY_JPN_4 = 1289, // 0x00000509
        RZKEY_KOR_6 = 1289, // 0x00000509
        RZKEY_JPN_5 = 1290, // 0x0000050A
        RZKEY_KOR_7 = 1290, // 0x0000050A
        RZKEY_RALT = 1291, // 0x0000050B
        RZKEY_FN = 1292, // 0x0000050C
        RZKEY_RMENU = 1293, // 0x0000050D
        RZKEY_RCTRL = 1294, // 0x0000050E
        RZKEY_LEFT = 1295, // 0x0000050F
        RZKEY_DOWN = 1296, // 0x00000510
        RZKEY_RIGHT = 1297, // 0x00000511
        RZKEY_NUMPAD0 = 1299, // 0x00000513
        RZKEY_NUMPAD_DECIMAL = 1300, // 0x00000514
      }

      public enum RZLED
      {
        RZLED_LOGO = 20, // 0x00000014
      }
    }

    public class Mouse
    {
      public enum RZLED2
      {
        RZLED2_LEFT_SIDE1 = 256, // 0x00000100
        RZLED2_RIGHT_SIDE1 = 262, // 0x00000106
        RZLED2_LEFT_SIDE2 = 512, // 0x00000200
        RZLED2_SCROLLWHEEL = 515, // 0x00000203
        RZLED2_RIGHT_SIDE2 = 518, // 0x00000206
        RZLED2_LEFT_SIDE3 = 768, // 0x00000300
        RZLED2_RIGHT_SIDE3 = 774, // 0x00000306
        RZLED2_LEFT_SIDE4 = 1024, // 0x00000400
        RZLED2_BACKLIGHT = 1027, // 0x00000403
        RZLED2_RIGHT_SIDE4 = 1030, // 0x00000406
        RZLED2_LEFT_SIDE5 = 1280, // 0x00000500
        RZLED2_RIGHT_SIDE5 = 1286, // 0x00000506
        RZLED2_LEFT_SIDE6 = 1536, // 0x00000600
        RZLED2_RIGHT_SIDE6 = 1542, // 0x00000606
        RZLED2_LEFT_SIDE7 = 1792, // 0x00000700
        RZLED2_LOGO = 1795, // 0x00000703
        RZLED2_RIGHT_SIDE7 = 1798, // 0x00000706
        RZLED2_BOTTOM1 = 2049, // 0x00000801
        RZLED2_BOTTOM2 = 2050, // 0x00000802
        RZLED2_BOTTOM3 = 2051, // 0x00000803
        RZLED2_BOTTOM4 = 2052, // 0x00000804
        RZLED2_BOTTOM5 = 2053, // 0x00000805
      }
    }

    public enum DeviceType
    {
      Invalid = -1, // 0xFFFFFFFF
      DE_1D = 0,
      DE_2D = 1,
      MAX = 2,
    }

    public enum Device
    {
      Invalid = -1, // 0xFFFFFFFF
      ChromaLink = 0,
      Headset = 1,
      Keyboard = 2,
      Keypad = 3,
      Mouse = 4,
      Mousepad = 5,
      MAX = 6,
    }

    public enum Device1D
    {
      Invalid = -1, // 0xFFFFFFFF
      ChromaLink = 0,
      Headset = 1,
      Mousepad = 2,
      MAX = 3,
    }

    public enum Device2D
    {
      Invalid = -1, // 0xFFFFFFFF
      Keyboard = 0,
      Keypad = 1,
      Mouse = 2,
      MAX = 3,
    }
  }
}
