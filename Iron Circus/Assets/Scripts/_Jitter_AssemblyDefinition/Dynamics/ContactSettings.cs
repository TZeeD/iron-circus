// Decompiled with JetBrains decompiler
// Type: Jitter.Dynamics.ContactSettings
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

namespace Jitter.Dynamics
{
  public class ContactSettings
  {
    internal float maximumBias = 10f;
    internal float bias = 0.25f;
    internal float minVelocity = 1f / 1000f;
    internal float allowedPenetration = 0.01f;
    internal float breakThreshold = 0.01f;
    internal ContactSettings.MaterialCoefficientMixingType materialMode = ContactSettings.MaterialCoefficientMixingType.UseAverage;

    public float MaximumBias
    {
      get => this.maximumBias;
      set => this.maximumBias = value;
    }

    public float BiasFactor
    {
      get => this.bias;
      set => this.bias = value;
    }

    public float MinimumVelocity
    {
      get => this.minVelocity;
      set => this.minVelocity = value;
    }

    public float AllowedPenetration
    {
      get => this.allowedPenetration;
      set => this.allowedPenetration = value;
    }

    public float BreakThreshold
    {
      get => this.breakThreshold;
      set => this.breakThreshold = value;
    }

    public ContactSettings.MaterialCoefficientMixingType MaterialCoefficientMixing
    {
      get => this.materialMode;
      set => this.materialMode = value;
    }

    public enum MaterialCoefficientMixingType
    {
      TakeMaximum,
      TakeMinimum,
      UseAverage,
    }
  }
}
