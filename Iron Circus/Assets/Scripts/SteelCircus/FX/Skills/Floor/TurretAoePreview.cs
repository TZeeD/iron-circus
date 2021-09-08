// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.Floor.TurretAoePreview
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using UnityEngine;

namespace SteelCircus.FX.Skills.Floor
{
  public class TurretAoePreview : CustomAoePreviewBase
  {
    private static readonly int _OutlineWidth = Shader.PropertyToID(nameof (_OutlineWidth));
    private static readonly int _FireAnimation = Shader.PropertyToID(nameof (_FireAnimation));
    private bool isFiring;
    private float firingCounter;
    private float firingDuration;
    public bool setOutline = true;

    public override void SetAoe(AreaOfEffect aoe)
    {
      this.buildupDuration = 0.45f;
      foreach (Transform scaleNode in this.scaleNodes)
        scaleNode.localScale = Vector3.one * aoe.radius;
      if (!this.setOutline)
        return;
      this.SetPropertyIfExists(TurretAoePreview._OutlineWidth, 0.07f / aoe.radius);
    }

    public override void SetArgs(object args)
    {
      if (args == null)
        return;
      this.isFiring = true;
      this.firingDuration = (float) args;
    }

    protected override void Update()
    {
      base.Update();
      if (!this.isFiring)
        return;
      this.firingCounter = Mathf.Clamp01(this.firingCounter + Time.deltaTime / this.firingDuration);
      this.SetPropertyIfExists(TurretAoePreview._FireAnimation, this.firingCounter);
    }

    protected void LateUpdate() => this.transform.eulerAngles = Vector3.zero;
  }
}
