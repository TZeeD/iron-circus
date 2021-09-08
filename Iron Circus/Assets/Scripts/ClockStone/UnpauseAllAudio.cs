// Decompiled with JetBrains decompiler
// Type: ClockStone.UnpauseAllAudio
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

namespace ClockStone
{
  public class UnpauseAllAudio : AudioTriggerBase
  {
    public UnpauseAllAudio.PauseType pauseType;
    public float fadeIn;
    public string categoryName;

    protected override void _OnEventTriggered()
    {
      switch (this.pauseType)
      {
        case UnpauseAllAudio.PauseType.All:
          AudioController.UnpauseAll(this.fadeIn);
          break;
        case UnpauseAllAudio.PauseType.MusicOnly:
          AudioController.UnpauseMusic(this.fadeIn);
          break;
        case UnpauseAllAudio.PauseType.AmbienceOnly:
          AudioController.UnpauseAmbienceSound(this.fadeIn);
          break;
        case UnpauseAllAudio.PauseType.Category:
          AudioController.UnpauseCategory(this.categoryName, this.fadeIn);
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
}
