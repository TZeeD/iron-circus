// Decompiled with JetBrains decompiler
// Type: UserLUT
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

[PostProcess(typeof (UserLUTRenderer), PostProcessEvent.AfterStack, "Custom/UserLUT", true)]
[Serializable]
public sealed class UserLUT : PostProcessEffectSettings
{
  [DisplayName("LUT")]
  [Tooltip("LDR Lookup Texture, 1024x32")]
  public TextureParameter lut;
  [Range(0.0f, 1f)]
  [Tooltip("LUT blend")]
  public FloatParameter blend;
  [DisplayName("Use Background LUT")]
  [Tooltip("Activate background LUT")]
  public BoolParameter useBackgroundLut;
  [DisplayName("Background LUT")]
  [Tooltip("Background Lookup Texture, 1024x32")]
  public TextureParameter backgroundLut;
  [Tooltip("Distance at which blend to background starts")]
  public FloatParameter backgroundBlendStart;
  [Tooltip("Range of blending default LUT to background LUT (from start of blend)")]
  public FloatParameter backgroundBlendRange;

  public override bool IsEnabledAndSupported(PostProcessRenderContext context) => !((UnityEngine.Object) this.lut.value == (UnityEngine.Object) null) && (double) this.blend.value != 0.0 && this.enabled.value;

  public UserLUT()
  {
    TextureParameter textureParameter1 = new TextureParameter();
    textureParameter1.value = (Texture) null;
    textureParameter1.defaultState = TextureParameterDefault.Lut2D;
    this.lut = textureParameter1;
    FloatParameter floatParameter1 = new FloatParameter();
    floatParameter1.value = 1f;
    this.blend = floatParameter1;
    BoolParameter boolParameter = new BoolParameter();
    boolParameter.value = false;
    this.useBackgroundLut = boolParameter;
    TextureParameter textureParameter2 = new TextureParameter();
    textureParameter2.value = (Texture) null;
    textureParameter2.defaultState = TextureParameterDefault.Lut2D;
    this.backgroundLut = textureParameter2;
    FloatParameter floatParameter2 = new FloatParameter();
    floatParameter2.value = 50f;
    this.backgroundBlendStart = floatParameter2;
    FloatParameter floatParameter3 = new FloatParameter();
    floatParameter3.value = 10f;
    this.backgroundBlendRange = floatParameter3;
    // ISSUE: explicit constructor call
    base.\u002Ector();
  }
}
