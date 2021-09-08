// Decompiled with JetBrains decompiler
// Type: DebugEditorButtonsInScene
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.Game;
using UnityEngine;

public class DebugEditorButtonsInScene : MonoBehaviour
{
  public int razerAnim;
  public int iterations = 1;
  private bool trigger;

  private void Update()
  {
    if (!this.trigger)
      return;
    this.ExecuteRazerAnimation();
  }

  [EditorButton]
  public void GalenaScrambleAim()
  {
    Log.Debug(nameof (GalenaScrambleAim));
    for (int index = 0; index < this.iterations; ++index)
      RazerChromaHelper.ShowChampionEffect(ChampionType.Galena, 0);
  }

  [EditorButton]
  public void GalenaScramble()
  {
    Log.Debug(nameof (GalenaScramble));
    for (int index = 0; index < this.iterations; ++index)
      RazerChromaHelper.ShowChampionEffect(ChampionType.Galena, 1);
  }

  [EditorButton]
  public void GalenaPlaceVortex()
  {
    Log.Debug(nameof (GalenaPlaceVortex));
    for (int index = 0; index < this.iterations; ++index)
      RazerChromaHelper.ShowChampionEffect(ChampionType.Galena, 2);
  }

  [EditorButton]
  public void GalenaVortex()
  {
    Log.Debug(nameof (GalenaVortex));
    for (int index = 0; index < this.iterations; ++index)
      RazerChromaHelper.ShowChampionEffect(ChampionType.Galena, 3);
  }

  [EditorButton]
  public void NoTeam()
  {
    Log.Debug(nameof (NoTeam));
    for (int index = 0; index < this.iterations; ++index)
      RazerChromaHelper.ExecuteRazerAnimationForTeam(Team.None);
  }

  [EditorButton]
  public void Alpha()
  {
    Log.Debug(nameof (Alpha));
    for (int index = 0; index < this.iterations; ++index)
      RazerChromaHelper.ExecuteRazerAnimationForTeam(Team.Alpha);
  }

  [EditorButton]
  public void Beta()
  {
    Log.Debug(nameof (Beta));
    for (int index = 0; index < this.iterations; ++index)
      RazerChromaHelper.ExecuteRazerAnimationForTeam(Team.Beta);
  }

  [EditorButton]
  public void BallCarry()
  {
    Log.Debug(nameof (BallCarry));
    for (int index = 0; index < this.iterations; ++index)
      RazerChromaHelper.ShowBallCarry();
  }

  [EditorButton]
  public void BallThrow()
  {
    Log.Debug(nameof (BallThrow));
    for (int index = 0; index < this.iterations; ++index)
      RazerChromaHelper.ShowBallThrow();
  }

  [EditorButton]
  public void ExecuteRazerAnimation()
  {
    Log.Debug("ExecuteRazerAnimation " + (object) this.razerAnim);
    for (int index = 0; index < this.iterations; ++index)
      RazerChromaHelper.ExecuteRazerAnimation(this.razerAnim);
    this.trigger = false;
  }

  [EditorButton]
  public void PickupNew()
  {
    for (int index = 0; index < this.iterations; ++index)
      RazerChromaHelper.ShowPickupEffectWithColor(74, 0, 110);
  }

  [EditorButton]
  public void PickupOld()
  {
    for (int index = 0; index < this.iterations; ++index)
      RazerChromaHelper.ShowPickupEffectWithColor(74, 0, 110);
  }

  [EditorButton]
  public void Trigger() => this.trigger = true;
}
