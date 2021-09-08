// Decompiled with JetBrains decompiler
// Type: AudioTestSC
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

public class AudioTestSC : MonoBehaviour
{
  private void Update()
  {
    if (Input.GetKeyDown(KeyCode.N))
      AudioController.Play("Click", this.transform);
    if (!Input.GetKeyDown(KeyCode.M))
      return;
    AudioController.Play("Blub", this.transform);
  }
}
