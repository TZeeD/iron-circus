// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Components.SkillUiComponent
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Collections.Generic;

namespace Imi.SharedWithServer.ScEntitas.Components
{
  [Game]
  public class SkillUiComponent : ImiComponent
  {
    public List<SkillUiStateData> skillUiStates = new List<SkillUiStateData>();
    public bool show;

    public void AddReplaceState(SkillUiStateData newState)
    {
      for (int index = 0; index < this.skillUiStates.Count; ++index)
      {
        if (this.skillUiStates[index].skillIdx == newState.skillIdx)
        {
          this.skillUiStates[index] = newState;
          return;
        }
      }
      this.skillUiStates.Add(newState);
    }

    public void RemoveState(int skillIdx)
    {
      int index1 = -1;
      for (int index2 = 0; index2 < this.skillUiStates.Count; ++index2)
      {
        if (this.skillUiStates[index2].skillIdx == skillIdx)
        {
          index1 = index2;
          break;
        }
      }
      if (index1 == -1)
        return;
      this.skillUiStates.RemoveAt(index1);
    }

    public bool HasStateData(ButtonType buttonType)
    {
      for (int index = 0; index < this.skillUiStates.Count; ++index)
      {
        if (this.skillUiStates[index].buttonType == buttonType)
          return true;
      }
      return false;
    }

    public SkillUiStateData GetStateData(ButtonType buttonType)
    {
      for (int index = 0; index < this.skillUiStates.Count; ++index)
      {
        if (this.skillUiStates[index].buttonType == buttonType)
          return this.skillUiStates[index];
      }
      throw new Exception(string.Format("No data for button type {0}", (object) buttonType));
    }
  }
}
