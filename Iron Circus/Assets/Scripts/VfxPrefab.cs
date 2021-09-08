// Decompiled with JetBrains decompiler
// Type: VfxPrefab
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Newtonsoft.Json;
using System;
using UnityEngine;

[Serializable]
public struct VfxPrefab
{
  [JsonIgnore]
  public GameObject value;

  public VfxPrefab(GameObject unityPrefab) => this.value = unityPrefab;

  public bool HasValue => (UnityEngine.Object) this.value != (UnityEngine.Object) null;
}
