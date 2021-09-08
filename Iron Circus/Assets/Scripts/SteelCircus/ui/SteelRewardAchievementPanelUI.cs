// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.SteelRewardAchievementPanelUI
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using TMPro;
using UnityEngine;

namespace SteelCircus.UI
{
  public class SteelRewardAchievementPanelUI : MonoBehaviour
  {
    [SerializeField]
    private TextMeshProUGUI achievementNameText;
    [SerializeField]
    private TextMeshProUGUI achievementSteelText;

    public GameObject StyleAchievementPanel(string achievementName, int achievementSteel)
    {
      this.achievementNameText.text = achievementName;
      this.achievementSteelText.text = achievementSteel.ToString();
      return this.gameObject;
    }
  }
}
