// Decompiled with JetBrains decompiler
// Type: PauseAllAudio
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

public class PauseAllAudio : AudioTriggerBase
{
  public PauseAllAudio.PauseType pauseType;
  public float fadeOut;
  public string categoryName;

  protected override void _OnEventTriggered()
  {
    switch (this.pauseType)
    {
      case PauseAllAudio.PauseType.All:
        AudioController.PauseAll(this.fadeOut);
        break;
      case PauseAllAudio.PauseType.MusicOnly:
        AudioController.PauseMusic(this.fadeOut);
        break;
      case PauseAllAudio.PauseType.AmbienceOnly:
        AudioController.PauseAmbienceSound(this.fadeOut);
        break;
      case PauseAllAudio.PauseType.Category:
        AudioController.PauseCategory(this.categoryName, this.fadeOut);
        break;
    }
  }

  public enum PauseType
  {
    All,
    MusicOnly,
    AmbienceOnly,
    Category,
  }
}
