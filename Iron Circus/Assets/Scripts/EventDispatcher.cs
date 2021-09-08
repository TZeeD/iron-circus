// Decompiled with JetBrains decompiler
// Type: EventDispatcher
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Collections.Generic;
using UnityEngine;

public class EventDispatcher : MonoBehaviour
{
  private static EventDispatcher s_instance;
  private Dictionary<EventID, Action<object>> _listeners = new Dictionary<EventID, Action<object>>();

  public static EventDispatcher Instance
  {
    get
    {
      if ((UnityEngine.Object) EventDispatcher.s_instance == (UnityEngine.Object) null)
      {
        GameObject gameObject = new GameObject();
        EventDispatcher.s_instance = gameObject.AddComponent<EventDispatcher>();
        gameObject.name = "Singleton - EventDispatcher";
      }
      return EventDispatcher.s_instance;
    }
    private set
    {
    }
  }

  public static bool HasInstance() => (UnityEngine.Object) EventDispatcher.s_instance != (UnityEngine.Object) null;

  private void Awake()
  {
    if ((UnityEngine.Object) EventDispatcher.s_instance != (UnityEngine.Object) null && EventDispatcher.s_instance.GetInstanceID() != this.GetInstanceID())
      UnityEngine.Object.Destroy((UnityEngine.Object) this.gameObject);
    else
      EventDispatcher.s_instance = this;
  }

  private void OnDestroy()
  {
    if (!((UnityEngine.Object) EventDispatcher.s_instance == (UnityEngine.Object) this))
      return;
    this.ClearAllListener();
    EventDispatcher.s_instance = (EventDispatcher) null;
  }

  public void RegisterListener(EventID eventID, Action<object> callback)
  {
    if (this._listeners.ContainsKey(eventID))
    {
      this._listeners[eventID] += callback;
    }
    else
    {
      this._listeners.Add(eventID, (Action<object>) null);
      this._listeners[eventID] += callback;
    }
  }

  public void PostEvent(EventID eventID, object param = null)
  {
    if (!this._listeners.ContainsKey(eventID))
    {
      Debug.Log((object) ("No listeners for this event : {0}-->" + (object) eventID));
    }
    else
    {
      Action<object> listener = this._listeners[eventID];
      if (listener != null)
      {
        listener(param);
      }
      else
      {
        Debug.Log((object) ("PostEvent {0}, but no listener remain, Remove this key" + (object) eventID));
        this._listeners.Remove(eventID);
      }
    }
  }

  public void RemoveListener(EventID eventID, Action<object> callback)
  {
    if (!this._listeners.ContainsKey(eventID))
      return;
    this._listeners[eventID] -= callback;
  }

  public void ClearAllListener() => this._listeners.Clear();
}
