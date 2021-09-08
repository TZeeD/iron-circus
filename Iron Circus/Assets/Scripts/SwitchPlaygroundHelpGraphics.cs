// Decompiled with JetBrains decompiler
// Type: SwitchPlaygroundHelpGraphics
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

public class SwitchPlaygroundHelpGraphics : MonoBehaviour
{
  public GameObject controllerTips;
  public GameObject keyboardTips;
  public GameObject mouseTips;

  private void Start()
  {
  }

  private void Update()
  {
    if (!Input.GetKeyDown("m"))
      return;
    this.SwapSprites();
  }

  public void SwapSprites()
  {
    if (this.controllerTips.activeInHierarchy)
    {
      this.keyboardTips.SetActive(true);
      this.controllerTips.SetActive(false);
      this.mouseTips.SetActive(true);
    }
    else
    {
      this.mouseTips.SetActive(false);
      this.keyboardTips.SetActive(false);
      this.controllerTips.SetActive(true);
    }
  }
}
