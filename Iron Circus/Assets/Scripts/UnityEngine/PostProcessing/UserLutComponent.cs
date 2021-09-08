﻿// Decompiled with JetBrains decompiler
// Type: UnityEngine.PostProcessing.UserLutComponent
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

namespace UnityEngine.PostProcessing
{
  public sealed class UserLutComponent : PostProcessingComponentRenderTexture<UserLutModel>
  {
    public override bool active
    {
      get
      {
        UserLutModel.Settings settings = this.model.settings;
        return this.model.enabled && (Object) settings.lut != (Object) null && (double) settings.contribution > 0.0 && settings.lut.height == (int) Mathf.Sqrt((float) settings.lut.width) && !this.context.interrupted;
      }
    }

    public override void Prepare(Material uberMaterial)
    {
      UserLutModel.Settings settings = this.model.settings;
      uberMaterial.EnableKeyword("USER_LUT");
      uberMaterial.SetTexture(UserLutComponent.Uniforms._UserLut, (Texture) settings.lut);
      uberMaterial.SetVector(UserLutComponent.Uniforms._UserLut_Params, new Vector4(1f / (float) settings.lut.width, 1f / (float) settings.lut.height, (float) settings.lut.height - 1f, settings.contribution));
    }

    public void OnGUI()
    {
      UserLutModel.Settings settings = this.model.settings;
      GUI.DrawTexture(new Rect((float) ((double) this.context.viewport.x * (double) Screen.width + 8.0), 8f, (float) settings.lut.width, (float) settings.lut.height), (Texture) settings.lut);
    }

    private static class Uniforms
    {
      internal static readonly int _UserLut = Shader.PropertyToID(nameof (_UserLut));
      internal static readonly int _UserLut_Params = Shader.PropertyToID(nameof (_UserLut_Params));
    }
  }
}
