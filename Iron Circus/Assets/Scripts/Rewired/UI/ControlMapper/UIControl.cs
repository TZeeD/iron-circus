// Decompiled with JetBrains decompiler
// Type: Rewired.UI.ControlMapper.UIControl
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using UnityEngine;
using UnityEngine.UI;

namespace Rewired.UI.ControlMapper
{
  [AddComponentMenu("")]
  public class UIControl : MonoBehaviour
  {
    public Text title;
    private int _id;
    private bool _showTitle;
    private static int _uidCounter;

    public int id => this._id;

    private void Awake() => this._id = UIControl.GetNextUid();

    public bool showTitle
    {
      get => this._showTitle;
      set
      {
        if ((UnityEngine.Object) this.title == (UnityEngine.Object) null)
          return;
        this.title.gameObject.SetActive(value);
        this._showTitle = value;
      }
    }

    public virtual void SetCancelCallback(Action cancelCallback)
    {
    }

    private static int GetNextUid()
    {
      if (UIControl._uidCounter == int.MaxValue)
        UIControl._uidCounter = 0;
      int uidCounter = UIControl._uidCounter;
      ++UIControl._uidCounter;
      return uidCounter;
    }
  }
}
