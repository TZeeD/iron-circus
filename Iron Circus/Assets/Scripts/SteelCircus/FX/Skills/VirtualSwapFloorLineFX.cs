// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.VirtualSwapFloorLineFX
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SteelCircus.ScriptableObjects;
using SteelCircus.FX.Skills.Floor;
using System;
using UnityEngine;

namespace SteelCircus.FX.Skills
{
  public class VirtualSwapFloorLineFX : FloorEffectBase
  {
    public Transform scaleNodeNormals;
    private GameEntity owner;
    private object args;
    private const float maxLineThickness = 1.5f;
    private const float minLineThickness = 0.5f;
    protected static readonly int _ColorMiddleOther = Shader.PropertyToID(nameof (_ColorMiddleOther));
    protected static readonly int _ColorDarkOther = Shader.PropertyToID(nameof (_ColorDarkOther));
    protected static readonly int _Blink = Shader.PropertyToID(nameof (_Blink));

    public override void SetOwner(GameEntity entity)
    {
      base.SetOwner(entity);
      this.owner = entity;
      Team team = entity.playerTeam.value;
      this.SetPropertyIfExists(FloorEffectBase._BuildupBGTime, 1f);
      ColorsConfig instance = SingletonScriptableObject<ColorsConfig>.Instance;
      this.SetPropertyIfExists(VirtualSwapFloorLineFX._ColorMiddleOther, instance.MiddleAoeColor(team.GetOpponents()));
      this.SetPropertyIfExists(VirtualSwapFloorLineFX._ColorDarkOther, instance.DarkAoeColor(team.GetOpponents()));
    }

    public override void SetArgs(object args)
    {
      base.SetArgs(args);
      this.args = args;
    }

    protected override void Update()
    {
      Vector3 position1 = this.owner.unityView.gameObject.transform.position;
      Vector3 position2 = this.transform.position;
      position1.y = position2.y = 0.0f;
      Vector3 to = position1 - position2;
      float magnitude = to.magnitude;
      float y = Vector3.SignedAngle(Vector3.forward, to, Vector3.up);
      float x = 0.5f;
      if (this.args != null)
        x = Mathf.Lerp(1.5f, 0.5f, ((Func<float>) this.args)());
      foreach (Transform scaleNode in this.scaleNodes)
      {
        scaleNode.localScale = new Vector3(x, 1f, magnitude);
        Transform scaleNodeNormals = this.scaleNodeNormals;
        Vector3 vector3_1 = new Vector3(0.0f, y, 0.0f);
        Vector3 vector3_2 = vector3_1;
        scaleNodeNormals.localEulerAngles = vector3_2;
        scaleNode.localEulerAngles = vector3_1;
      }
      this.scaleNodeNormals.localScale = new Vector3(1f, 1f, magnitude);
      this.scaleNodeNormals.localEulerAngles = new Vector3(0.0f, y, 0.0f);
      if ((double) ((Func<float>) this.args)() <= 0.600000023841858)
        return;
      this.SetPropertyIfExists(VirtualSwapFloorLineFX._Blink, 1f);
    }
  }
}
