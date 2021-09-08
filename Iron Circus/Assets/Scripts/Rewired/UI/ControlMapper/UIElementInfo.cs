// Decompiled with JetBrains decompiler
// Type: Rewired.UI.ControlMapper.UIElementInfo
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Rewired.UI.ControlMapper
{
  [AddComponentMenu("")]
  public abstract class UIElementInfo : MonoBehaviour, ISelectHandler, IEventSystemHandler
  {
    public string identifier;
    public int intData;
    public Text text;

    public event Action<GameObject> OnSelectedEvent;

    public void OnSelect(BaseEventData eventData)
    {
      if (this.OnSelectedEvent == null)
        return;
      this.OnSelectedEvent(this.gameObject);
    }
  }
}
