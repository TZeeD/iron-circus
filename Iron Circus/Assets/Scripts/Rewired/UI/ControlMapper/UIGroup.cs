// Decompiled with JetBrains decompiler
// Type: Rewired.UI.ControlMapper.UIGroup
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.UI;

namespace Rewired.UI.ControlMapper
{
  [AddComponentMenu("")]
  public class UIGroup : MonoBehaviour
  {
    [SerializeField]
    private Text _label;
    [SerializeField]
    private Transform _content;

    public string labelText
    {
      get => !((Object) this._label != (Object) null) ? string.Empty : this._label.text;
      set
      {
        if ((Object) this._label == (Object) null)
          return;
        this._label.text = value;
      }
    }

    public Transform content => this._content;

    public void SetLabelActive(bool state)
    {
      if ((Object) this._label == (Object) null)
        return;
      this._label.gameObject.SetActive(state);
    }
  }
}
