// Decompiled with JetBrains decompiler
// Type: AudioToolkitDemo
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using ClockStone;
using System.Collections.Generic;
using UnityEngine;

public class AudioToolkitDemo : MonoBehaviour
{
  public AudioClip customAudioClip;
  private float musicVolume = 1f;
  private float ambienceVolume = 1f;
  private bool musicPaused;
  private Vector2 playlistScrollPos = Vector2.zero;
  private PoolableReference<AudioObject> introLoopOutroAudio;
  private bool wasClipAdded;
  private bool wasCategoryAdded;
  private List<bool> disableGUILevels = new List<bool>();

  private void OnGUI()
  {
    this.DrawGuiLeftSide();
    this.DrawGuiRightSide();
    this.DrawGuiBottom();
  }

  private void DrawGuiLeftSide()
  {
    GUI.Label(new Rect(22f, 10f, 500f, 20f), string.Format("ClockStone Audio Toolkit - Demo"), new GUIStyle(GUI.skin.label)
    {
      normal = {
        textColor = new Color(1f, 1f, 0.5f)
      }
    });
    int num1 = 10;
    int num2 = 35;
    int num3 = 200;
    int num4 = 130;
    int num5 = num1 + 30;
    if (!(bool) (Object) SingletonMonoBehaviour<AudioController>.DoesInstanceExist())
    {
      GUI.Label(new Rect(250f, (float) num5, (float) num3, 30f), "No Audio Controller found!");
    }
    else
    {
      GUI.Label(new Rect(250f, (float) num5, (float) num3, 30f), "Global Volume");
      AudioController.SetGlobalVolume(GUI.HorizontalSlider(new Rect(250f, (float) (num5 + 20), (float) num4, 30f), AudioController.GetGlobalVolume(), 0.0f, 1f));
      if (GUI.Button(new Rect(20f, (float) num5, (float) num3, 30f), "Cross-fade to music track 1"))
        AudioController.PlayMusic("MusicTrack1");
      int num6 = num5 + num2;
      GUI.Label(new Rect(250f, (float) (num6 + 10), (float) num3, 30f), "Music Volume");
      float num7 = GUI.HorizontalSlider(new Rect(250f, (float) (num6 + 30), (float) num4, 30f), this.musicVolume, 0.0f, 1f);
      if ((double) num7 != (double) this.musicVolume)
      {
        this.musicVolume = num7;
        AudioController.SetCategoryVolume("Music", this.musicVolume);
      }
      GUI.Label(new Rect((float) (250 + num4 + 30), (float) (num6 + 10), (float) num3, 30f), "Ambience Volume");
      float num8 = GUI.HorizontalSlider(new Rect((float) (250 + num4 + 30), (float) (num6 + 30), (float) num4, 30f), this.ambienceVolume, 0.0f, 1f);
      if ((double) num8 != (double) this.ambienceVolume)
      {
        this.ambienceVolume = num8;
        AudioController.SetCategoryVolume("Ambience", this.ambienceVolume);
      }
      if (GUI.Button(new Rect(20f, (float) num6, (float) num3, 30f), "Cross-fade to music track 2"))
        AudioController.PlayMusic("MusicTrack2");
      int num9 = num6 + num2;
      if (GUI.Button(new Rect(20f, (float) num9, (float) num3, 30f), "Fade out music category"))
        AudioController.FadeOutCategory("Music", 2f);
      int num10 = num9 + num2;
      if (GUI.Button(new Rect(20f, (float) num10, (float) num3, 30f), "Fade in music category"))
        AudioController.FadeInCategory("Music", 2f);
      int num11 = num10 + num2;
      if (GUI.Button(new Rect(20f, (float) num11, (float) num3, 30f), "Stop Music"))
        AudioController.StopMusic(0.3f);
      int num12 = num11 + num2;
      bool flag = GUI.Toggle(new Rect(20f, (float) num12, (float) num3, 30f), this.musicPaused, "Pause All Audio");
      if (flag != this.musicPaused)
      {
        this.musicPaused = flag;
        if (this.musicPaused)
          AudioController.PauseAll(0.1f);
        else
          AudioController.UnpauseAll(0.1f);
      }
      int num13 = num12 + 20;
      if (GUI.Button(new Rect(20f, (float) num13, (float) num3, 30f), "Play Sound with random pitch"))
        AudioController.Play("RandomPitchSound");
      int num14 = num13 + num2;
      if (GUI.Button(new Rect(20f, (float) num14, (float) num3, 30f), "Play Sound with alternatives"))
      {
        AudioObject audioObject = AudioController.Play("AlternativeSound");
        if ((Object) audioObject != (Object) null)
          audioObject.completelyPlayedDelegate = new AudioObject.AudioEventDelegate(this.OnAudioCompleteleyPlayed);
      }
      int num15 = num14 + num2;
      if (GUI.Button(new Rect(20f, (float) num15, (float) num3, 30f), "Play Both"))
      {
        AudioObject audioObject = AudioController.Play("RandomAndAlternativeSound");
        if ((Object) audioObject != (Object) null)
          audioObject.completelyPlayedDelegate = new AudioObject.AudioEventDelegate(this.OnAudioCompleteleyPlayed);
      }
      int num16 = num15 + num2;
      GUI.Label(new Rect(20f, (float) num16, 100f, 20f), "Playlists: ");
      int num17 = num16 + 20;
      this.playlistScrollPos = GUI.BeginScrollView(new Rect(20f, (float) num17, (float) num3, 100f), this.playlistScrollPos, new Rect(0.0f, 0.0f, (float) num3, 33f * (float) SingletonMonoBehaviour<AudioController>.Instance.musicPlaylists.Length));
      for (int index = 0; index < SingletonMonoBehaviour<AudioController>.Instance.musicPlaylists.Length; ++index)
      {
        if (GUI.Button(new Rect(20f, (float) index * 33f, (float) (num3 - 20), 30f), SingletonMonoBehaviour<AudioController>.Instance.musicPlaylists[index].name))
          AudioController.SetCurrentMusicPlaylist(SingletonMonoBehaviour<AudioController>.Instance.musicPlaylists[index].name);
      }
      int num18 = num17 + 105;
      GUI.EndScrollView();
      if (GUI.Button(new Rect(20f, (float) num18, (float) num3, 30f), "Play Music Playlist"))
        AudioController.PlayMusicPlaylist();
      int num19 = num18 + num2;
      if (AudioController.IsPlaylistPlaying() && GUI.Button(new Rect(20f, (float) num19, (float) num3, 30f), "Next Track on Playlist"))
        AudioController.PlayNextMusicOnPlaylist();
      int num20 = num19 + 32;
      if (AudioController.IsPlaylistPlaying() && GUI.Button(new Rect(20f, (float) num20, (float) num3, 30f), "Previous Track on Playlist"))
        AudioController.PlayPreviousMusicOnPlaylist();
      int num21 = num20 + num2;
      SingletonMonoBehaviour<AudioController>.Instance.loopPlaylist = GUI.Toggle(new Rect(20f, (float) num21, (float) num3, 30f), SingletonMonoBehaviour<AudioController>.Instance.loopPlaylist, "Loop Playlist");
      int num22 = num21 + 20;
      SingletonMonoBehaviour<AudioController>.Instance.shufflePlaylist = GUI.Toggle(new Rect(20f, (float) num22, (float) num3, 30f), SingletonMonoBehaviour<AudioController>.Instance.shufflePlaylist, "Shuffle Playlist ");
      SingletonMonoBehaviour<AudioController>.Instance.soundMuted = GUI.Toggle(new Rect(20f, (float) (num22 + 20), (float) num3, 30f), SingletonMonoBehaviour<AudioController>.Instance.soundMuted, "Sound Muted");
    }
  }

  private void DrawGuiRightSide()
  {
    int num1 = 50;
    int num2 = 35;
    int num3 = 300;
    if (!this.wasCategoryAdded)
    {
      if ((Object) this.customAudioClip != (Object) null && GUI.Button(new Rect((float) (Screen.width - (num3 + 20)), (float) num1, (float) num3, 30f), "Create new category with custom AudioClip"))
      {
        AudioController.AddToCategory(AudioController.NewCategory("Custom Category"), this.customAudioClip, "CustomAudioItem");
        this.wasClipAdded = true;
        this.wasCategoryAdded = true;
      }
    }
    else
    {
      if (GUI.Button(new Rect((float) (Screen.width - (num3 + 20)), (float) num1, (float) num3, 30f), "Play custom AudioClip"))
        AudioController.Play("CustomAudioItem");
      if (this.wasClipAdded)
      {
        int num4 = num1 + num2;
        if (GUI.Button(new Rect((float) (Screen.width - (num3 + 20)), (float) num4, (float) num3, 30f), "Remove custom AudioClip") && AudioController.RemoveAudioItem("CustomAudioItem"))
          this.wasClipAdded = false;
      }
    }
    int num5 = 130;
    if (GUI.Button(new Rect((float) (Screen.width - (num3 + 20)), (float) num5, (float) num3, 30f), "Play gapless audio loop"))
    {
      AudioObject audioObject = AudioController.Play("GaplessLoopTest");
      if ((bool) (Object) audioObject)
        audioObject.Stop(1f, 4f);
    }
    int num6 = num5 + num2;
    if (GUI.Button(new Rect((float) (Screen.width - (num3 + 20)), (float) num6, (float) num3, 30f), "Play random loop sequence"))
      AudioController.Play("RandomLoopSequence");
    int num7 = num6 + num2;
    if (GUI.Button(new Rect((float) (Screen.width - (num3 + 20)), (float) num7, (float) num3, 50f), "Play intro-loop-outro sequence\ngatling gun"))
      this.introLoopOutroAudio = new PoolableReference<AudioObject>(AudioController.Play("IntroLoopOutro_Gun"));
    int num8 = num7 + 20 + num2;
    this.BeginDisabledGroup(this.introLoopOutroAudio == null || !((Object) this.introLoopOutroAudio.Get() != (Object) null));
    if (GUI.Button(new Rect((float) (Screen.width - (num3 + 20)), (float) num8, (float) num3, 30f), "Finish gatling gun sequence"))
      this.introLoopOutroAudio.Get().FinishSequence();
    this.EndDisabledGroup();
  }

  private void DrawGuiBottom()
  {
    if (!GUI.Button(new Rect((float) (Screen.width / 2 - 150), (float) (Screen.height - 40), 300f, 30f), "Video tutorial & more info..."))
      return;
    Application.OpenURL("http://unity.clockstone.com");
  }

  private void OnAudioCompleteleyPlayed(AudioObject audioObj) => Debug.Log((object) ("Finished playing " + audioObj.audioID + " with clip " + audioObj.primaryAudioSource.clip.name));

  private void BeginDisabledGroup(bool condition)
  {
    this.disableGUILevels.Add(condition);
    GUI.enabled = !this.IsGUIDisabled();
  }

  private void EndDisabledGroup()
  {
    int count = this.disableGUILevels.Count;
    if (count > 0)
    {
      this.disableGUILevels.RemoveAt(count - 1);
      GUI.enabled = !this.IsGUIDisabled();
    }
    else
      Debug.LogWarning((object) "misplaced EndDisabledGroup");
  }

  private bool IsGUIDisabled()
  {
    foreach (bool disableGuiLevel in this.disableGUILevels)
    {
      if (disableGuiLevel)
        return true;
    }
    return false;
  }
}
