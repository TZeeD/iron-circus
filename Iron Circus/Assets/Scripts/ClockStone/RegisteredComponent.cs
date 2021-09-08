// Decompiled with JetBrains decompiler
// Type: ClockStone.RegisteredComponent
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace ClockStone
{
  public abstract class RegisteredComponent : MonoBehaviour, IRegisteredComponent
  {
    private bool isRegistered;
    private bool isUnregistered;

    protected virtual void Awake()
    {
      if (!this.isRegistered)
      {
        RegisteredComponentController._Register((IRegisteredComponent) this);
        this.isRegistered = true;
        this.isUnregistered = false;
      }
      else
        Debug.LogWarning((object) ("RegisteredComponent: Awake() not correctly called. Object: " + this.name));
    }

    protected virtual void OnDestroy()
    {
      if (this.isRegistered && !this.isUnregistered)
      {
        RegisteredComponentController._Unregister((IRegisteredComponent) this);
        this.isRegistered = false;
        this.isUnregistered = true;
      }
      else
      {
        if ((this.isRegistered ? 0 : (this.isUnregistered ? 1 : 0)) != 0)
          return;
        Debug.LogWarning((object) ("RegisteredComponent: OnDestroy() not correctly called. Object: " + this.name + " isRegistered:" + this.isRegistered.ToString() + " isUnregistered:" + this.isUnregistered.ToString()));
      }
    }

    public System.Type GetRegisteredComponentBaseClassType() => typeof (RegisteredComponent);
  }
}
