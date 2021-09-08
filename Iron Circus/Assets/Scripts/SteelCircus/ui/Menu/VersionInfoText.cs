// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.Menu.VersionInfoText
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI.Menu
{
  [RequireComponent(typeof (Text))]
  public class VersionInfoText : MonoBehaviour
  {
    private void Start() => this.GetComponent<Text>().text = "20191126-216_live_Update_0.8";
  }
}
