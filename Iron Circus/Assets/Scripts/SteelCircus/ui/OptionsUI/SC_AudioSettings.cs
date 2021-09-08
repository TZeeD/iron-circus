// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.OptionsUI.SC_AudioSettings
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

namespace SteelCircus.UI.OptionsUI
{
  public struct SC_AudioSettings : ISetting
  {
    public float MasterVolume;
    public float MusicVolume;
    public float SfxVolume;

    public SC_AudioSettings(float masterVolume, float musicVolume, float sfxVolume)
    {
      this.MasterVolume = masterVolume;
      this.MusicVolume = musicVolume;
      this.SfxVolume = sfxVolume;
    }
  }
}
