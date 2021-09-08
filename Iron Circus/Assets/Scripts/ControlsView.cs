// Decompiled with JetBrains decompiler
// Type: ControlsView
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

public class ControlsView : MonoBehaviour
{
  [SerializeField]
  private GameObject pcControls;
  [SerializeField]
  private GameObject controllerControls;

  private void Start()
  {
  }

  public void ShowPcControls()
  {
    this.pcControls.SetActive(true);
    this.controllerControls.SetActive(false);
  }

  public void ShowControllerControls()
  {
    this.controllerControls.SetActive(true);
    this.pcControls.SetActive(false);
  }
}
