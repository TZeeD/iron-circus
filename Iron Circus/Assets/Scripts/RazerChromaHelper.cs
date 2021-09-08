// Decompiled with JetBrains decompiler
// Type: RazerChromaHelper
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using ChromaSDK;
using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.Game;
using System;
using System.Collections.Generic;

public class RazerChromaHelper
{
  private static readonly string[] RazerDevices = new string[5]
  {
    "Headset",
    "Mouse",
    "Mousepad",
    "Keyboard",
    "ChromaLink"
  };
  private static readonly string[] Animations = new string[11]
  {
    "default",
    "team_alpha",
    "team_beta",
    "BallCarry",
    "BallThrow",
    "GalenaPlaceVortex",
    "GalenaVortex",
    "GalenaAimScramble",
    "GalenaScramble",
    "Blank",
    "ReactiveSpace"
  };
  private static Dictionary<string, RazerAnimation> cachedAnimations;
  private static bool isCarryingBall;

  private static void StartAnimation(string animation)
  {
    ChromaAnimationAPI.PlayAnimation_sc(RazerChromaHelper.cachedAnimations[animation].Headset, true);
    ChromaAnimationAPI.PlayAnimation_sc(RazerChromaHelper.cachedAnimations[animation].Keyboard, true);
    ChromaAnimationAPI.PlayAnimation_sc(RazerChromaHelper.cachedAnimations[animation].Mouse, true);
    ChromaAnimationAPI.PlayAnimation_sc(RazerChromaHelper.cachedAnimations[animation].Mousepad, true);
    ChromaAnimationAPI.PlayAnimation_sc(RazerChromaHelper.cachedAnimations[animation].ChromaLink, true);
  }

  private static void StartAnimationPtr(string animation)
  {
    ChromaAnimationAPI.PlayAnimation_sc(RazerChromaHelper.cachedAnimations[animation].Headset, true);
    ChromaAnimationAPI.PlayAnimation_sc(RazerChromaHelper.cachedAnimations[animation].Keyboard, true);
    ChromaAnimationAPI.PlayAnimation_sc(RazerChromaHelper.cachedAnimations[animation].Mouse, true);
    ChromaAnimationAPI.PlayAnimation_sc(RazerChromaHelper.cachedAnimations[animation].Mousepad, true);
    ChromaAnimationAPI.PlayAnimation_sc(RazerChromaHelper.cachedAnimations[animation].ChromaLink, true);
  }

  public static void LoadAndCacheRazerAnimations()
  {
    // ISSUE: unable to decompile the method.
  }

  public static void ExecuteRazerAnimationForTeam(Team team)
  {
    try
    {
      if (!ChromaAnimationAPI.PluginIsInitialized())
        return;
      switch (team)
      {
        case Team.None:
          RazerChromaHelper.ShowEffectDefaultWhite();
          break;
        case Team.Alpha:
          RazerChromaHelper.ShowEffectTeamAlpha();
          break;
        case Team.Beta:
          RazerChromaHelper.ShowEffectTeamBeta();
          break;
      }
      RazerChromaHelper.isCarryingBall = false;
    }
    catch (Exception ex)
    {
      Log.Error(ex.ToString());
    }
  }

  private static void ShowGalenaVortex() => RazerChromaHelper.StartAnimation("GalenaVortex");

  private static void ShowGalenaPlaceVortex() => RazerChromaHelper.StartAnimation("GalenaPlaceVortex");

  private static void ShowGalenaAimScramble() => RazerChromaHelper.StartAnimation("GalenaAimScramble");

  private static void ShowGalenaScramble() => RazerChromaHelper.StartAnimation("GalenaScramble");

  public static void ShowBallThrow()
  {
    try
    {
      if (!ChromaAnimationAPI.PluginIsInitialized())
        return;
      RazerChromaHelper.StartAnimation("BallThrow");
    }
    catch (Exception ex)
    {
      Log.Error(ex.ToString());
    }
  }

  public static void ShowBallCarry()
  {
    try
    {
      if (!ChromaAnimationAPI.PluginIsInitialized() || RazerChromaHelper.isCarryingBall)
        return;
      RazerChromaHelper.StartAnimation("BallCarry");
      RazerChromaHelper.isCarryingBall = true;
    }
    catch (Exception ex)
    {
      Log.Error(ex.ToString());
    }
  }

  public static void ShowPickupEffectWithColor(int r, int g, int b)
  {
    try
    {
      if (!ChromaAnimationAPI.PluginIsInitialized())
        return;
      RazerChromaHelper.ShowEffect7Keyboard(r, g, b);
      RazerChromaHelper.ShowEffect7ChromaLink(r, g, b);
      RazerChromaHelper.ShowEffect7Headset(r, g, b);
      RazerChromaHelper.ShowEffect7Mousepad(r, g, b);
      RazerChromaHelper.ShowEffect7Mouse(r, g, b);
    }
    catch (Exception ex)
    {
      Log.Error(ex.ToString());
    }
  }

  public static void ShowChampionEffect(ChampionType type, int animation)
  {
    try
    {
      if (!ChromaAnimationAPI.PluginIsInitialized())
        return;
      switch (animation)
      {
        case 0:
          RazerChromaHelper.ShowGalenaAimScramble();
          break;
        case 1:
          RazerChromaHelper.ShowGalenaScramble();
          break;
        case 2:
          RazerChromaHelper.ShowGalenaPlaceVortex();
          break;
        case 3:
          RazerChromaHelper.ShowGalenaVortex();
          break;
      }
    }
    catch (Exception ex)
    {
      Log.Error(ex.ToString());
    }
  }

  public static void ExecuteRazerAnimation(int index)
  {
    try
    {
      if (!ChromaAnimationAPI.PluginIsInitialized())
        return;
      switch (index)
      {
        case 0:
          RazerChromaHelper.ShowEffect0();
          RazerChromaHelper.ShowEffect0ChromaLink();
          RazerChromaHelper.ShowEffect0Headset();
          RazerChromaHelper.ShowEffect0Mousepad();
          RazerChromaHelper.ShowEffect0Mouse();
          break;
        case 1:
          RazerChromaHelper.ShowEffect1();
          RazerChromaHelper.ShowEffect1ChromaLink();
          RazerChromaHelper.ShowEffect1Headset();
          RazerChromaHelper.ShowEffect1Mousepad();
          RazerChromaHelper.ShowEffect1Mouse();
          break;
        case 2:
          RazerChromaHelper.ShowEffect2();
          RazerChromaHelper.ShowEffect2ChromaLink();
          RazerChromaHelper.ShowEffect2Headset();
          RazerChromaHelper.ShowEffect2Mousepad();
          RazerChromaHelper.ShowEffect2Mouse();
          break;
        case 3:
          RazerChromaHelper.ShowEffect3();
          RazerChromaHelper.ShowEffect3ChromaLink();
          RazerChromaHelper.ShowEffect3Headset();
          RazerChromaHelper.ShowEffect3Mousepad();
          RazerChromaHelper.ShowEffect3Mouse();
          break;
        case 4:
          RazerChromaHelper.ShowEffect4();
          RazerChromaHelper.ShowEffect4ChromaLink();
          RazerChromaHelper.ShowEffect4Headset();
          RazerChromaHelper.ShowEffect4Mousepad();
          RazerChromaHelper.ShowEffect4Mouse();
          break;
        case 5:
          RazerChromaHelper.ShowEffect5();
          RazerChromaHelper.ShowEffect5ChromaLink();
          RazerChromaHelper.ShowEffect5Headset();
          RazerChromaHelper.ShowEffect5Mousepad();
          RazerChromaHelper.ShowEffect5Mouse();
          break;
        case 6:
          RazerChromaHelper.ShowEffect6();
          RazerChromaHelper.ShowEffect6ChromaLink();
          RazerChromaHelper.ShowEffect6Headset();
          RazerChromaHelper.ShowEffect6Mousepad();
          RazerChromaHelper.ShowEffect6Mouse();
          break;
        case 8:
          RazerChromaHelper.ShowEffect8();
          RazerChromaHelper.ShowEffect8ChromaLink();
          RazerChromaHelper.ShowEffect8Headset();
          RazerChromaHelper.ShowEffect8Mousepad();
          RazerChromaHelper.ShowEffect8Mouse();
          break;
        case 9:
          RazerChromaHelper.ShowEffect9();
          RazerChromaHelper.ShowEffect9ChromaLink();
          RazerChromaHelper.ShowEffect9Headset();
          RazerChromaHelper.ShowEffect9Mousepad();
          RazerChromaHelper.ShowEffect9Mouse();
          break;
        case 10:
          RazerChromaHelper.ShowEffect10();
          RazerChromaHelper.ShowEffect10ChromaLink();
          RazerChromaHelper.ShowEffect10Headset();
          RazerChromaHelper.ShowEffect10Mousepad();
          RazerChromaHelper.ShowEffect10Mouse();
          break;
      }
    }
    catch (Exception ex)
    {
      Log.Error(ex.ToString());
    }
  }

  private static void ShowEffectDefaultWhite() => RazerChromaHelper.StartAnimation("default");

  private static void ShowEffectTeamAlpha() => RazerChromaHelper.StartAnimation("team_alpha");

  private static void ShowEffectTeamBeta() => RazerChromaHelper.StartAnimation("team_beta");

  private static void ShowEffect0()
  {
    string animation = "Animations/Blank_Keyboard.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, 1, 0.1f, 64, 64, (int) sbyte.MaxValue);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB(15, 75, (int) byte.MaxValue), ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue));
    ChromaAnimationAPI.SetChromaCustomFlagName(animation, true);
    ChromaAnimationAPI.SetChromaCustomColorAllFramesName(animation);
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect0ChromaLink()
  {
    string animation = "Animations/Blank_ChromaLink.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, 1, 0.1f, 64, 64, (int) sbyte.MaxValue);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB(15, 75, (int) byte.MaxValue), ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue));
    ChromaAnimationAPI.SetChromaCustomFlagName(animation, true);
    ChromaAnimationAPI.SetChromaCustomColorAllFramesName(animation);
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect0Headset()
  {
    string animation = "Animations/Blank_Headset.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, 1, 0.1f, 64, 64, (int) sbyte.MaxValue);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB(15, 75, (int) byte.MaxValue), ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue));
    ChromaAnimationAPI.SetChromaCustomFlagName(animation, true);
    ChromaAnimationAPI.SetChromaCustomColorAllFramesName(animation);
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect0Mousepad()
  {
    string animation = "Animations/Blank_Mousepad.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, 1, 0.1f, 64, 64, (int) sbyte.MaxValue);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB(15, 75, (int) byte.MaxValue), ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue));
    ChromaAnimationAPI.SetChromaCustomFlagName(animation, true);
    ChromaAnimationAPI.SetChromaCustomColorAllFramesName(animation);
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect0Mouse()
  {
    string animation = "Animations/Blank_Mouse.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, 1, 0.1f, 64, 64, (int) sbyte.MaxValue);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB(15, 75, (int) byte.MaxValue), ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue));
    ChromaAnimationAPI.SetChromaCustomFlagName(animation, true);
    ChromaAnimationAPI.SetChromaCustomColorAllFramesName(animation);
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect1()
  {
    string str1 = "Animations/Blank_Keyboard.chroma";
    string str2 = "Animations/Spiral_Keyboard.chroma";
    string str3 = "Animations/CircleSmall_Keyboard.chroma";
    ChromaAnimationAPI.CloseAnimationName(str1);
    ChromaAnimationAPI.CloseAnimationName(str2);
    ChromaAnimationAPI.CloseAnimationName(str3);
    ChromaAnimationAPI.GetAnimation(str1);
    ChromaAnimationAPI.GetAnimation(str2);
    ChromaAnimationAPI.GetAnimation(str3);
    int frameCountName = ChromaAnimationAPI.GetFrameCountName(str2);
    ChromaAnimationAPI.MakeBlankFramesRGBName(str1, frameCountName, 0.1f, 64, 64, (int) sbyte.MaxValue);
    int rgb1 = ChromaAnimationAPI.GetRGB(15, 75, (int) byte.MaxValue);
    int rgb2 = ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(str1, rgb1, rgb2);
    ChromaAnimationAPI.SubtractNonZeroAllKeysAllFramesName(str2, str1);
    ChromaAnimationAPI.MultiplyIntensityAllFramesRGBName(str3, (int) byte.MaxValue, (int) byte.MaxValue, 150);
    ChromaAnimationAPI.DuplicateFirstFrameName(str3, frameCountName);
    ChromaAnimationAPI.FadeStartFramesName(str3, 25);
    ChromaAnimationAPI.FadeEndFramesName(str3, 25);
    ChromaAnimationAPI.CopyNonZeroAllKeysAllFramesName(str3, str1);
    ChromaAnimationAPI.SetChromaCustomFlagName(str1, true);
    ChromaAnimationAPI.SetChromaCustomColorAllFramesName(str1);
    ChromaAnimationAPI.OverrideFrameDurationName(str1, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(str1, true);
  }

  private static void ShowEffect1ChromaLink()
  {
    string animation = "Animations/Blank_ChromaLink.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, 150), ChromaAnimationAPI.GetRGB(15, 75, (int) byte.MaxValue));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect1Headset()
  {
    string animation = "Animations/Blank_Headset.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, 150), ChromaAnimationAPI.GetRGB(15, 75, (int) byte.MaxValue));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect1Mousepad()
  {
    string animation = "Animations/Blank_Mousepad.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, 150), ChromaAnimationAPI.GetRGB(15, 75, (int) byte.MaxValue));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect1Mouse()
  {
    string animation = "Animations/Blank_Mouse.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, 150), ChromaAnimationAPI.GetRGB(15, 75, (int) byte.MaxValue));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect2()
  {
    string str1 = "Animations/Blank_Keyboard.chroma";
    string str2 = "Animations/Arrow1_Keyboard.chroma";
    ChromaAnimationAPI.CloseAnimationName(str1);
    ChromaAnimationAPI.CloseAnimationName(str2);
    ChromaAnimationAPI.GetAnimation(str1);
    ChromaAnimationAPI.GetAnimation(str2);
    ChromaAnimationAPI.ReverseAllFramesName(str2);
    int frameCountName = ChromaAnimationAPI.GetFrameCountName(str2);
    int rgb = ChromaAnimationAPI.GetRGB(105, 138, 238);
    ChromaAnimationAPI.MakeBlankFramesName(str1, frameCountName, 0.1f, rgb);
    ChromaAnimationAPI.MultiplyIntensityAllFramesRGBName(str2, (int) byte.MaxValue, 200, 64);
    ChromaAnimationAPI.CopyNonZeroAllKeysAllFramesName(str2, str1);
    ChromaAnimationAPI.SetChromaCustomFlagName(str1, true);
    ChromaAnimationAPI.SetChromaCustomColorAllFramesName(str1);
    ChromaAnimationAPI.OverrideFrameDurationName(str1, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(str1, true);
  }

  private static void ShowEffect2ChromaLink()
  {
    string animation = "Animations/Blank_ChromaLink.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, 0), ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect2Headset()
  {
    string animation = "Animations/Blank_Headset.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, 0), ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect2Mousepad()
  {
    string animation = "Animations/Blank_Mousepad.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, 0), ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect2Mouse()
  {
    string animation = "Animations/Blank_Mouse.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, 0), ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect3()
  {
    string str1 = "Animations/Blank_Keyboard.chroma";
    string str2 = "Animations/BarRightToLeft_Keyboard.chroma";
    ChromaAnimationAPI.CloseAnimationName(str1);
    ChromaAnimationAPI.CloseAnimationName(str2);
    ChromaAnimationAPI.GetAnimation(str1);
    ChromaAnimationAPI.GetAnimation(str2);
    ChromaAnimationAPI.FillNonZeroColorAllFramesRGBName(str2, (int) byte.MaxValue, (int) byte.MaxValue, (int) sbyte.MaxValue);
    ChromaAnimationAPI.DuplicateMirrorFramesName(str2);
    int frameCountName = ChromaAnimationAPI.GetFrameCountName(str2);
    int rgb = ChromaAnimationAPI.GetRGB(105, 138, 238);
    ChromaAnimationAPI.MakeBlankFramesName(str1, frameCountName, 0.1f, rgb);
    ChromaAnimationAPI.SubtractNonZeroAllKeysAllFramesName(str2, str1);
    ChromaAnimationAPI.SetChromaCustomFlagName(str1, true);
    ChromaAnimationAPI.SetChromaCustomColorAllFramesName(str1);
    ChromaAnimationAPI.OverrideFrameDurationName(str1, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(str1, true);
  }

  private static void ShowEffect3ChromaLink()
  {
    string animation = "Animations/Blank_ChromaLink.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB(0, 0, (int) byte.MaxValue), ChromaAnimationAPI.GetRGB(0, (int) byte.MaxValue, (int) byte.MaxValue));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect3Headset()
  {
    string animation = "Animations/Blank_Headset.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB(0, 0, (int) byte.MaxValue), ChromaAnimationAPI.GetRGB(0, (int) byte.MaxValue, (int) byte.MaxValue));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect3Mousepad()
  {
    string animation = "Animations/Blank_Mousepad.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB(0, 0, (int) byte.MaxValue), ChromaAnimationAPI.GetRGB(0, (int) byte.MaxValue, (int) byte.MaxValue));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect3Mouse()
  {
    string animation = "Animations/Blank_Mouse.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB(0, 0, (int) byte.MaxValue), ChromaAnimationAPI.GetRGB(0, (int) byte.MaxValue, (int) byte.MaxValue));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect4()
  {
    string str1 = "Animations/Blank_Keyboard.chroma";
    string str2 = "Animations/Train1_Keyboard.chroma";
    ChromaAnimationAPI.CloseAnimationName(str1);
    ChromaAnimationAPI.CloseAnimationName(str2);
    ChromaAnimationAPI.GetAnimation(str1);
    ChromaAnimationAPI.GetAnimation(str2);
    ChromaAnimationAPI.ReverseAllFramesName(str2);
    ChromaAnimationAPI.MultiplyIntensityAllFramesRGBName(str2, (int) byte.MaxValue, (int) byte.MaxValue, 0);
    int frameCountName = ChromaAnimationAPI.GetFrameCountName(str2);
    int rgb = ChromaAnimationAPI.GetRGB(105, 138, 238);
    ChromaAnimationAPI.MakeBlankFramesName(str1, frameCountName, 0.1f, rgb);
    ChromaAnimationAPI.CopyNonZeroAllKeysAllFramesName(str2, str1);
    ChromaAnimationAPI.SetChromaCustomFlagName(str1, true);
    ChromaAnimationAPI.SetChromaCustomColorAllFramesName(str1);
    ChromaAnimationAPI.OverrideFrameDurationName(str1, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(str1, true);
  }

  private static void ShowEffect4ChromaLink()
  {
    string animation = "Animations/Blank_ChromaLink.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, 0), ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, 100));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect4Headset()
  {
    string animation = "Animations/Blank_Headset.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, 0), ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, 100));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect4Mousepad()
  {
    string animation = "Animations/Blank_Mousepad.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, 0), ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, 100));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect4Mouse()
  {
    string animation = "Animations/Blank_Mouse.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, 0), ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, 100));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect5()
  {
    string str1 = "Animations/Blank_Keyboard.chroma";
    string str2 = "Animations/OutParticle1_Keyboard.chroma";
    ChromaAnimationAPI.CloseAnimationName(str1);
    ChromaAnimationAPI.CloseAnimationName(str2);
    ChromaAnimationAPI.GetAnimation(str1);
    ChromaAnimationAPI.GetAnimation(str2);
    int frameCountName = ChromaAnimationAPI.GetFrameCountName(str2);
    int rgb = ChromaAnimationAPI.GetRGB(105, 138, 238);
    ChromaAnimationAPI.MakeBlankFramesName(str1, frameCountName, 0.1f, rgb);
    ChromaAnimationAPI.MultiplyNonZeroTargetColorLerpAllFramesName(str2, ChromaAnimationAPI.GetRGB((int) byte.MaxValue, 0, 0), ChromaAnimationAPI.GetRGB(0, (int) byte.MaxValue, 0));
    ChromaAnimationAPI.CopyNonZeroAllKeysAllFramesName(str2, str1);
    ChromaAnimationAPI.SetChromaCustomFlagName(str1, true);
    ChromaAnimationAPI.SetChromaCustomColorAllFramesName(str1);
    ChromaAnimationAPI.OverrideFrameDurationName(str1, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(str1, true);
  }

  private static void ShowEffect5ChromaLink()
  {
    string animation = "Animations/Blank_ChromaLink.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB((int) byte.MaxValue, 0, 0), ChromaAnimationAPI.GetRGB(0, (int) byte.MaxValue, 0));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect5Headset()
  {
    string animation = "Animations/Blank_Headset.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB((int) byte.MaxValue, 0, 0), ChromaAnimationAPI.GetRGB(0, (int) byte.MaxValue, 0));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect5Mousepad()
  {
    string animation = "Animations/Blank_Mousepad.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB((int) byte.MaxValue, 0, 0), ChromaAnimationAPI.GetRGB(0, (int) byte.MaxValue, 0));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect5Mouse()
  {
    string animation = "Animations/Blank_Mouse.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB((int) byte.MaxValue, 0, 0), ChromaAnimationAPI.GetRGB(0, (int) byte.MaxValue, 0));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect6()
  {
    string animation = "Animations/Stripes1_Keyboard.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB(105, 138, 238), ChromaAnimationAPI.GetRGB(0, (int) sbyte.MaxValue, 0));
    ChromaAnimationAPI.SetChromaCustomFlagName(animation, true);
    ChromaAnimationAPI.SetChromaCustomColorAllFramesName(animation);
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect6ChromaLink()
  {
    string animation = "Animations/Blank_ChromaLink.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB(0, 0, 0), ChromaAnimationAPI.GetRGB(0, (int) sbyte.MaxValue, 0));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect6Headset()
  {
    string animation = "Animations/Blank_Headset.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB(0, 0, 0), ChromaAnimationAPI.GetRGB(0, (int) sbyte.MaxValue, 0));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect6Mousepad()
  {
    string animation = "Animations/Blank_Mousepad.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB(0, 0, 0), ChromaAnimationAPI.GetRGB(0, (int) sbyte.MaxValue, 0));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect6Mouse()
  {
    string animation = "Animations/Blank_Mouse.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB(0, 0, 0), ChromaAnimationAPI.GetRGB(0, (int) sbyte.MaxValue, 0));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect7Keyboard(int r, int g, int b)
  {
    string str1 = "Animations/Blank_Keyboard.chroma";
    string str2 = "Animations/ReactiveSpace_Keyboard.chroma";
    ChromaAnimationAPI.CloseAnimationName(str1);
    ChromaAnimationAPI.CloseAnimationName(str2);
    ChromaAnimationAPI.GetAnimation(str1);
    ChromaAnimationAPI.GetAnimation(str2);
    int frameCountName = ChromaAnimationAPI.GetFrameCountName(str2);
    int rgb = ChromaAnimationAPI.GetRGB(105, 138, 238);
    ChromaAnimationAPI.MakeBlankFramesName(str1, frameCountName, 0.1f, rgb);
    ChromaAnimationAPI.FillNonZeroColorAllFramesRGBName(str2, r, g, b);
    ChromaAnimationAPI.CopyNonZeroAllKeysAllFramesOffsetName(str2, str1, 0);
    ChromaAnimationAPI.CopyNonZeroAllKeysAllFramesOffsetName(str2, str1, 10);
    ChromaAnimationAPI.SetChromaCustomFlagName(str1, true);
    ChromaAnimationAPI.SetChromaCustomColorAllFramesName(str1);
    ChromaAnimationAPI.OverrideFrameDurationName(str1, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(str1, true);
  }

  private static void ShowEffect7ChromaLink(int r, int g, int b)
  {
    string animation = "Animations/Blank_ChromaLink.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB(0, (int) sbyte.MaxValue, 0), ChromaAnimationAPI.GetRGB(0, (int) byte.MaxValue, 0));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect7Headset(int r, int g, int b)
  {
    string animation = "Animations/Blank_Headset.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB(0, (int) sbyte.MaxValue, 0), ChromaAnimationAPI.GetRGB(0, (int) byte.MaxValue, 0));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect7Mousepad(int r, int g, int b)
  {
    string animation = "Animations/Blank_Mousepad.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB(0, (int) sbyte.MaxValue, 0), ChromaAnimationAPI.GetRGB(0, (int) byte.MaxValue, 0));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect7Mouse(int r, int g, int b)
  {
    string animation = "Animations/Blank_Mouse.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB(0, (int) sbyte.MaxValue, 0), ChromaAnimationAPI.GetRGB(0, (int) byte.MaxValue, 0));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect8()
  {
    string str1 = "Animations/Blank_Keyboard.chroma";
    string str2 = "Animations/Missile1_Keyboard.chroma";
    ChromaAnimationAPI.CloseAnimationName(str1);
    ChromaAnimationAPI.CloseAnimationName(str2);
    ChromaAnimationAPI.GetAnimation(str1);
    ChromaAnimationAPI.GetAnimation(str2);
    ChromaAnimationAPI.ReduceFramesName(str2, 2);
    ChromaAnimationAPI.ReverseAllFramesName(str2);
    int frameCountName = ChromaAnimationAPI.GetFrameCountName(str2);
    int rgb = ChromaAnimationAPI.GetRGB(105, 138, 238);
    ChromaAnimationAPI.MakeBlankFramesName(str1, frameCountName, 0.1f, rgb);
    ChromaAnimationAPI.MultiplyNonZeroTargetColorLerpAllFramesName(str2, ChromaAnimationAPI.GetRGB(0, (int) byte.MaxValue, (int) byte.MaxValue), ChromaAnimationAPI.GetRGB(0, 0, (int) byte.MaxValue));
    ChromaAnimationAPI.CopyNonZeroAllKeysAllFramesName(str2, str1);
    ChromaAnimationAPI.SetChromaCustomFlagName(str1, true);
    ChromaAnimationAPI.SetChromaCustomColorAllFramesName(str1);
    ChromaAnimationAPI.OverrideFrameDurationName(str1, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(str1, true);
  }

  private static void ShowEffect8ChromaLink()
  {
    string animation = "Animations/Blank_ChromaLink.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB(0, (int) byte.MaxValue, (int) byte.MaxValue), ChromaAnimationAPI.GetRGB(0, 0, (int) byte.MaxValue));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect8Headset()
  {
    string animation = "Animations/Blank_Headset.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB(0, (int) byte.MaxValue, (int) byte.MaxValue), ChromaAnimationAPI.GetRGB(0, 0, (int) byte.MaxValue));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect8Mousepad()
  {
    string animation = "Animations/Blank_Mousepad.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB(0, (int) byte.MaxValue, (int) byte.MaxValue), ChromaAnimationAPI.GetRGB(0, 0, (int) byte.MaxValue));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect8Mouse()
  {
    string animation = "Animations/Blank_Mouse.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB(0, (int) byte.MaxValue, (int) byte.MaxValue), ChromaAnimationAPI.GetRGB(0, 0, (int) byte.MaxValue));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect9()
  {
    string animation = "Animations/Star_Keyboard.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB(0, 0, 0), ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, 0));
    ChromaAnimationAPI.SetChromaCustomFlagName(animation, true);
    ChromaAnimationAPI.SetChromaCustomColorAllFramesName(animation);
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect9ChromaLink()
  {
    string animation = "Animations/Blank_ChromaLink.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB(0, 0, 0), ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, 0));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect9Headset()
  {
    string animation = "Animations/Blank_Headset.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB(0, 0, 0), ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, 0));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect9Mousepad()
  {
    string animation = "Animations/Blank_Mousepad.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB(0, 0, 0), ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, 0));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect9Mouse()
  {
    string animation = "Animations/Blank_Mouse.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB(0, 0, 0), ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, 0));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect10()
  {
    string str1 = "Animations/Blank_Keyboard.chroma";
    string str2 = "Animations/CircleSmall_Keyboard.chroma";
    ChromaAnimationAPI.CloseAnimationName(str1);
    ChromaAnimationAPI.CloseAnimationName(str2);
    ChromaAnimationAPI.GetAnimation(str1);
    ChromaAnimationAPI.GetAnimation(str2);
    int frameCountName = ChromaAnimationAPI.GetFrameCountName(str2);
    int rgb = ChromaAnimationAPI.GetRGB(105, 138, 238);
    ChromaAnimationAPI.MakeBlankFramesName(str1, frameCountName, 0.1f, rgb);
    ChromaAnimationAPI.MultiplyNonZeroTargetColorLerpAllFramesName(str2, ChromaAnimationAPI.GetRGB((int) byte.MaxValue, 0, 0), ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue));
    ChromaAnimationAPI.CopyNonZeroAllKeysAllFramesName(str2, str1);
    ChromaAnimationAPI.SetChromaCustomFlagName(str1, true);
    ChromaAnimationAPI.SetChromaCustomColorAllFramesName(str1);
    ChromaAnimationAPI.OverrideFrameDurationName(str1, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(str1, true);
  }

  private static void ShowEffect10ChromaLink()
  {
    string animation = "Animations/Blank_ChromaLink.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB((int) byte.MaxValue, 0, 0), ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect10Headset()
  {
    string animation = "Animations/Blank_Headset.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB((int) byte.MaxValue, 0, 0), ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect10Mousepad()
  {
    string animation = "Animations/Blank_Mousepad.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB((int) byte.MaxValue, 0, 0), ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }

  private static void ShowEffect10Mouse()
  {
    string animation = "Animations/Blank_Mouse.chroma";
    ChromaAnimationAPI.CloseAnimationName(animation);
    ChromaAnimationAPI.GetAnimation(animation);
    int frameCount = 50;
    ChromaAnimationAPI.MakeBlankFramesRGBName(animation, frameCount, 0.1f, (int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue);
    ChromaAnimationAPI.FadeStartFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.FadeEndFramesName(animation, frameCount / 2);
    ChromaAnimationAPI.MultiplyTargetColorLerpAllFramesName(animation, ChromaAnimationAPI.GetRGB((int) byte.MaxValue, 0, 0), ChromaAnimationAPI.GetRGB((int) byte.MaxValue, (int) byte.MaxValue, (int) byte.MaxValue));
    ChromaAnimationAPI.OverrideFrameDurationName(animation, 0.033f);
    ChromaAnimationAPI.PlayAnimationName(animation, true);
  }
}
