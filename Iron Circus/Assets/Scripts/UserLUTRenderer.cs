// Decompiled with JetBrains decompiler
// Type: UserLUTRenderer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

public sealed class UserLUTRenderer : PostProcessEffectRenderer<UserLUT>
{
  public override DepthTextureMode GetCameraFlags() => this.settings.useBackgroundLut.value ? DepthTextureMode.Depth : DepthTextureMode.None;

  public override void Render(PostProcessRenderContext context)
  {
    PropertySheet propertySheet = context.propertySheets.Get(Shader.Find("Hidden/Custom/UserLUT"));
    propertySheet.ClearKeywords();
    Texture texture = this.settings.lut.value;
    Vector4 vector4 = new Vector4(1f / (float) texture.width, 1f / (float) texture.height, (float) texture.height - 1f, this.settings.blend.value);
    propertySheet.properties.SetTexture(UserLUTRenderer.Uniforms._UserLut, texture);
    propertySheet.properties.SetVector(UserLUTRenderer.Uniforms._UserLut_Params, vector4);
    if ((bool) (ParameterOverride<bool>) this.settings.useBackgroundLut)
    {
      propertySheet.EnableKeyword("USE_BG_LUT");
      if ((Object) this.settings.backgroundLut.value != (Object) null)
        texture = this.settings.backgroundLut.value;
      vector4 = new Vector4(1f / (float) texture.width, 1f / (float) texture.height, (float) texture.height - 1f, 0.0f);
      propertySheet.properties.SetTexture(UserLUTRenderer.Uniforms._BGLut, texture);
      propertySheet.properties.SetVector(UserLUTRenderer.Uniforms._BGLut_Params, vector4);
      propertySheet.properties.SetVector(UserLUTRenderer.Uniforms._BGLut_Blend, new Vector4(this.settings.backgroundBlendStart.value, this.settings.backgroundBlendRange.value, 0.0f, 0.0f));
    }
    context.command.BlitFullscreenTriangle(context.source, context.destination, propertySheet, 0);
  }

  private static class Uniforms
  {
    internal static readonly int _UserLut = Shader.PropertyToID(nameof (_UserLut));
    internal static readonly int _UserLut_Params = Shader.PropertyToID(nameof (_UserLut_Params));
    internal static readonly int _BGLut = Shader.PropertyToID(nameof (_BGLut));
    internal static readonly int _BGLut_Params = Shader.PropertyToID(nameof (_BGLut_Params));
    internal static readonly int _BGLut_Blend = Shader.PropertyToID(nameof (_BGLut_Blend));
  }
}
