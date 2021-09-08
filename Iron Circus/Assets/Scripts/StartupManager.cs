// Decompiled with JetBrains decompiler
// Type: StartupManager
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SteelCircus.Core.Services;
using System.Collections;
using UnityEngine;
using UnityEngine.SceneManagement;

public class StartupManager : MonoBehaviour
{
  private IEnumerator Start()
  {
    while (!ImiServices.Instance.LocaService.GetIsReady())
      yield return (object) null;
    SceneManager.LoadScene("MenuScreen");
  }
}
