// Decompiled with JetBrains decompiler
// Type: Rewired.Demos.ControlMapperDemoMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Collections;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Rewired.Demos
{
  [AddComponentMenu("")]
  public class ControlMapperDemoMessage : MonoBehaviour
  {
    public Rewired.UI.ControlMapper.ControlMapper controlMapper;
    public Selectable defaultSelectable;

    private void Awake()
    {
      if (!((UnityEngine.Object) this.controlMapper != (UnityEngine.Object) null))
        return;
      this.controlMapper.ScreenClosedEvent += new Action(this.OnControlMapperClosed);
      this.controlMapper.ScreenOpenedEvent += new Action(this.OnControlMapperOpened);
    }

    private void Start() => this.SelectDefault();

    private void OnControlMapperClosed()
    {
      this.gameObject.SetActive(true);
      this.StartCoroutine(this.SelectDefaultDeferred());
    }

    private void OnControlMapperOpened() => this.gameObject.SetActive(false);

    private void SelectDefault()
    {
      if ((UnityEngine.Object) EventSystem.current == (UnityEngine.Object) null || !((UnityEngine.Object) this.defaultSelectable != (UnityEngine.Object) null))
        return;
      EventSystem.current.SetSelectedGameObject(this.defaultSelectable.gameObject);
    }

    private IEnumerator SelectDefaultDeferred()
    {
      yield return (object) null;
      this.SelectDefault();
    }
  }
}
