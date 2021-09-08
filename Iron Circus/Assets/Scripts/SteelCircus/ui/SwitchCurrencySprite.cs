// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.SwitchCurrencySprite
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections;
using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI
{
  [RequireComponent(typeof (Image))]
  public class SwitchCurrencySprite : MonoBehaviour
  {
    public ShopManager.CurrencyType currencyType;

    private void OnEnable() => this.SetSprite();

    public IEnumerator WaitForInitializeMainMenu()
    {
      while ((Object) MenuController.Instance == (Object) null)
        yield return (object) null;
      this.SetSprite();
    }

    public void SetSprite()
    {
      if ((Object) MenuController.Instance == (Object) null)
      {
        this.StartCoroutine(this.WaitForInitializeMainMenu());
      }
      else
      {
        Image component = this.GetComponent<Image>();
        switch (this.currencyType)
        {
          case ShopManager.CurrencyType.steel:
            component.sprite = MenuController.Instance.shopMenu.GetComponent<ShopManager>().steelSprite;
            break;
          case ShopManager.CurrencyType.credits:
            component.sprite = MenuController.Instance.shopMenu.GetComponent<ShopManager>().creditsSprite;
            break;
          default:
            component.sprite = (Sprite) null;
            component.color = new Color(1f, 1f, 1f, 0.0f);
            break;
        }
        component.preserveAspect = true;
      }
    }
  }
}
