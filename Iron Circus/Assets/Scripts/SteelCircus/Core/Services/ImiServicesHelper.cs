// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.Services.ImiServicesHelper
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using UnityEngine;

namespace SteelCircus.Core.Services
{
  [DefaultExecutionOrder(1000)]
  public class ImiServicesHelper : MonoBehaviour
  {
    public event Action StartEvent = () => { };

    public event Action EnableEvent = () => { };

    public event Action UpdateEvent = () => { };

    public event Action DisableEvent = () => { };

    public event Action DestroyEvent = () => { };

    public event Action ApplicationQuitEvent = () => { };

    public void DontDestroyOnLoad() => UnityEngine.Object.DontDestroyOnLoad((UnityEngine.Object) this);

    private void Start() => this.StartEvent();

    private void OnEnable() => this.EnableEvent();

    private void Update() => this.UpdateEvent();

    private void OnDisable() => this.DisableEvent();

    private void OnDestroy() => this.DestroyEvent();

    private void OnApplicationQuit() => this.ApplicationQuitEvent();
  }
}
