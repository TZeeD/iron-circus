// Decompiled with JetBrains decompiler
// Type: LocalizedText
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using SteelCircus.Core.Services;
using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof (Text))]
public class LocalizedText : MonoBehaviour
{
  public string key;

  private void OnEnable()
  {
    Text component = this.GetComponent<Text>();
    if (!string.IsNullOrEmpty(this.key))
      component.text = ImiServices.Instance.LocaService.GetLocalizedValue(this.key);
    else
      Log.Error(string.Format("ERROR: Tried localized empty text. ({0}:{1})", (object) this.gameObject, (object) component.text));
  }
}
