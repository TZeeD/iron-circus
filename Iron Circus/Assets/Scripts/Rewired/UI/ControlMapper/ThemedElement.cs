// Decompiled with JetBrains decompiler
// Type: Rewired.UI.ControlMapper.ThemedElement
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using UnityEngine;

namespace Rewired.UI.ControlMapper
{
  [AddComponentMenu("")]
  public class ThemedElement : MonoBehaviour
  {
    [SerializeField]
    private ThemedElement.ElementInfo[] _elements;

    private void Start() => Rewired.UI.ControlMapper.ControlMapper.ApplyTheme(this._elements);

    [Serializable]
    public class ElementInfo
    {
      [SerializeField]
      private string _themeClass;
      [SerializeField]
      private Component _component;

      public string themeClass => this._themeClass;

      public Component component => this._component;
    }
  }
}
