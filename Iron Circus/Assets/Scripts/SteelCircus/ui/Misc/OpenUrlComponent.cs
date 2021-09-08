// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.Misc.OpenUrlComponent
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace SteelCircus.UI.Misc
{
  public class OpenUrlComponent : MonoBehaviour
  {
    public void OpenUrl(string url) => Application.OpenURL(url);
  }
}
