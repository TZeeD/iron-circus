// Decompiled with JetBrains decompiler
// Type: DebugDropdownDisabler
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

public class DebugDropdownDisabler : MonoBehaviour
{
  private void OnEnable()
  {
    for (int index = 0; index < this.transform.childCount; ++index)
      this.transform.GetChild(index).gameObject.SetActive(false);
  }

  private void OnDisable()
  {
    for (int index = 0; index < this.transform.childCount; ++index)
      this.transform.GetChild(index).gameObject.SetActive(false);
  }
}
