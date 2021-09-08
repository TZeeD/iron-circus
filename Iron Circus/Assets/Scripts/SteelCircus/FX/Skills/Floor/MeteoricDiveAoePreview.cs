// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.Floor.MeteoricDiveAoePreview
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SteelCircus.Utils;
using UnityEngine;

namespace SteelCircus.FX.Skills.Floor
{
  public class MeteoricDiveAoePreview : CustomAoePreviewBase
  {
    private static readonly int _OutlineWidth = Shader.PropertyToID(nameof (_OutlineWidth));
    private GameEntity entity;
    [SerializeField]
    private Transform line;

    public override void SetAoe(AreaOfEffect aoe)
    {
      foreach (Transform scaleNode in this.scaleNodes)
        scaleNode.localScale = Vector3.one * aoe.radius;
      this.buildupDuration = 0.15f;
    }

    public override void SetOwner(GameEntity entity)
    {
      base.SetOwner(entity);
      this.entity = entity;
    }

    protected void LateUpdate()
    {
      Vector3 position = this.transform.position;
      Vector3 b = position;
      if (this.entity.hasUnityView)
        b = this.entity.unityView.gameObject.transform.position;
      if ((Object) this.line == (Object) null)
        return;
      float num = Vector3.Distance(position, b);
      Vector3 localScale = this.line.localScale;
      localScale.z = num;
      this.line.localScale = localScale;
      this.line.eulerAngles = new Vector3(0.0f, Vector2.SignedAngle(MathUtils.FlattenY(b - position), Vector2.up) + 180f, 0.0f);
      this.line.localPosition = position;
    }

    private void OnDestroy() => Object.Destroy((Object) this.line.gameObject);
  }
}
