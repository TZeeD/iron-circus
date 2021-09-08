// Decompiled with JetBrains decompiler
// Type: SteelCircus.ScriptableObjects.uiStateConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SteelCircus.Core.Services;
using System;

namespace SteelCircus.ScriptableObjects
{
  [Serializable]
  public class uiStateConfig
  {
    public string stateName;
    public UIProgressionState uiState;
    public UIProgressionButtonState playButtonState;
    public UIProgressionButtonState quickMatchButtonState;
    public UIProgressionButtonState trainingsGroundButtonState;
    public UIProgressionButtonState botMatchButtonState;
    public UIProgressionButtonState rankedMatchButtonState;
    public UIProgressionButtonState customMatchButtonState;
    public UIProgressionButtonState freeTrainingButtonState;
  }
}
