// Decompiled with JetBrains decompiler
// Type: ClockStone.AudioControllerHelper
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace ClockStone
{
  public static class AudioControllerHelper
  {
    public static AudioSubItem[] _ChooseSubItems(
      AudioItem audioItem,
      AudioObject useExistingAudioObj)
    {
      return AudioControllerHelper._ChooseSubItems(audioItem, audioItem.SubItemPickMode, useExistingAudioObj);
    }

    public static AudioSubItem _ChooseSingleSubItem(
      AudioItem audioItem,
      AudioPickSubItemMode pickMode,
      AudioObject useExistingAudioObj)
    {
      return AudioControllerHelper._ChooseSubItems(audioItem, pickMode, useExistingAudioObj)[0];
    }

    public static AudioSubItem _ChooseSingleSubItem(AudioItem audioItem) => AudioControllerHelper._ChooseSingleSubItem(audioItem, audioItem.SubItemPickMode, (AudioObject) null);

    private static AudioSubItem[] _ChooseSubItems(
      AudioItem audioItem,
      AudioPickSubItemMode pickMode,
      AudioObject useExistingAudioObj)
    {
      if (audioItem.subItems == null)
        return (AudioSubItem[]) null;
      int length = audioItem.subItems.Length;
      if (length == 0)
        return (AudioSubItem[]) null;
      int index1 = 0;
      bool flag = useExistingAudioObj != null;
      int lastChosen = !flag ? audioItem._lastChosen : useExistingAudioObj._lastChosenSubItemIndex;
      if (length > 1)
      {
        switch (pickMode)
        {
          case AudioPickSubItemMode.Disabled:
            return (AudioSubItem[]) null;
          case AudioPickSubItemMode.Random:
            index1 = AudioControllerHelper._ChooseRandomSubitem(audioItem, true, lastChosen);
            break;
          case AudioPickSubItemMode.RandomNotSameTwice:
            index1 = AudioControllerHelper._ChooseRandomSubitem(audioItem, false, lastChosen);
            break;
          case AudioPickSubItemMode.Sequence:
            index1 = (lastChosen + 1) % length;
            break;
          case AudioPickSubItemMode.SequenceWithRandomStart:
            index1 = lastChosen != -1 ? (lastChosen + 1) % length : Random.Range(0, length);
            break;
          case AudioPickSubItemMode.AllSimultaneously:
            AudioSubItem[] audioSubItemArray = new AudioSubItem[length];
            for (int index2 = 0; index2 < length; ++index2)
              audioSubItemArray[index2] = audioItem.subItems[index2];
            return audioSubItemArray;
          case AudioPickSubItemMode.TwoSimultaneously:
            return new AudioSubItem[2]
            {
              AudioControllerHelper._ChooseSingleSubItem(audioItem, AudioPickSubItemMode.RandomNotSameTwice, useExistingAudioObj),
              AudioControllerHelper._ChooseSingleSubItem(audioItem, AudioPickSubItemMode.RandomNotSameTwice, useExistingAudioObj)
            };
          case AudioPickSubItemMode.StartLoopSequenceWithFirst:
            index1 = !flag ? 0 : (lastChosen + 1) % length;
            break;
          case AudioPickSubItemMode.RandomNotSameTwiceOddsEvens:
            index1 = AudioControllerHelper._ChooseRandomSubitem(audioItem, false, lastChosen, true);
            break;
        }
      }
      if (flag)
        useExistingAudioObj._lastChosenSubItemIndex = index1;
      else
        audioItem._lastChosen = index1;
      return new AudioSubItem[1]
      {
        audioItem.subItems[index1]
      };
    }

    private static int _ChooseRandomSubitem(
      AudioItem audioItem,
      bool allowSameElementTwiceInRow,
      int lastChosen,
      bool switchOddsEvens = false)
    {
      int length = audioItem.subItems.Length;
      int num1 = 0;
      float num2 = 0.0f;
      float max;
      if (!allowSameElementTwiceInRow)
      {
        if (lastChosen >= 0)
        {
          num2 = audioItem.subItems[lastChosen]._SummedProbability;
          if (lastChosen >= 1)
            num2 -= audioItem.subItems[lastChosen - 1]._SummedProbability;
        }
        else
          num2 = 0.0f;
        max = 1f - num2;
      }
      else
        max = 1f;
      float num3 = Random.Range(0.0f, max);
      int i;
      for (i = 0; i < length - 1; ++i)
      {
        float summedProbability = audioItem.subItems[i]._SummedProbability;
        if (!switchOddsEvens || AudioControllerHelper.isOdd(i) != AudioControllerHelper.isOdd(lastChosen))
        {
          if (!allowSameElementTwiceInRow)
          {
            if (i != lastChosen || (double) summedProbability == 1.0 && audioItem.subItems[i].DisableOtherSubitems)
            {
              if (i > lastChosen)
                summedProbability -= num2;
            }
            else
              continue;
          }
          if ((double) summedProbability > (double) num3)
          {
            num1 = i;
            break;
          }
        }
      }
      if (i == length - 1)
        num1 = length - 1;
      return num1;
    }

    private static bool isOdd(int i) => (uint) (i % 2) > 0U;
  }
}
