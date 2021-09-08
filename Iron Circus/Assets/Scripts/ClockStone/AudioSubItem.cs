// Decompiled with JetBrains decompiler
// Type: ClockStone.AudioSubItem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Collections.Generic;
using UnityEngine;

namespace ClockStone
{
  [Serializable]
  public class AudioSubItem
  {
    public AudioSubItemType SubItemType;
    public float Probability = 1f;
    public bool DisableOtherSubitems;
    public string ItemModeAudioID;
    public AudioClip Clip;
    public float Volume = 1f;
    public float PitchShift;
    public float Pan2D;
    public float Delay;
    public float RandomPitch;
    public float RandomVolume;
    public float RandomDelay;
    public float ClipStopTime;
    public float ClipStartTime;
    public float FadeIn;
    public float FadeOut;
    public bool RandomStartPosition;
    public List<string> individualSettings = new List<string>();
    private float _summedProbability = -1f;
    internal int _subItemID;
    [NonSerialized]
    private AudioItem _item;

    public AudioSubItem()
    {
    }

    public AudioSubItem(AudioSubItem orig, AudioItem item)
    {
      this.SubItemType = orig.SubItemType;
      if (this.SubItemType == AudioSubItemType.Clip)
        this.Clip = orig.Clip;
      else if (this.SubItemType == AudioSubItemType.Item)
        this.ItemModeAudioID = orig.ItemModeAudioID;
      this.Probability = orig.Probability;
      this.DisableOtherSubitems = orig.DisableOtherSubitems;
      this.Clip = orig.Clip;
      this.Volume = orig.Volume;
      this.PitchShift = orig.PitchShift;
      this.Pan2D = orig.Pan2D;
      this.Delay = orig.Delay;
      this.RandomPitch = orig.RandomPitch;
      this.RandomVolume = orig.RandomVolume;
      this.RandomDelay = orig.RandomDelay;
      this.ClipStopTime = orig.ClipStopTime;
      this.ClipStartTime = orig.ClipStartTime;
      this.FadeIn = orig.FadeIn;
      this.FadeOut = orig.FadeOut;
      this.RandomStartPosition = orig.RandomStartPosition;
      for (int index = 0; index < orig.individualSettings.Count; ++index)
        this.individualSettings.Add(orig.individualSettings[index]);
      this.item = item;
    }

    internal float _SummedProbability
    {
      get => this._summedProbability;
      set => this._summedProbability = value;
    }

    public AudioItem item
    {
      internal set => this._item = value;
      get => this._item;
    }

    public override string ToString() => this.SubItemType == AudioSubItemType.Clip ? "CLIP: " + this.Clip.name : "ITEM: " + this.ItemModeAudioID;
  }
}
