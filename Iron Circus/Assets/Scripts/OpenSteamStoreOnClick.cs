// Decompiled with JetBrains decompiler
// Type: OpenSteamStoreOnClick
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Steamworks;
using UnityEngine;

public class OpenSteamStoreOnClick : MonoBehaviour
{
  public void OnButtonClicked(int appId)
  {
    if (!SteamManager.Initialized)
      return;
    Log.Debug("Opening Steam overlay to shop. AppId: " + (object) appId);
    SteamFriends.ActivateGameOverlayToStore(new AppId_t((uint) appId), EOverlayToStoreFlag.k_EOverlayToStoreFlag_None);
  }
}
