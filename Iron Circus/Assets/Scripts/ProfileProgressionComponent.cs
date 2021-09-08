// Decompiled with JetBrains decompiler
// Type: ProfileProgressionComponent
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SteelCircus.UI.Network;
using Newtonsoft.Json.Linq;
using System;
using UnityEngine;
using UnityEngine.UI;

public class ProfileProgressionComponent : MonoBehaviour
{
  [SerializeField]
  private Text txt;

  private void OnEnable()
  {
    Log.Debug("ProfileProgressionComponent On Enable");
    this.StartCoroutine(MetaServiceHelpers.GetPlayerProgress(1UL, new Action<ulong, JObject>(this.OnSuccess)));
  }

  private void OnSuccess(ulong playerId, JObject obj)
  {
    Log.Debug("ProfileProgressionComponent OnSuccess");
    this.txt.text = obj["experienceAccum"].ToString();
  }
}
