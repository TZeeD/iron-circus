// Decompiled with JetBrains decompiler
// Type: DLCShopItemContainer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Steamworks;
using SteelCircus.Core.Services;
using UnityEngine;

public class DLCShopItemContainer : BaseShopItemContainer
{
  [SerializeField]
  private uint dlcAppId;
  private bool shopPageOpened;
  protected Callback<GameOverlayActivated_t> m_gameOverlayActivated;

  public new void ShopItemClickAction()
  {
    if (!SteamManager.Initialized)
      return;
    this.shopPageOpened = true;
    SteamFriends.ActivateGameOverlayToStore(new AppId_t(this.dlcAppId), EOverlayToStoreFlag.k_EOverlayToStoreFlag_None);
    this.m_gameOverlayActivated = Callback<GameOverlayActivated_t>.Create(new Callback<GameOverlayActivated_t>.DispatchDelegate(this.OnGameOverlayActivated));
  }

  private void OnGameOverlayActivated(GameOverlayActivated_t pCallback)
  {
    if (pCallback.m_bActive != (byte) 0 || !this.shopPageOpened)
      return;
    this.shopPageOpened = false;
    ImiServices.Instance.progressManager.FetchChampionUnlockInfo();
    ImiServices.Instance.progressManager.FetchShopPage(ShopManager.ShopItemType.champion);
  }
}
