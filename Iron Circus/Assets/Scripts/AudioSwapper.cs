// Decompiled with JetBrains decompiler
// Type: AudioSwapper
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using ClockStone;
using UnityEngine;

public class AudioSwapper : MonoBehaviour
{
  public string[] audioItemStrings;
  private AudioItem[] items;
  private int subItemToSet;

  private void Start() => Debug.LogWarning((object) "AUDIO - only temporary component for testing purposes! remove later!");

  private void Update()
  {
    if (Input.GetKeyDown("0"))
    {
      this.items = new AudioItem[this.audioItemStrings.Length];
      for (int num = 0; num < Mathf.Min(9, this.audioItemStrings.Length); ++num)
      {
        if (AudioController.GetAudioItem(this.audioItemStrings[num]) != null)
        {
          Debug.Log((object) ("<color=#00ff00ff>[audioitemid: " + AudioController.GetAudioItem(this.audioItemStrings[num]).Name + "]</color>"));
          this.items[num] = AudioController.GetAudioItem(this.audioItemStrings[num]);
          this.SetVolumesInAudioItem(num);
        }
      }
    }
    for (int index = 0; index <= 9; ++index)
    {
      if (!Input.GetKeyDown("0") && Input.GetKeyDown(index.ToString()) && this.items.Length >= index)
        this.SetVolumesInAudioItem(index - 1);
    }
  }

  private void SetVolumesInAudioItem(int num)
  {
    AudioSubItem[] subItems = this.items[num].subItems;
    for (int index = 0; index < subItems.Length; ++index)
    {
      if ((double) subItems[index].Volume > 0.0)
        this.subItemToSet = (index + 1) % subItems.Length;
      subItems[index].Volume = 0.0f;
    }
    Debug.Log((object) ("<color=#00ff00ff>[setting " + subItems[this.subItemToSet].ToString() + "active]</color>"));
    subItems[this.subItemToSet].Volume = 1f;
    this.subItemToSet = 0;
  }
}
