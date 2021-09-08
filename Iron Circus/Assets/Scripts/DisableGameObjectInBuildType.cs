// Decompiled with JetBrains decompiler
// Type: DisableGameObjectInBuildType
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

public class DisableGameObjectInBuildType : MonoBehaviour
{
  public bool sc_dev;
  public bool sc_stage;
  public bool sc_live;
  public bool sc_standalone;

  private void Start()
  {
    if (!this.sc_live)
      return;
    Object.Destroy((Object) this.gameObject);
  }
}
