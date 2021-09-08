// Decompiled with JetBrains decompiler
// Type: FillGalleryChampButtonInfo
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SteelCircus.Core.Services;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class FillGalleryChampButtonInfo : MonoBehaviour
{
  public Image championButtonImage;
  public Image championLockedImage;
  public TextMeshProUGUI championButtonName;
  public GameObject championRotationInfoIcon;

  public void SetImage(Sprite championIcon) => this.championButtonImage.sprite = championIcon;

  public void SetText(string champName) => this.championButtonName.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + champName);

  public void StyleLocked(bool locked, bool inRotation)
  {
    if (inRotation)
    {
      this.championLockedImage.gameObject.SetActive(false);
      this.championRotationInfoIcon.SetActive(true);
    }
    else
    {
      this.championRotationInfoIcon.SetActive(false);
      if (locked)
      {
        this.championButtonImage.color = new Color(0.8f, 0.8f, 0.8f, 0.8f);
        this.championLockedImage.gameObject.SetActive(true);
      }
      else
        this.championLockedImage.gameObject.SetActive(false);
    }
  }
}
