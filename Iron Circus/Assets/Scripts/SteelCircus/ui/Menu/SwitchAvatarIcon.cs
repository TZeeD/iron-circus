// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.Menu.SwitchAvatarIcon
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.ScEntitas;
using Imi.SteelCircus.ScriptableObjects;
using SteelCircus.Core.Services;
using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI.Menu
{
  [RequireComponent(typeof (Image))]
  public class SwitchAvatarIcon : MonoBehaviour
  {
    [SerializeField]
    private bool localPlayer;
    [SerializeField]
    private GameObject loadingIcon;
    private ulong playerId;

    private void Start()
    {
      if (this.localPlayer)
        this.playerId = ImiServices.Instance.LoginService.GetPlayerId();
      ImiServices.Instance.progressManager.onPlayerAvatarEquipped += new ProgressManager.OnPlayerAvatarChangedEventHandler(this.OnPlayerAvatarUpdated);
      this.CheckForAvatarIcon();
    }

    public void SetPlayerID(ulong playerId)
    {
      this.localPlayer = (long) playerId == (long) ImiServices.Instance.LoginService.GetPlayerId();
      this.playerId = playerId;
      this.CheckForAvatarIcon();
    }

    public void CheckForAvatarIcon()
    {
      this.ShowIconLoading(true);
      if (this.localPlayer)
      {
        MetaEntity singleEntity = Contexts.sharedInstance.meta.GetGroup(MetaMatcher.MetaPlayerId).GetSingleEntity();
        if (!singleEntity.hasMetaLoadout)
          return;
        this.SetAvatarIcon(SingletonScriptableObject<ItemsConfig>.Instance.GetItemByID(singleEntity.metaLoadout.avatarIconId).icon);
      }
      else
      {
        GameEntity entityWithPlayerId = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(this.playerId);
        if (entityWithPlayerId != null && entityWithPlayerId.hasPlayerLoadout && (Object) entityWithPlayerId.playerLoadout.PlayerAvatarSprite != (Object) null)
        {
          this.SetAvatarIcon(entityWithPlayerId.playerLoadout.PlayerAvatarSprite);
        }
        else
        {
          if (ImiServices.Instance.PartyService.GetAvatarItemId(this.playerId) == -1)
            return;
          this.SetAvatarIcon(SingletonScriptableObject<ItemsConfig>.Instance.GetItemByID(ImiServices.Instance.PartyService.GetAvatarItemId(this.playerId)).icon);
        }
      }
    }

    private void OnPlayerAvatarUpdated(ulong playerId, int itemId)
    {
      if ((long) playerId != (long) this.playerId)
        return;
      Log.Debug("On Player icon updated: " + (object) playerId);
      this.SetAvatarIcon(SingletonScriptableObject<ItemsConfig>.Instance.GetItemByID(itemId).icon);
    }

    private void OnDestroy() => ImiServices.Instance.progressManager.onPlayerAvatarEquipped -= new ProgressManager.OnPlayerAvatarChangedEventHandler(this.OnPlayerAvatarUpdated);

    private void SetAvatarIcon(Sprite icon)
    {
      this.ShowIconLoading(false);
      this.GetComponent<Image>().sprite = icon;
      this.GetComponent<Image>().preserveAspect = true;
    }

    private void ShowIconLoading(bool show)
    {
      if (!((Object) this.loadingIcon != (Object) null))
        return;
      this.loadingIcon.SetActive(show);
    }
  }
}
