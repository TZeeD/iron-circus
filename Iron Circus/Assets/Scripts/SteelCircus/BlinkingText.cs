// Decompiled with JetBrains decompiler
// Type: SteelCircus.BlinkingText
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus
{
  public class BlinkingText : MonoBehaviour
  {
    public float frequency = 1f;
    public float invisiblePercent = 0.5f;

    private void Update()
    {
      float num = (float) ((double) Time.realtimeSinceStartup * (double) this.frequency % 1.0);
      this.GetComponent<Text>().enabled = (double) num < 1.0 - (double) this.invisiblePercent;
    }
  }
}
