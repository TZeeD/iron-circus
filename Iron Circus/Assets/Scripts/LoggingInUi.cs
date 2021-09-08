// Decompiled with JetBrains decompiler
// Type: LoggingInUi
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using TMPro;
using UnityEngine;

public class LoggingInUi : MonoBehaviour
{
  [SerializeField]
  private TextMeshProUGUI loadingTxt;
  [SerializeField]
  private TextMeshProUGUI infoTxt;
  private string[] textAnim;

  private void Start()
  {
  }

  private void Update()
  {
  }

  public void SetLoadingText(string text)
  {
    this.textAnim = new string[3];
    for (int index = 0; index < 3; ++index)
    {
      string str = new string('.', index + 1);
      this.textAnim[index] = text + str;
    }
    this.loadingTxt.text = text;
  }
}
