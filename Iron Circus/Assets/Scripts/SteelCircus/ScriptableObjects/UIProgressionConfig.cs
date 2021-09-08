// Decompiled with JetBrains decompiler
// Type: SteelCircus.ScriptableObjects.UIProgressionConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Rewired.Utils.Libraries.TinyJson;
using SteelCircus.Core.Services;
using System.Collections.Generic;
using UnityEngine;

namespace SteelCircus.ScriptableObjects
{
  [CreateAssetMenu(fileName = "UIProgressionConfig", menuName = "SteelCircus/Configs/UIProgressionConfig")]
  public class UIProgressionConfig : SingletonScriptableObject<UIProgressionConfig>
  {
    public List<uiStateConfig> uiStates;
    [DoNotSerialize]
    private Dictionary<int, UIProgressionState> uiStatesDict;

    public void SetUIStatesDict(Dictionary<int, UIProgressionState> uiStates) => this.uiStatesDict = uiStates;

    public Dictionary<int, UIProgressionState> GetUIStatesDict()
    {
      if (this.uiStatesDict == null || this.uiStatesDict.Count == 0)
        this.StoreToDict();
      return this.uiStatesDict;
    }

    public void StoreToDict()
    {
      this.uiStatesDict = new Dictionary<int, UIProgressionState>();
      foreach (uiStateConfig uiState1 in this.uiStates)
      {
        Dictionary<UIProgressionService.uiProgressionButton, UIProgressionButtonState> dictionary = new Dictionary<UIProgressionService.uiProgressionButton, UIProgressionButtonState>();
        dictionary.Add(UIProgressionService.uiProgressionButton.playButton, uiState1.playButtonState);
        dictionary.Add(UIProgressionService.uiProgressionButton.quickMatchButton, uiState1.quickMatchButtonState);
        dictionary.Add(UIProgressionService.uiProgressionButton.playingGroundButton, uiState1.trainingsGroundButtonState);
        dictionary.Add(UIProgressionService.uiProgressionButton.botMatchButton, uiState1.botMatchButtonState);
        dictionary.Add(UIProgressionService.uiProgressionButton.rankedMatchButton, uiState1.rankedMatchButtonState);
        dictionary.Add(UIProgressionService.uiProgressionButton.customMatchButton, uiState1.customMatchButtonState);
        dictionary.Add(UIProgressionService.uiProgressionButton.freeTrainingButton, uiState1.freeTrainingButtonState);
        UIProgressionState uiState2 = uiState1.uiState;
        uiState2.playMenuButtonState = dictionary;
        this.uiStatesDict.Add(uiState2.stateID, uiState2);
      }
    }
  }
}
