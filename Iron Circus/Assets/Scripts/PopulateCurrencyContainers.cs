// Decompiled with JetBrains decompiler
// Type: PopulateCurrencyContainers
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SteelCircus.UI.Network;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class PopulateCurrencyContainers : MonoBehaviour
{
  public CurrencyContainer[] containers;
  public GameObject loadingIcon;
  [SerializeField]
  private GameObject errorMessageText;
  [SerializeField]
  private GameObject shopContainers;

  private void Start() => this.GetShopCreditPacks();

  public void OnPageEntered() => this.GetShopCreditPacks();

  public void GetShopCreditPacks(bool showLoading = true)
  {
    Log.Debug("GET SHOP CREDIT PACKS:");
    if (showLoading)
    {
      this.shopContainers.SetActive(false);
      this.loadingIcon.SetActive(true);
    }
    this.StartCoroutine(MetaServiceHelpers.GetShopCreditPacks(new Action<JObject>(this.OnGetShopCreditPacks)));
  }

  public void OnGetShopCreditPacks(JObject obj)
  {
    if (obj == null || obj["error"] != null || obj["msg"] != null)
    {
      if (obj != null)
      {
        if (obj["error"] != null)
          Log.Error("Could not load shop credits packs: " + (object) obj["error"]);
        if (obj["msg"] != null)
          Log.Error("Could not load shop credits packs: " + (object) obj["msg"]);
      }
      else
        Log.Error("Could not load shop credits packs");
      this.loadingIcon.SetActive(false);
      this.errorMessageText.SetActive(true);
      this.shopContainers.SetActive(false);
      this.EnableShopPacks();
    }
    else
    {
      int index = 0;
      foreach (JObject jobject in (IEnumerable<JToken>) obj["shopCreditPrices"])
      {
        JToken jtoken = jobject["ShopCreditPack"];
        this.containers[index].SetCurrencyValues((int) jobject["credPackId"], jtoken[(object) "paidCredits"].ToString(), jobject["price"].ToString(), jtoken[(object) "bonusCredits"].ToString(), jobject["currency"].ToString());
        ++index;
      }
      this.loadingIcon.SetActive(false);
      this.errorMessageText.SetActive(false);
      this.shopContainers.SetActive(true);
    }
  }

  public void EnableShopPacks()
  {
    foreach (Component container in this.containers)
      container.gameObject.GetComponent<Button>().interactable = true;
  }

  public void DisableShopPacks()
  {
    foreach (Component container in this.containers)
      container.gameObject.GetComponent<Button>().interactable = false;
  }
}
