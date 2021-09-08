// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.Services.ProgressManager
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SteelCircus.ScriptableObjects;
using Imi.SteelCircus.UI.Network;
using Newtonsoft.Json.Linq;
using Steamworks;
using SteelCircus.UI;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace SteelCircus.Core.Services
{
  public class ProgressManager
  {
    public static bool dlcInstalledAtStartup;
    private static readonly string dlcButtonPrefabPath = "Prefabs/UI/Menu/Shop/DLC_ShopButtons/";
    private Dictionary<int, ShopItem> playerItemDictionary;
    private Dictionary<ShopManager.ShopItemType, Dictionary<int, ShopItem>> itemsDictDict;
    private ChampionLoadout playerLoadout;
    private bool tutorialQuestsLoaded;
    private bool dailyChallengesLoaded;
    private bool milestonesLoaded;
    private JObject tutorialQuestInfo;
    private JObject dailyChallengeInfo;
    private JObject milestoneInfo;
    private int playerCreds;
    private int playerSteel;
    private int playerLevel;
    private ImiServicesHelper imiHelper;

    public JObject TutorialQuestInfo => this.tutorialQuestInfo;

    public JObject DailyChallengeInfo => this.dailyChallengeInfo;

    public JObject MilestoneInfo => this.milestoneInfo;

    public event ProgressManager.OnItemsReceivedEventHandler OnItemReceived;

    public event ProgressManager.OnShopPageReceivedEventHandler OnShopPageReceived;

    public event ProgressManager.OnItemUnlockedEventHandler OnItemUnlocked;

    public event ProgressManager.OnItemUnlockFailureEventHandler OnItemUnlockFailure;

    public event ProgressManager.OnPlayerCredsUpdatedHandler OnPlayerCredsUpdated;

    public event ProgressManager.OnItemEquippedEventHandler OnItemEquipped;

    public event ProgressManager.OnPlayerAvatarChangedEventHandler onPlayerAvatarEquipped;

    public event ProgressManager.OnPlayerSteelUpdatedHandler OnPlayerSteelUpdated;

    public event ProgressManager.OnPlayerLevelUpdatedHandler OnPlayerLevelUpdated;

    public event ProgressManager.OnWeeklyShopRotationUpdatedHandler OnWeeklyShopRotationUpdated;

    public event ProgressManager.OnChampionUnlockInfoUpdatedHandler OnChampionUnlockInfoUpdated;

    public event ProgressManager.OnTutorialProgressReceivedEventHandler OnTutorialProgressReceived;

    public event ProgressManager.OnDailyQuestProgressReceivedEventHandler OnDailyQuestProgressReceived;

    public event ProgressManager.OnMilestoneProgressReceivedEventHandler OnMilestoneProgressReceived;

    public event ProgressManager.OnShopDlcListReceivedEventHandler OnShopDlcListReceived;

    public event ProgressManager.OnDlcItemListReceivedEventHanlder OnDlcItemListReceived;

    public ProgressManager(ImiServicesHelper imiHelper)
    {
      this.imiHelper = imiHelper;
      this.AddListeners();
      imiHelper.ApplicationQuitEvent += new Action(this.RemoveListeners);
      if (!SteamManager.Initialized)
        return;
      ProgressManager.dlcInstalledAtStartup = SteamApps.BIsDlcInstalled(new AppId_t(1101500U));
    }

    public int GetPlayerCreds() => this.playerCreds;

    public int GetPlayerSteel() => this.playerSteel;

    public int GetPlayerLevel() => this.playerLevel;

    public void AddListeners() => ImiServices.Instance.LoadingScreenService.OnShowLoadingScreen += new LoadingScreenService.OnShowLoadingScreenEventHandler(this.OnShowLoadingScreen);

    public void RemoveListeners()
    {
      ImiServices.Instance.LoadingScreenService.OnShowLoadingScreen -= new LoadingScreenService.OnShowLoadingScreenEventHandler(this.OnShowLoadingScreen);
      this.imiHelper.ApplicationQuitEvent -= new Action(this.RemoveListeners);
    }

    public void OnShowLoadingScreen(LoadingScreenService.LoadingScreenIntent intent)
    {
      if (intent != LoadingScreenService.LoadingScreenIntent.loadingMainMenu)
        return;
      ImiServices.Instance.LoadingScreenService.AddTaskToLoadingScreen(this.LoadQuestProgressTask());
      ImiServices.Instance.LoadingScreenService.AddTaskToLoadingScreen(this.LoadPlayerProgressTask());
    }

    public void StartLoadingQuestProgress() => this.imiHelper.StartCoroutine(this.LoadQuestProgressTask());

    public IEnumerator LoadQuestProgressTask()
    {
      // ISSUE: reference to a compiler-generated field
      int num = this.\u003C\u003E1__state;
      ProgressManager progressManager = this;
      if (num != 0)
      {
        if (num != 1)
          return false;
        // ISSUE: reference to a compiler-generated field
        this.\u003C\u003E1__state = -1;
        ImiServices.Instance.LoadingScreenService.SetLoadingScreenTaskCompleted();
        return false;
      }
      // ISSUE: reference to a compiler-generated field
      this.\u003C\u003E1__state = -1;
      progressManager.ResetQuestData();
      SingletonManager<MetaServiceHelpers>.Instance.StartCoroutine(MetaServiceHelpers.GetTutorialProgress(ImiServices.Instance.LoginService.GetPlayerId(), new Action<JObject>(progressManager.OnGetTutorialProgress)));
      // ISSUE: reference to a compiler-generated field
      this.\u003C\u003E2__current = (object) new WaitUntil(new Func<bool>(progressManager.GetQuestProgressLoaded));
      // ISSUE: reference to a compiler-generated field
      this.\u003C\u003E1__state = 1;
      return true;
    }

    public IEnumerator LoadPlayerProgressTask()
    {
      // ISSUE: reference to a compiler-generated field
      int num = this.\u003C\u003E1__state;
      ProgressManager progressManager = this;
      if (num != 0)
      {
        if (num != 1)
          return false;
        // ISSUE: reference to a compiler-generated field
        this.\u003C\u003E1__state = -1;
        ImiServices.Instance.LoadingScreenService.SetLoadingScreenTaskCompleted();
        return false;
      }
      // ISSUE: reference to a compiler-generated field
      this.\u003C\u003E1__state = -1;
      // ISSUE: reference to a compiler-generated field
      this.\u003C\u003E2__current = (object) progressManager.imiHelper.StartCoroutine(MetaServiceHelpers.GetPlayerProgress(ImiServices.Instance.LoginService.GetPlayerId(), new Action<ulong, JObject>(progressManager.OnFetchedPlayerProgress)));
      // ISSUE: reference to a compiler-generated field
      this.\u003C\u003E1__state = 1;
      return true;
    }

    private void ResetQuestData()
    {
      this.tutorialQuestsLoaded = false;
      this.dailyChallengesLoaded = false;
      this.milestonesLoaded = false;
      this.tutorialQuestInfo = (JObject) null;
      this.milestoneInfo = (JObject) null;
      this.dailyChallengeInfo = (JObject) null;
    }

    private void LoadDailyQuests()
    {
      SingletonManager<MetaServiceHelpers>.Instance.StartCoroutine(MetaServiceHelpers.GetQuestsProgress(ImiServices.Instance.LoginService.GetPlayerId(), new Action<JObject>(this.OnGetDailyQuestsProgress)));
      SingletonManager<MetaServiceHelpers>.Instance.StartCoroutine(MetaServiceHelpers.GetMilestonesProgress(ImiServices.Instance.LoginService.GetPlayerId(), new Action<JObject>(this.OnGetMilestoneProgress)));
    }

    private void OnGetDailyQuestsProgress(JObject obj)
    {
      this.dailyChallengesLoaded = true;
      this.dailyChallengeInfo = obj;
      ProgressManager.OnDailyQuestProgressReceivedEventHandler progressReceived = this.OnDailyQuestProgressReceived;
      if (progressReceived == null)
        return;
      progressReceived(obj);
    }

    private void OnGetMilestoneProgress(JObject obj)
    {
      this.milestonesLoaded = true;
      this.milestoneInfo = obj;
      ProgressManager.OnMilestoneProgressReceivedEventHandler progressReceived = this.OnMilestoneProgressReceived;
      if (progressReceived == null)
        return;
      progressReceived(obj);
    }

    private void OnGetTutorialProgress(JObject obj)
    {
      if (!obj["result"].Any<JToken>() && !obj["rewards"].Any<JToken>())
      {
        Log.Debug("No Tutorial quests. Requesting daily challenges.");
        this.LoadDailyQuests();
      }
      else
      {
        ProgressManager.OnTutorialProgressReceivedEventHandler progressReceived = this.OnTutorialProgressReceived;
        if (progressReceived != null)
          progressReceived(obj);
        this.tutorialQuestInfo = obj;
        this.tutorialQuestsLoaded = true;
      }
    }

    public bool GetQuestProgressLoaded()
    {
      if (this.tutorialQuestsLoaded)
        return true;
      return this.milestonesLoaded && this.dailyChallengesLoaded;
    }

    public List<ShopItem> GetPlayerItems() => this.playerItemDictionary != null ? this.playerItemDictionary.Values.ToList<ShopItem>() : new List<ShopItem>();

    public List<ShopItem> GetItemsByType(ShopManager.ShopItemType itemType)
    {
      List<ShopItem> shopItemList = new List<ShopItem>();
      foreach (KeyValuePair<int, ShopItem> keyValuePair in this.itemsDictDict[itemType])
        shopItemList.Add(keyValuePair.Value);
      return shopItemList;
    }

    public List<ShopItem> GetItemsByTypeAndChampion(
      ShopManager.ShopItemType itemType,
      ChampionConfig champion)
    {
      List<ShopItem> shopItemList = new List<ShopItem>();
      foreach (KeyValuePair<int, ShopItem> keyValuePair in this.itemsDictDict[itemType])
      {
        if ((UnityEngine.Object) champion != (UnityEngine.Object) null && (UnityEngine.Object) keyValuePair.Value.itemDefinition.champion == (UnityEngine.Object) champion)
          shopItemList.Add(keyValuePair.Value);
      }
      return shopItemList;
    }

    public List<ShopItem> GetNeutralItemsByType(ShopManager.ShopItemType itemType)
    {
      List<ShopItem> shopItemList = new List<ShopItem>();
      if (this.itemsDictDict.ContainsKey(itemType))
      {
        foreach (KeyValuePair<int, ShopItem> keyValuePair in this.itemsDictDict[itemType])
        {
          if (keyValuePair.Value.itemDefinition.type == ShopManager.ShopItemType.avatarIcon)
            shopItemList.Add(keyValuePair.Value);
          else if (keyValuePair.Value.itemDefinition.champion.championType == ChampionType.Invalid)
            shopItemList.Add(keyValuePair.Value);
        }
      }
      return shopItemList;
    }

    public bool SetItemUnlocked(int definitionId)
    {
      ShopItem itemByDefinitionId = this.GetItemByDefinitionId(definitionId);
      if (itemByDefinitionId == null || itemByDefinitionId.ownedByPlayer)
        return false;
      itemByDefinitionId.ownedByPlayer = true;
      return true;
    }

    public ShopItem GetItemByDefinitionId(int definitionId)
    {
      if (this.playerItemDictionary.ContainsKey(definitionId))
      {
        ShopItem playerItem = this.playerItemDictionary[definitionId];
        if (playerItem != null)
          return playerItem;
      }
      Log.Warning(string.Format("Item with id {0} not found.", (object) definitionId));
      return (ShopItem) null;
    }

    public ShopItem[] GetEquippedSlotsByType(
      ShopManager.ShopItemType type,
      ChampionConfig champion)
    {
      if (type != ShopManager.ShopItemType.spray && type != ShopManager.ShopItemType.emote)
      {
        Log.Error("Tried to get equipped slots for items that don't use slots.");
        return (ShopItem[]) null;
      }
      ShopItem[] shopItemArray = new ShopItem[4];
      List<ShopItem> byTypeAndChampion = this.GetItemsByTypeAndChampion(type, champion);
      byTypeAndChampion.AddRange((IEnumerable<ShopItem>) this.GetItemsByTypeAndChampion(type, SingletonScriptableObject<ChampionConfigProvider>.Instance.GetChampionConfigFor(ChampionType.Invalid)));
      foreach (ShopItem shopItem in byTypeAndChampion)
      {
        if (shopItem.IsEquipped())
        {
          foreach (EquipSlot equipSlot in shopItem.equipped)
          {
            if (equipSlot.champion == champion.championType || equipSlot.champion == ChampionType.Invalid)
              shopItemArray[equipSlot.slot - 1] = shopItem;
          }
        }
      }
      return shopItemArray;
    }

    public ItemDefinition GetEquippedSkinForChampion(ChampionConfig champion)
    {
      MetaEntity singleEntity = Contexts.sharedInstance.meta.GetGroup(MetaMatcher.MetaPlayerId).GetSingleEntity();
      return singleEntity.hasMetaLoadout && singleEntity.metaLoadout.itemLoadouts.ContainsKey(champion.championType) ? SingletonScriptableObject<ItemsConfig>.Instance.GetItemByID(singleEntity.metaLoadout.itemLoadouts[champion.championType].skin) : (ItemDefinition) null;
    }

    private ShopItem ParseShopItem(JToken token) => new ShopItem((int) token[(object) "definitionId"], token[(object) "status"].ToString(), (JArray) token[(object) "equipped"]);

    private List<ShopItem> ParseShopItemArray(JArray obj)
    {
      List<ShopItem> shopItemList = new List<ShopItem>();
      foreach (JToken child in obj.Children())
        shopItemList.Add(this.ParseShopItem(child));
      return shopItemList;
    }

    public void GetWeeklyShopRotation() => SingletonManager<MetaServiceHelpers>.Instance.StartGetWeeklyShopRotationCoroutine(new Action<JObject>(this.OnGetWeeklyShopRotataion), new Action<JObject>(this.OnGetWeeklyShopRotataionError));

    private void OnGetWeeklyShopRotataion(JObject obj)
    {
      List<ShopRotationData> shopRotationData1 = new List<ShopRotationData>();
      if (obj["error"] == null && obj["msg"] == null)
      {
        foreach (JObject jobject in (IEnumerable<JToken>) obj["weeklyShopRotation"])
        {
          ShopRotationData shopRotationData2 = new ShopRotationData(SingletonScriptableObject<ItemsConfig>.Instance.GetItemByID((int) jobject["id"]), (long) (int) jobject["duration"]);
          shopRotationData1.Add(shopRotationData2);
        }
        ProgressManager.OnWeeklyShopRotationUpdatedHandler shopRotationUpdated = this.OnWeeklyShopRotationUpdated;
        if (shopRotationUpdated == null)
          return;
        shopRotationUpdated(shopRotationData1);
      }
      else
        Log.Error("Weekly shop rotation service returned error: " + (object) obj);
    }

    private void OnGetWeeklyShopRotataionError(JObject obj) => Log.Error(obj.ToString());

    public void GetShopDlcList() => this.imiHelper.StartCoroutine(MetaServiceHelpers.GetShopDlc(new Action<JObject>(this.OnGetShopDlcList)));

    private void OnGetShopDlcList(JObject obj)
    {
      if (obj["error"] != null && obj["result"] == null)
      {
        Log.Error("Error receiving shop dlc list:" + (object) obj);
      }
      else
      {
        List<ShopBundleData> dlcData = new List<ShopBundleData>();
        foreach (JToken jtoken in (IEnumerable<JToken>) obj["result"])
        {
          int bundleId = int.Parse(jtoken[(object) "id"].ToString());
          int cPrice = int.Parse(jtoken[(object) "final_price"].ToString());
          int cPriceBeforeDiscount = int.Parse(jtoken[(object) "initial_price"].ToString());
          int num = int.Parse(jtoken[(object) "discount_percent"].ToString());
          string isoCurrency = jtoken[(object) "currency"].ToString();
          uint cAppID = uint.Parse(jtoken[(object) "steamId"].ToString());
          string str = jtoken[(object) "name"].ToString();
          ShopBundleData shopBundleData = new ShopBundleData(bundleId, this.LoadDlcContainerPrefab(str), num > 0, cPrice, cPriceBeforeDiscount, ShopManager.CurrencyType.realMoney, isoCurrency, new List<ShopItem>(), 0, 0, str, str + " Description", (Sprite) null, false, 0, cAppID);
          dlcData.Add(shopBundleData);
        }
        ProgressManager.OnShopDlcListReceivedEventHandler shopDlcListReceived = this.OnShopDlcListReceived;
        if (shopDlcListReceived == null)
          return;
        shopDlcListReceived(dlcData);
      }
    }

    public GameObject LoadDlcContainerPrefab(string name) => Resources.Load<GameObject>(ProgressManager.dlcButtonPrefabPath + name + "_button_prefab");

    public void GetDlcItemList(int bundleId) => this.imiHelper.StartCoroutine(MetaServiceHelpers.GetDlcItemList(bundleId, new Action<int, JObject>(this.OnGetDlcItemList)));

    private void OnGetDlcItemList(int bundleId, JObject obj)
    {
      if (obj["error"] != null && obj["result"] == null)
      {
        Log.Error("Error receiving dlc item list:" + (object) obj);
      }
      else
      {
        JToken jtoken1 = obj["result"];
        List<ShopItem> shopItemList = new List<ShopItem>();
        int.Parse(jtoken1[(object) "creditReward"].ToString());
        int.Parse(jtoken1[(object) "creditReward"].ToString());
        foreach (JToken jtoken2 in (IEnumerable<JToken>) jtoken1[(object) "items"])
          shopItemList.Add(this.GetItemByDefinitionId(int.Parse(jtoken2.ToString())));
        ProgressManager.OnDlcItemListReceivedEventHanlder itemListReceived = this.OnDlcItemListReceived;
        if (itemListReceived == null)
          return;
        itemListReceived(bundleId, shopItemList);
      }
    }

    public void UnlockItem(ulong playerId, int itemId, ShopManager.CurrencyType currency = ShopManager.CurrencyType.credits)
    {
      ItemDefinition itemById = SingletonScriptableObject<ItemsConfig>.Instance.GetItemByID(itemId);
      switch (currency)
      {
        case ShopManager.CurrencyType.steel:
          if (itemById.type == ShopManager.ShopItemType.champion)
          {
            SingletonManager<MetaServiceHelpers>.Instance.StartUnlockItemCoroutine(playerId, itemId, new Action<JObject, int>(this.OnUnlockChampion));
            break;
          }
          SingletonManager<MetaServiceHelpers>.Instance.StartUnlockItemWithSteelCoroutine(playerId, itemId, new Action<JObject, int>(this.OnUnlockItem));
          break;
        case ShopManager.CurrencyType.credits:
          if (itemById.type == ShopManager.ShopItemType.champion)
          {
            SingletonManager<MetaServiceHelpers>.Instance.StartUnlockItemCoroutine(playerId, itemId, new Action<JObject, int>(this.OnUnlockChampion));
            break;
          }
          SingletonManager<MetaServiceHelpers>.Instance.StartUnlockItemCoroutine(playerId, itemId, new Action<JObject, int>(this.OnUnlockItem));
          break;
      }
    }

    public void OnUnlockChampion(JObject Obj, int itemId)
    {
      this.FetchChampionUnlockInfo();
      this.OnUnlockItem(Obj, itemId);
    }

    public void OnUnlockItem(JObject Jobj, int itemId)
    {
      if (Jobj["error"] == null && Jobj["msg"] == null)
      {
        Log.Debug("Unlocked item:\n" + Jobj.ToString());
        this.SetItemUnlocked(itemId);
        this.playerCreds = int.Parse(Jobj["freeCredits"].ToString()) + int.Parse(Jobj["paidCredits"].ToString());
        ProgressManager.OnPlayerCredsUpdatedHandler playerCredsUpdated = this.OnPlayerCredsUpdated;
        if (playerCredsUpdated != null)
          playerCredsUpdated(ImiServices.Instance.LoginService.GetPlayerId(), this.playerCreds);
        this.playerSteel = int.Parse(Jobj["steel"].ToString());
        ProgressManager.OnPlayerSteelUpdatedHandler playerSteelUpdated = this.OnPlayerSteelUpdated;
        if (playerSteelUpdated != null)
          playerSteelUpdated(ImiServices.Instance.LoginService.GetPlayerId(), this.playerSteel);
        ProgressManager.OnItemUnlockedEventHandler onItemUnlocked = this.OnItemUnlocked;
        if (onItemUnlocked != null)
          onItemUnlocked(Jobj, itemId);
        ProgressManager.OnItemsReceivedEventHandler onItemReceived = this.OnItemReceived;
        if (onItemReceived == null)
          return;
        onItemReceived();
      }
      else
      {
        ProgressManager.OnItemUnlockFailureEventHandler itemUnlockFailure = this.OnItemUnlockFailure;
        if (itemUnlockFailure == null)
          return;
        itemUnlockFailure((Jobj["error"] != null ? (object) Jobj["error"] : (object) Jobj["msg"]).ToString());
      }
    }

    public void EquipItem(ulong playerId, int itemId, ChampionType champion, int slot) => SingletonManager<MetaServiceHelpers>.Instance.StartEquipItemCoroutine(playerId, itemId, champion, slot, new Action<JObject, int>(this.OnEquipItem));

    public void EquipItem(
      ulong playerId,
      int itemId,
      ChampionType champion,
      int slot,
      Action<JObject, int> onSuccess)
    {
      SingletonManager<MetaServiceHelpers>.Instance.StartEquipItemCoroutine(playerId, itemId, champion, slot, onSuccess);
    }

    public void OnEquipItem(JObject Jobj, int itemId)
    {
      if (Jobj["error"] != null || Jobj["msg"] != null)
        return;
      Log.Debug("Equipped item:\n" + Jobj.ToString());
      this.FetchItemSubset(this.GetItemByDefinitionId(itemId).itemDefinition.type);
      if (SingletonScriptableObject<ItemsConfig>.Instance.GetItemByID(itemId).type == ShopManager.ShopItemType.avatarIcon)
      {
        ProgressManager.OnPlayerAvatarChangedEventHandler playerAvatarEquipped = this.onPlayerAvatarEquipped;
        if (playerAvatarEquipped != null)
          playerAvatarEquipped(ImiServices.Instance.LoginService.GetPlayerId(), itemId);
        ImiServices.Instance.PartyService.SetAvatarItemId(ImiServices.Instance.LoginService.GetPlayerId(), itemId);
      }
      ProgressManager.OnItemEquippedEventHandler onItemEquipped = this.OnItemEquipped;
      if (onItemEquipped == null)
        return;
      onItemEquipped();
    }

    public void OnEquipPlayerAvatar(ulong playerId, int itemId)
    {
      ProgressManager.OnPlayerAvatarChangedEventHandler playerAvatarEquipped = this.onPlayerAvatarEquipped;
      if (playerAvatarEquipped == null)
        return;
      playerAvatarEquipped(playerId, itemId);
    }

    public void FetchChampionUnlockInfo(LoadingScreenService.LoadingScreenIntent intent)
    {
      if (intent != LoadingScreenService.LoadingScreenIntent.loadingLobby)
        return;
      this.FetchChampionUnlockInfo();
    }

    public void FetchChampionUnlockInfo() => SingletonManager<MetaServiceHelpers>.Instance.StartGetItemSubsetCoroutine(ImiServices.Instance.LoginService.GetPlayerId(), ShopManager.ShopItemType.champion, new Action<JObject, ShopManager.ShopItemType>(this.OnFetchChampionUnlockInfo), new Action<JObject, ShopManager.ShopItemType>(this.OnFetchChampionUnlockInfoError));

    public void OnFetchChampionUnlockInfoError(JObject Jobj, ShopManager.ShopItemType itemType)
    {
      if (Jobj["msg"] != null)
        Log.Error("Get Unlocked Champions returned error: " + (object) Jobj["msg"]);
      if (Jobj["error"] == null)
        return;
      Log.Error("Get Unlocked Champions returned error: " + (object) Jobj["error"]);
    }

    public void OnFetchChampionUnlockInfo(JObject Jobj, ShopManager.ShopItemType itemType)
    {
      if (Jobj["error"] == null && Jobj["msg"] == null)
      {
        if (!this.ParseChampionUnlockInfo(Jobj))
          return;
        ProgressManager.OnChampionUnlockInfoUpdatedHandler unlockInfoUpdated = this.OnChampionUnlockInfoUpdated;
        if (unlockInfoUpdated == null)
          return;
        unlockInfoUpdated();
      }
      else
        this.OnFetchChampionUnlockInfoError(Jobj, itemType);
    }

    public bool ParseChampionUnlockInfo(JObject obj)
    {
      if (obj["items"] != null)
      {
        Log.Debug(obj["items"].ToString());
        Dictionary<ChampionType, bool> newChampionLockStateDict = new Dictionary<ChampionType, bool>();
        Dictionary<ChampionType, bool> newChampionRotationStateDict = new Dictionary<ChampionType, bool>();
        foreach (JToken jtoken in (IEnumerable<JToken>) obj["items"])
        {
          int definitionID = int.Parse(jtoken[(object) "definitionId"].ToString());
          bool flag1 = jtoken[(object) "status"].ToString().Equals("unlocked");
          bool flag2 = false;
          if (jtoken[(object) "rotation"] != null)
            flag2 = (bool) jtoken[(object) "rotation"];
          ChampionType championType = SingletonScriptableObject<ItemsConfig>.Instance.GetItemByID(definitionID, ShopManager.ShopItemType.champion).champion.championType;
          newChampionLockStateDict.Add(championType, flag1);
          newChampionRotationStateDict.Add(championType, flag2);
          Log.Debug(definitionID.ToString() + ":" + (object) championType + " : " + flag1.ToString());
        }
        Contexts.sharedInstance.meta.GetGroup(MetaMatcher.MetaPlayerId).GetSingleEntity().ReplaceMetaChampionsUnlocked(newChampionLockStateDict, newChampionRotationStateDict);
        return true;
      }
      Log.Error("Malformed JSON from Champions Unlocked Service: items missing!");
      return false;
    }

    public void FetchChampionUnlockInfoForStandalone()
    {
      if (!this.ParseChampionUnlockInfoForStandalone())
        return;
      ProgressManager.OnChampionUnlockInfoUpdatedHandler unlockInfoUpdated = this.OnChampionUnlockInfoUpdated;
      if (unlockInfoUpdated == null)
        return;
      unlockInfoUpdated();
    }

    public bool ParseChampionUnlockInfoForStandalone()
    {
      Dictionary<ChampionType, bool> dictionary1 = new Dictionary<ChampionType, bool>();
      Dictionary<ChampionType, bool> dictionary2 = new Dictionary<ChampionType, bool>();
      foreach (ChampionType key in Enum.GetValues(typeof (ChampionType)))
      {
        switch (key)
        {
          case ChampionType.Invalid:
          case ChampionType.Random:
          case ChampionType.Kenny:
            continue;
          default:
            dictionary2.Add(key, false);
            dictionary1.Add(key, true);
            continue;
        }
      }
      Contexts.sharedInstance.meta.GetGroup(MetaMatcher.MetaPlayerId).GetSingleEntity().ReplaceMetaChampionsUnlocked(dictionary1, dictionary1);
      return true;
    }

    public void FetchPlayerProgress(ulong playerId)
    {
      Log.Debug("ItemManager is fetching playerprogress for " + (object) playerId);
      SingletonManager<MetaServiceHelpers>.Instance.GetPlayerProgressCoroutine(playerId, new Action<ulong, JObject>(this.OnFetchedPlayerProgress));
    }

    public void FetchPlayerProgress()
    {
      Log.Debug("ProgressManager is fetching playerprogress for " + (object) ImiServices.Instance.LoginService.GetPlayerId());
      SingletonManager<MetaServiceHelpers>.Instance.GetPlayerProgressCoroutine(ImiServices.Instance.LoginService.GetPlayerId(), new Action<ulong, JObject>(this.OnFetchedPlayerProgress));
    }

    public void OnFetchedPlayerProgress(ulong playerId, JObject obj)
    {
      Log.Debug("ProfileProgressionComponent OnSuccess. : " + obj.ToString());
      if (obj["currentLevel"] != null)
      {
        this.playerLevel = (int) obj["currentLevel"];
        ProgressManager.OnPlayerLevelUpdatedHandler playerLevelUpdated = this.OnPlayerLevelUpdated;
        if (playerLevelUpdated != null)
          playerLevelUpdated(playerId, int.Parse(obj["currentLevel"].ToString()));
      }
      if (obj["freeCredits"] != null)
      {
        int newPlayerCreds = obj["paidCredits"] == null ? (int) obj["freeCredits"] : (int) obj["freeCredits"] + (int) obj["paidCredits"];
        this.playerCreds = newPlayerCreds;
        ProgressManager.OnPlayerCredsUpdatedHandler playerCredsUpdated = this.OnPlayerCredsUpdated;
        if (playerCredsUpdated != null)
          playerCredsUpdated(playerId, newPlayerCreds);
      }
      if (obj["steelCredits"] == null || !(obj["steelCredits"].ToString() != "null"))
        return;
      this.playerSteel = (int) obj["steelCredits"];
      ProgressManager.OnPlayerSteelUpdatedHandler playerSteelUpdated = this.OnPlayerSteelUpdated;
      if (playerSteelUpdated == null)
        return;
      playerSteelUpdated(playerId, int.Parse(obj["steelCredits"].ToString()));
    }

    public void UpdatePlayerCreds(int credsAmount)
    {
      this.playerCreds = credsAmount;
      ProgressManager.OnPlayerCredsUpdatedHandler playerCredsUpdated = this.OnPlayerCredsUpdated;
      if (playerCredsUpdated == null)
        return;
      playerCredsUpdated(ImiServices.Instance.LoginService.GetPlayerId(), credsAmount);
    }

    public void FetchAllItems()
    {
      Debug.Log((object) ("ProgressionService get all items. PlayerID: " + (object) ImiServices.Instance.LoginService.GetPlayerId()));
      SingletonManager<MetaServiceHelpers>.Instance.StartGetAllItemsForPlayerCoroutine(ImiServices.Instance.LoginService.GetPlayerId(), new Action<JObject>(this.OnFetchedAllItems));
    }

    public void FetchShopPage(ShopManager.ShopItemType itemType)
    {
      Debug.Log((object) ("ProgressionService get ShopPage for: " + itemType.ToString()));
      SingletonManager<MetaServiceHelpers>.Instance.StartGetShopPageCoroutine(ImiServices.Instance.LoginService.GetPlayerId(), itemType, new Action<JObject, ShopManager.ShopItemType>(this.OnFetchShopPage), new Action<JObject, ShopManager.ShopItemType>(this.OnFetchShopPageError));
    }

    public void OnFetchShopPage(JObject obj, ShopManager.ShopItemType type)
    {
      if (obj["error"] == null && obj["msg"] == null)
      {
        List<ShopItem> shopItemArray = this.ParseShopItemArray((JArray) obj["items"]);
        ProgressManager.OnShopPageReceivedEventHandler shopPageReceived = this.OnShopPageReceived;
        if (shopPageReceived == null)
          return;
        shopPageReceived(type, shopItemArray);
      }
      else
        this.OnFetchShopPageError(obj, type);
    }

    public void OnFetchShopPageError(JObject obj, ShopManager.ShopItemType type) => Log.Error("ERROR: Failed to fetch shop page. " + (object) obj);

    public void FetchItemSubset(ShopManager.ShopItemType itemType)
    {
      Debug.Log((object) ("ProgressionService get all items of type: " + itemType.ToString()));
      SingletonManager<MetaServiceHelpers>.Instance.StartGetItemSubsetCoroutine(ImiServices.Instance.LoginService.GetPlayerId(), itemType, new Action<JObject, ShopManager.ShopItemType>(this.OnFetchedItemSubset), new Action<JObject, ShopManager.ShopItemType>(this.OnFetchedItemSubsetError));
    }

    public void OnFetchedItemSubset(JObject obj, ShopManager.ShopItemType type)
    {
      MetaEntity singleEntity = Contexts.sharedInstance.meta.GetGroup(MetaMatcher.MetaPlayerId).GetSingleEntity();
      if (obj["error"] == null && obj["msg"] == null)
      {
        this.itemsDictDict[type] = new Dictionary<int, ShopItem>();
        ItemDefinition itemDefinition = (ItemDefinition) null;
        Dictionary<ChampionType, ChampionLoadout> dictionary = (Dictionary<ChampionType, ChampionLoadout>) null;
        if (singleEntity.hasMetaLoadout)
        {
          dictionary = singleEntity.metaLoadout.itemLoadouts;
          itemDefinition = SingletonScriptableObject<ItemsConfig>.Instance.GetItemByID(singleEntity.metaLoadout.avatarIconId);
        }
        foreach (JToken jtoken in (IEnumerable<JToken>) obj["items"])
        {
          ShopItem shopItem = new ShopItem((int) jtoken[(object) "definitionId"], jtoken[(object) "status"].ToString(), (JArray) jtoken[(object) "equipped"], bool.Parse(jtoken[(object) "buyable"].ToString()));
          if (shopItem.itemDefinition.type == type)
          {
            this.itemsDictDict[type].Add(shopItem.itemDefinition.definitionId, shopItem);
            if (shopItem.IsEquipped())
            {
              if (shopItem.itemDefinition.type == ShopManager.ShopItemType.avatarIcon)
                itemDefinition = shopItem.itemDefinition;
              else
                dictionary = this.AddItemToLoadoutComponent(shopItem, dictionary);
            }
          }
          if (this.playerItemDictionary.ContainsKey(shopItem.itemDefinition.definitionId))
            this.playerItemDictionary[shopItem.itemDefinition.definitionId] = shopItem;
          else
            this.playerItemDictionary.Add(shopItem.itemDefinition.definitionId, shopItem);
        }
        singleEntity.ReplaceMetaLoadout(itemDefinition.definitionId, itemDefinition.icon, dictionary);
        ProgressManager.OnItemsReceivedEventHandler onItemReceived = this.OnItemReceived;
        if (onItemReceived == null)
          return;
        onItemReceived();
      }
      else
        this.OnFetchedItemSubsetError(obj, type);
    }

    public void OnFetchedItemSubsetError(JObject obj, ShopManager.ShopItemType type) => Log.Error("ERROR: Failed to fetch item subset. " + (object) obj);

    public void FetchPlayerLoadout() => SingletonManager<MetaServiceHelpers>.Instance.GetPlayerLoadoutCoroutine(ImiServices.Instance.LoginService.GetPlayerId(), new Action<ulong, JObject>(this.OnFetchedPlayerLoadout));

    public void OnFetchedPlayerLoadout(ulong playerId, JObject obj)
    {
      if (obj["loadouts"] != null)
      {
        MetaEntity singleEntity = Contexts.sharedInstance.meta.GetGroup(MetaMatcher.MetaPlayerId).GetSingleEntity();
        Dictionary<ChampionType, ChampionLoadout> newItemLoadouts = new Dictionary<ChampionType, ChampionLoadout>();
        ItemDefinition itemDefinition = (ItemDefinition) null;
        foreach (JObject data in (IEnumerable<JToken>) obj["loadouts"])
        {
          if ((int) data["champion"] != -1)
          {
            ChampionLoadout championLoadout = new ChampionLoadout(data);
            ChampionType championType = (ChampionType) int.Parse(data["champion"].ToString());
            newItemLoadouts.Add(championType, championLoadout);
            if (championLoadout.skin == -1 || championLoadout.skin == int.MaxValue)
            {
              Log.Error("Skin for champion " + (object) championType + "not equipped. Equipping default skin.");
              ImiServices.Instance.progressManager.EquipItem(ImiServices.Instance.LoginService.GetPlayerId(), SingletonScriptableObject<ItemsConfig>.Instance.GetMainSkinForChampion(championType).definitionId, championType, -1);
            }
          }
          else if (data["avatarIcon"] == null)
          {
            Log.Error("user avatar Icon null. This should not happen.");
            itemDefinition = SingletonScriptableObject<ItemsConfig>.Instance.GetItemsByType(ShopManager.ShopItemType.avatarIcon)[0];
          }
          else
            itemDefinition = SingletonScriptableObject<ItemsConfig>.Instance.GetItemByID((int) data["avatarIcon"]);
        }
        singleEntity.ReplaceMetaLoadout(itemDefinition.definitionId, itemDefinition.icon, newItemLoadouts);
      }
      else
        Log.Error("No Player Loadout Data for Player reveiced");
    }

    public void OnFetchedAllItems(JObject Jobj)
    {
      MetaEntity singleEntity = Contexts.sharedInstance.meta.GetGroup(MetaMatcher.MetaPlayerId).GetSingleEntity();
      Log.Debug("Fetched items");
      List<ShopItem> shopItemList = new List<ShopItem>();
      this.playerItemDictionary = new Dictionary<int, ShopItem>();
      if (Jobj["error"] != null || Jobj["msg"] != null)
      {
        Log.Error("Could not receive items.");
      }
      else
      {
        Dictionary<ChampionType, ChampionLoadout> dictionary = new Dictionary<ChampionType, ChampionLoadout>();
        ItemDefinition itemDefinition = (ItemDefinition) null;
        if (singleEntity.hasMetaLoadout)
          itemDefinition = SingletonScriptableObject<ItemsConfig>.Instance.GetItemByID(singleEntity.metaLoadout.avatarIconId);
        this.itemsDictDict = new Dictionary<ShopManager.ShopItemType, Dictionary<int, ShopItem>>();
        foreach (JToken jtoken in (IEnumerable<JToken>) Jobj["items"])
        {
          ShopItem shopItem = new ShopItem((int) jtoken[(object) "definitionId"], jtoken[(object) "status"].ToString(), (JArray) jtoken[(object) "equipped"], bool.Parse(jtoken[(object) "buyable"].ToString()));
          if (!this.itemsDictDict.ContainsKey(shopItem.itemDefinition.type))
            this.itemsDictDict.Add(shopItem.itemDefinition.type, new Dictionary<int, ShopItem>());
          if (!this.itemsDictDict[shopItem.itemDefinition.type].ContainsKey(shopItem.itemDefinition.definitionId))
            this.itemsDictDict[shopItem.itemDefinition.type].Add(shopItem.itemDefinition.definitionId, shopItem);
          if (shopItem.IsEquipped())
          {
            if (shopItem.itemDefinition.type == ShopManager.ShopItemType.avatarIcon)
              itemDefinition = shopItem.itemDefinition;
            else
              dictionary = this.AddItemToLoadoutComponent(shopItem, dictionary);
          }
          if (shopItem.itemDefinition != null)
          {
            shopItemList.Add(shopItem);
            this.playerItemDictionary.Add(shopItem.itemDefinition.definitionId, shopItem);
          }
        }
        singleEntity.ReplaceMetaLoadout(itemDefinition.definitionId, itemDefinition.icon, dictionary);
      }
      ProgressManager.OnItemsReceivedEventHandler onItemReceived = this.OnItemReceived;
      if (onItemReceived == null)
        return;
      onItemReceived();
    }

    public Dictionary<ChampionType, ChampionLoadout> AddItemToLoadoutComponent(
      ShopItem item,
      Dictionary<ChampionType, ChampionLoadout> loadoutDict)
    {
      if (item.itemDefinition.type == ShopManager.ShopItemType.avatarIcon)
        return loadoutDict;
      for (int index = 0; index < item.equipped.Length; ++index)
      {
        ChampionType champion = item.equipped[index].champion;
        if (!loadoutDict.ContainsKey(champion))
          loadoutDict.Add(champion, new ChampionLoadout(new LoadoutData())
          {
            emotes = new int[4]{ -1, -1, -1, -1 },
            sprays = new int[4]{ -1, -1, -1, -1 },
            skin = -1,
            victoryPose = -1
          });
        switch (item.itemDefinition.type)
        {
          case ShopManager.ShopItemType.spray:
            loadoutDict[champion].sprays[item.equipped[index].slot - 1] = item.itemDefinition.definitionId;
            break;
          case ShopManager.ShopItemType.skin:
            loadoutDict[champion].skin = item.itemDefinition.definitionId;
            break;
          case ShopManager.ShopItemType.emote:
            loadoutDict[champion].emotes[item.equipped[index].slot - 1] = item.itemDefinition.definitionId;
            break;
          case ShopManager.ShopItemType.victoryPose:
            loadoutDict[champion].victoryPose = item.itemDefinition.definitionId;
            break;
        }
      }
      return loadoutDict;
    }

    public void EquipAvatar(ulong gPlayerId, int definitionId) => SingletonManager<MetaServiceHelpers>.Instance.StartEquipAvatarCoroutine(gPlayerId, definitionId, new Action<JObject, int>(this.OnEquipItem));

    public delegate void OnItemsReceivedEventHandler();

    public delegate void OnShopPageReceivedEventHandler(
      ShopManager.ShopItemType itemType,
      List<ShopItem> items);

    public delegate void OnItemUnlockedEventHandler(JObject resultObj, int itemId);

    public delegate void OnItemUnlockFailureEventHandler(string errorMsg);

    public delegate void OnItemEquippedEventHandler();

    public delegate void OnPlayerAvatarChangedEventHandler(ulong playerId, int avatarItemId);

    public delegate void OnPlayerCredsUpdatedHandler(ulong playerId, int newPlayerCreds);

    public delegate void OnPlayerSteelUpdatedHandler(ulong playerId, int newPlayerSteel);

    public delegate void OnPlayerLevelUpdatedHandler(ulong playerId, int newPlayerLevel);

    public delegate void OnWeeklyShopRotationUpdatedHandler(List<ShopRotationData> shopRotationData);

    public delegate void OnChampionUnlockInfoUpdatedHandler();

    public delegate void OnTutorialProgressReceivedEventHandler(JObject obj);

    public delegate void OnDailyQuestProgressReceivedEventHandler(JObject obj);

    public delegate void OnMilestoneProgressReceivedEventHandler(JObject obj);

    public delegate void OnShopDlcListReceivedEventHandler(List<ShopBundleData> dlcData);

    public delegate void OnDlcItemListReceivedEventHanlder(
      int bundleId,
      List<ShopItem> item,
      int creditReward = 0,
      int steelReward = 0);
  }
}
