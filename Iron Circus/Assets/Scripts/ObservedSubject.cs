// Decompiled with JetBrains decompiler
// Type: ObservedSubject
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SteelCircus.UI.OptionsUI;
using System.Collections.Generic;
using UnityEngine;

public abstract class ObservedSubject : MonoBehaviour
{
  private List<Observer> observers = new List<Observer>();

  public void RegisterObserver(Observer observer)
  {
    this.observers.Add(observer);
    Debug.Log((object) string.Format("Added Observer: {0} for {1}.", (object) observer, (object) this));
  }

  public void Notify(ISetting value, Settings.SettingType settingsType)
  {
    foreach (Observer observer in this.observers)
      observer.OnNotify(value, settingsType);
  }
}
