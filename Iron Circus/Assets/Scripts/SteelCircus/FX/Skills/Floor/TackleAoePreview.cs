﻿// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.Floor.TackleAoePreview
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using UnityEngine;

namespace SteelCircus.FX.Skills.Floor
{
  public class TackleAoePreview : AimableAoePreviewBase
  {
    protected override void Start()
    {
      base.Start();
      this.buildupCounter = 1f;
      this.SetPropertyIfExists(FloorEffectBase._BuildupBGTime, this.buildupCounter);
    }

    public override void SetAoe(AreaOfEffect aoe)
    {
      base.SetAoe(aoe);
      foreach (Transform scaleNode in this.scaleNodes)
        scaleNode.localScale = new Vector3(aoe.rectWidth, 1f, aoe.rectLength);
    }

    protected override float GetAimOffset() => this.aoe.rectLength / 2f;
  }
}
