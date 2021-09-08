// Decompiled with JetBrains decompiler
// Type: UnityMainThreadDispatcher
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Collections;
using System.Collections.Concurrent;
using UnityEngine;

public class UnityMainThreadDispatcher : MonoBehaviour
{
  private static UnityMainThreadDispatcher _instance = (UnityMainThreadDispatcher) null;
  private static readonly ConcurrentQueue<Action> _executionQueue = new ConcurrentQueue<Action>();

  public void Update()
  {
    while (UnityMainThreadDispatcher._executionQueue.Count > 0)
    {
      Action result;
      if (UnityMainThreadDispatcher._executionQueue.TryDequeue(out result))
        result();
    }
  }

  public void Enqueue(IEnumerator action) => UnityMainThreadDispatcher._executionQueue.Enqueue((Action) (() => this.StartCoroutine(action)));

  public void Enqueue(Action action) => this.Enqueue(this.ActionWrapper(action));

  private IEnumerator ActionWrapper(Action a)
  {
    a();
    yield return (object) null;
  }

  public static bool Exists() => (UnityEngine.Object) UnityMainThreadDispatcher._instance != (UnityEngine.Object) null;

  public static UnityMainThreadDispatcher Instance()
  {
    if (!UnityMainThreadDispatcher.Exists())
      throw new Exception("UnityMainThreadDispatcher could not find the UnityMainThreadDispatcher object. Please ensure you have added the MainThreadExecutor Prefab to your scene.");
    return UnityMainThreadDispatcher._instance;
  }

  private void Awake()
  {
    if (!((UnityEngine.Object) UnityMainThreadDispatcher._instance == (UnityEngine.Object) null))
      return;
    UnityMainThreadDispatcher._instance = this;
    UnityEngine.Object.DontDestroyOnLoad((UnityEngine.Object) this.gameObject);
  }

  private void OnDestroy() => UnityMainThreadDispatcher._instance = (UnityMainThreadDispatcher) null;
}
