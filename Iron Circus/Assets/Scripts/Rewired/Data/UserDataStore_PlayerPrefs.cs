﻿// Decompiled with JetBrains decompiler
// Type: Rewired.Data.UserDataStore_PlayerPrefs
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Rewired.Utils.Libraries.TinyJson;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using UnityEngine;

namespace Rewired.Data
{
  public class UserDataStore_PlayerPrefs : UserDataStore
  {
    private const string thisScriptName = "UserDataStore_PlayerPrefs";
    private const string logPrefix = "Rewired: ";
    private const string editorLoadedMessage = "\n***IMPORTANT:*** Changes made to the Rewired Input Manager configuration after the last time XML data was saved WILL NOT be used because the loaded old saved data has overwritten these values. If you change something in the Rewired Input Manager such as a Joystick Map or Input Behavior settings, you will not see these changes reflected in the current configuration. Clear PlayerPrefs using the inspector option on the UserDataStore_PlayerPrefs component.";
    private const string playerPrefsKeySuffix_controllerAssignments = "ControllerAssignments";
    [Tooltip("Should this script be used? If disabled, nothing will be saved or loaded.")]
    [SerializeField]
    private bool isEnabled = true;
    [Tooltip("Should saved data be loaded on start?")]
    [SerializeField]
    private bool loadDataOnStart = true;
    [Tooltip("Should Player Joystick assignments be saved and loaded? This is not totally reliable for all Joysticks on all platforms. Some platforms/input sources do not provide enough information to reliably save assignments from session to session and reboot to reboot.")]
    [SerializeField]
    private bool loadJoystickAssignments = true;
    [Tooltip("Should Player Keyboard assignments be saved and loaded?")]
    [SerializeField]
    private bool loadKeyboardAssignments = true;
    [Tooltip("Should Player Mouse assignments be saved and loaded?")]
    [SerializeField]
    private bool loadMouseAssignments = true;
    [Tooltip("The PlayerPrefs key prefix. Change this to change how keys are stored in PlayerPrefs. Changing this will make saved data already stored with the old key no longer accessible.")]
    [SerializeField]
    private string playerPrefsKeyPrefix = "RewiredSaveData";
    [NonSerialized]
    private bool allowImpreciseJoystickAssignmentMatching = true;
    [NonSerialized]
    private bool deferredJoystickAssignmentLoadPending;
    [NonSerialized]
    private bool wasJoystickEverDetected;
    [NonSerialized]
    private List<int> __allActionIds;
    [NonSerialized]
    private string __allActionIdsString;

    public bool IsEnabled
    {
      get => this.isEnabled;
      set => this.isEnabled = value;
    }

    public bool LoadDataOnStart
    {
      get => this.loadDataOnStart;
      set => this.loadDataOnStart = value;
    }

    public bool LoadJoystickAssignments
    {
      get => this.loadJoystickAssignments;
      set => this.loadJoystickAssignments = value;
    }

    public bool LoadKeyboardAssignments
    {
      get => this.loadKeyboardAssignments;
      set => this.loadKeyboardAssignments = value;
    }

    public bool LoadMouseAssignments
    {
      get => this.loadMouseAssignments;
      set => this.loadMouseAssignments = value;
    }

    public string PlayerPrefsKeyPrefix
    {
      get => this.playerPrefsKeyPrefix;
      set => this.playerPrefsKeyPrefix = value;
    }

    private string playerPrefsKey_controllerAssignments => string.Format("{0}_{1}", (object) this.playerPrefsKeyPrefix, (object) "ControllerAssignments");

    private bool loadControllerAssignments => this.loadKeyboardAssignments || this.loadMouseAssignments || this.loadJoystickAssignments;

    private List<int> allActionIds
    {
      get
      {
        if (this.__allActionIds != null)
          return this.__allActionIds;
        List<int> intList = new List<int>();
        IList<InputAction> actions = ReInput.mapping.Actions;
        for (int index = 0; index < actions.Count; ++index)
          intList.Add(actions[index].id);
        this.__allActionIds = intList;
        return intList;
      }
    }

    private string allActionIdsString
    {
      get
      {
        if (!string.IsNullOrEmpty(this.__allActionIdsString))
          return this.__allActionIdsString;
        StringBuilder stringBuilder = new StringBuilder();
        List<int> allActionIds = this.allActionIds;
        for (int index = 0; index < allActionIds.Count; ++index)
        {
          if (index > 0)
            stringBuilder.Append(",");
          stringBuilder.Append(allActionIds[index]);
        }
        this.__allActionIdsString = stringBuilder.ToString();
        return this.__allActionIdsString;
      }
    }

    public override void Save()
    {
      if (!this.isEnabled)
        Debug.LogWarning((object) "Rewired: UserDataStore_PlayerPrefs is disabled and will not save any data.", (UnityEngine.Object) this);
      else
        this.SaveAll();
    }

    public override void SaveControllerData(
      int playerId,
      ControllerType controllerType,
      int controllerId)
    {
      if (!this.isEnabled)
        Debug.LogWarning((object) "Rewired: UserDataStore_PlayerPrefs is disabled and will not save any data.", (UnityEngine.Object) this);
      else
        this.SaveControllerDataNow(playerId, controllerType, controllerId);
    }

    public override void SaveControllerData(ControllerType controllerType, int controllerId)
    {
      if (!this.isEnabled)
        Debug.LogWarning((object) "Rewired: UserDataStore_PlayerPrefs is disabled and will not save any data.", (UnityEngine.Object) this);
      else
        this.SaveControllerDataNow(controllerType, controllerId);
    }

    public override void SavePlayerData(int playerId)
    {
      if (!this.isEnabled)
        Debug.LogWarning((object) "Rewired: UserDataStore_PlayerPrefs is disabled and will not save any data.", (UnityEngine.Object) this);
      else
        this.SavePlayerDataNow(playerId);
    }

    public override void SaveInputBehavior(int playerId, int behaviorId)
    {
      if (!this.isEnabled)
        Debug.LogWarning((object) "Rewired: UserDataStore_PlayerPrefs is disabled and will not save any data.", (UnityEngine.Object) this);
      else
        this.SaveInputBehaviorNow(playerId, behaviorId);
    }

    public override void Load()
    {
      if (!this.isEnabled)
        Debug.LogWarning((object) "Rewired: UserDataStore_PlayerPrefs is disabled and will not load any data.", (UnityEngine.Object) this);
      else
        this.LoadAll();
    }

    public override void LoadControllerData(
      int playerId,
      ControllerType controllerType,
      int controllerId)
    {
      if (!this.isEnabled)
        Debug.LogWarning((object) "Rewired: UserDataStore_PlayerPrefs is disabled and will not load any data.", (UnityEngine.Object) this);
      else
        this.LoadControllerDataNow(playerId, controllerType, controllerId);
    }

    public override void LoadControllerData(ControllerType controllerType, int controllerId)
    {
      if (!this.isEnabled)
        Debug.LogWarning((object) "Rewired: UserDataStore_PlayerPrefs is disabled and will not load any data.", (UnityEngine.Object) this);
      else
        this.LoadControllerDataNow(controllerType, controllerId);
    }

    public override void LoadPlayerData(int playerId)
    {
      if (!this.isEnabled)
        Debug.LogWarning((object) "Rewired: UserDataStore_PlayerPrefs is disabled and will not load any data.", (UnityEngine.Object) this);
      else
        this.LoadPlayerDataNow(playerId);
    }

    public override void LoadInputBehavior(int playerId, int behaviorId)
    {
      if (!this.isEnabled)
        Debug.LogWarning((object) "Rewired: UserDataStore_PlayerPrefs is disabled and will not load any data.", (UnityEngine.Object) this);
      else
        this.LoadInputBehaviorNow(playerId, behaviorId);
    }

    protected override void OnInitialize()
    {
      if (!this.loadDataOnStart)
        return;
      this.Load();
      if (!this.loadControllerAssignments || ReInput.controllers.joystickCount <= 0)
        return;
      this.SaveControllerAssignments();
    }

    protected override void OnControllerConnected(ControllerStatusChangedEventArgs args)
    {
      if (!this.isEnabled || args.controllerType != ControllerType.Joystick)
        return;
      this.LoadJoystickData(args.controllerId);
      if (this.loadDataOnStart && this.loadJoystickAssignments && !this.wasJoystickEverDetected)
        this.StartCoroutine(this.LoadJoystickAssignmentsDeferred());
      if (this.loadJoystickAssignments && !this.deferredJoystickAssignmentLoadPending)
        this.SaveControllerAssignments();
      this.wasJoystickEverDetected = true;
    }

    protected override void OnControllerPreDisconnect(ControllerStatusChangedEventArgs args)
    {
      if (!this.isEnabled || args.controllerType != ControllerType.Joystick)
        return;
      this.SaveJoystickData(args.controllerId);
    }

    protected override void OnControllerDisconnected(ControllerStatusChangedEventArgs args)
    {
      if (!this.isEnabled || !this.loadControllerAssignments)
        return;
      this.SaveControllerAssignments();
    }

    public override void SaveControllerMap(int playerId, ControllerMap controllerMap)
    {
      if (controllerMap == null)
        return;
      Player player = ReInput.players.GetPlayer(playerId);
      if (player == null)
        return;
      this.SaveControllerMap(player, controllerMap);
    }

    public override ControllerMap LoadControllerMap(
      int playerId,
      ControllerIdentifier controllerIdentifier,
      int categoryId,
      int layoutId)
    {
      Player player = ReInput.players.GetPlayer(playerId);
      if (player == null)
        return (ControllerMap) null;
      Controller controller = ReInput.controllers.GetController(controllerIdentifier);
      return controller == null ? (ControllerMap) null : this.LoadControllerMap(player, controller, categoryId, layoutId);
    }

    private int LoadAll()
    {
      int num = 0;
      if (this.loadControllerAssignments && this.LoadControllerAssignmentsNow())
        ++num;
      IList<Player> allPlayers = ReInput.players.AllPlayers;
      for (int index = 0; index < allPlayers.Count; ++index)
        num += this.LoadPlayerDataNow(allPlayers[index]);
      return num + this.LoadAllJoystickCalibrationData();
    }

    private int LoadPlayerDataNow(int playerId) => this.LoadPlayerDataNow(ReInput.players.GetPlayer(playerId));

    private int LoadPlayerDataNow(Player player)
    {
      if (player == null)
        return 0;
      int num = 0 + this.LoadInputBehaviors(player.id) + this.LoadControllerMaps(player.id, ControllerType.Keyboard, 0) + this.LoadControllerMaps(player.id, ControllerType.Mouse, 0);
      foreach (Joystick joystick in (IEnumerable<Joystick>) player.controllers.Joysticks)
        num += this.LoadControllerMaps(player.id, ControllerType.Joystick, joystick.id);
      this.RefreshLayoutManager(player.id);
      return num;
    }

    private int LoadAllJoystickCalibrationData()
    {
      int num = 0;
      IList<Joystick> joysticks = ReInput.controllers.Joysticks;
      for (int index = 0; index < joysticks.Count; ++index)
        num += this.LoadJoystickCalibrationData(joysticks[index]);
      return num;
    }

    private int LoadJoystickCalibrationData(Joystick joystick) => joystick == null || !joystick.ImportCalibrationMapFromXmlString(this.GetJoystickCalibrationMapXml(joystick)) ? 0 : 1;

    private int LoadJoystickCalibrationData(int joystickId) => this.LoadJoystickCalibrationData(ReInput.controllers.GetJoystick(joystickId));

    private int LoadJoystickData(int joystickId)
    {
      int num = 0;
      IList<Player> allPlayers = ReInput.players.AllPlayers;
      for (int index = 0; index < allPlayers.Count; ++index)
      {
        Player player = allPlayers[index];
        if (player.controllers.ContainsController(ControllerType.Joystick, joystickId))
        {
          num += this.LoadControllerMaps(player.id, ControllerType.Joystick, joystickId);
          this.RefreshLayoutManager(player.id);
        }
      }
      return num + this.LoadJoystickCalibrationData(joystickId);
    }

    private int LoadControllerDataNow(
      int playerId,
      ControllerType controllerType,
      int controllerId)
    {
      int num1 = 0 + this.LoadControllerMaps(playerId, controllerType, controllerId);
      this.RefreshLayoutManager(playerId);
      int num2 = this.LoadControllerDataNow(controllerType, controllerId);
      return num1 + num2;
    }

    private int LoadControllerDataNow(ControllerType controllerType, int controllerId)
    {
      int num = 0;
      if (controllerType == ControllerType.Joystick)
        num += this.LoadJoystickCalibrationData(controllerId);
      return num;
    }

    private int LoadControllerMaps(int playerId, ControllerType controllerType, int controllerId)
    {
      int num = 0;
      Player player = ReInput.players.GetPlayer(playerId);
      if (player == null)
        return num;
      Controller controller = ReInput.controllers.GetController(controllerType, controllerId);
      if (controller == null)
        return num;
      IList<InputMapCategory> mapCategories = ReInput.mapping.MapCategories;
      for (int index1 = 0; index1 < mapCategories.Count; ++index1)
      {
        InputMapCategory inputMapCategory = mapCategories[index1];
        if (inputMapCategory.userAssignable)
        {
          IList<InputLayout> inputLayoutList = ReInput.mapping.MapLayouts(controller.type);
          for (int index2 = 0; index2 < inputLayoutList.Count; ++index2)
          {
            InputLayout inputLayout = inputLayoutList[index2];
            ControllerMap map = this.LoadControllerMap(player, controller, inputMapCategory.id, inputLayout.id);
            if (map != null)
            {
              player.controllers.maps.AddMap(controller, map);
              ++num;
            }
          }
        }
      }
      return num;
    }

    private ControllerMap LoadControllerMap(
      Player player,
      Controller controller,
      int categoryId,
      int layoutId)
    {
      if (player == null || controller == null)
        return (ControllerMap) null;
      string controllerMapXml = this.GetControllerMapXml(player, controller, categoryId, layoutId);
      if (string.IsNullOrEmpty(controllerMapXml))
        return (ControllerMap) null;
      ControllerMap fromXml = ControllerMap.CreateFromXml(controller.type, controllerMapXml);
      if (fromXml == null)
        return (ControllerMap) null;
      List<int> mapKnownActionIds = this.GetControllerMapKnownActionIds(player, controller, categoryId, layoutId);
      this.AddDefaultMappingsForNewActions(fromXml, mapKnownActionIds);
      return fromXml;
    }

    private int LoadInputBehaviors(int playerId)
    {
      Player player = ReInput.players.GetPlayer(playerId);
      if (player == null)
        return 0;
      int num = 0;
      IList<InputBehavior> inputBehaviors = ReInput.mapping.GetInputBehaviors(player.id);
      for (int index = 0; index < inputBehaviors.Count; ++index)
        num += this.LoadInputBehaviorNow(player, inputBehaviors[index]);
      return num;
    }

    private int LoadInputBehaviorNow(int playerId, int behaviorId)
    {
      Player player = ReInput.players.GetPlayer(playerId);
      if (player == null)
        return 0;
      InputBehavior inputBehavior = ReInput.mapping.GetInputBehavior(playerId, behaviorId);
      return inputBehavior == null ? 0 : this.LoadInputBehaviorNow(player, inputBehavior);
    }

    private int LoadInputBehaviorNow(Player player, InputBehavior inputBehavior)
    {
      if (player == null || inputBehavior == null)
        return 0;
      string inputBehaviorXml = this.GetInputBehaviorXml(player, inputBehavior.id);
      return inputBehaviorXml == null || inputBehaviorXml == string.Empty || !inputBehavior.ImportXmlString(inputBehaviorXml) ? 0 : 1;
    }

    private bool LoadControllerAssignmentsNow()
    {
      try
      {
        UserDataStore_PlayerPrefs.ControllerAssignmentSaveInfo data = this.LoadControllerAssignmentData();
        if (data == null)
          return false;
        if (this.loadKeyboardAssignments || this.loadMouseAssignments)
          this.LoadKeyboardAndMouseAssignmentsNow(data);
        if (this.loadJoystickAssignments)
          this.LoadJoystickAssignmentsNow(data);
      }
      catch
      {
      }
      return true;
    }

    private bool LoadKeyboardAndMouseAssignmentsNow(
      UserDataStore_PlayerPrefs.ControllerAssignmentSaveInfo data)
    {
      try
      {
        if (data == null && (data = this.LoadControllerAssignmentData()) == null)
          return false;
        foreach (Player allPlayer in (IEnumerable<Player>) ReInput.players.AllPlayers)
        {
          if (data.ContainsPlayer(allPlayer.id))
          {
            UserDataStore_PlayerPrefs.ControllerAssignmentSaveInfo.PlayerInfo player = data.players[data.IndexOfPlayer(allPlayer.id)];
            if (this.loadKeyboardAssignments)
              allPlayer.controllers.hasKeyboard = player.hasKeyboard;
            if (this.loadMouseAssignments)
              allPlayer.controllers.hasMouse = player.hasMouse;
          }
        }
      }
      catch
      {
      }
      return true;
    }

    private bool LoadJoystickAssignmentsNow(
      UserDataStore_PlayerPrefs.ControllerAssignmentSaveInfo data)
    {
      try
      {
        if (ReInput.controllers.joystickCount == 0 || data == null && (data = this.LoadControllerAssignmentData()) == null)
          return false;
        foreach (Player allPlayer in (IEnumerable<Player>) ReInput.players.AllPlayers)
          allPlayer.controllers.ClearControllersOfType(ControllerType.Joystick);
        List<UserDataStore_PlayerPrefs.JoystickAssignmentHistoryInfo> assignmentHistoryInfoList = this.loadJoystickAssignments ? new List<UserDataStore_PlayerPrefs.JoystickAssignmentHistoryInfo>() : (List<UserDataStore_PlayerPrefs.JoystickAssignmentHistoryInfo>) null;
        foreach (Player allPlayer in (IEnumerable<Player>) ReInput.players.AllPlayers)
        {
          if (data.ContainsPlayer(allPlayer.id))
          {
            UserDataStore_PlayerPrefs.ControllerAssignmentSaveInfo.PlayerInfo player = data.players[data.IndexOfPlayer(allPlayer.id)];
            for (int index = 0; index < player.joystickCount; ++index)
            {
              UserDataStore_PlayerPrefs.ControllerAssignmentSaveInfo.JoystickInfo joystick1 = player.joysticks[index];
              if (joystick1 != null)
              {
                Joystick joystick = this.FindJoystickPrecise(joystick1);
                if (joystick != null)
                {
                  if (assignmentHistoryInfoList.Find((Predicate<UserDataStore_PlayerPrefs.JoystickAssignmentHistoryInfo>) (x => x.joystick == joystick)) == null)
                    assignmentHistoryInfoList.Add(new UserDataStore_PlayerPrefs.JoystickAssignmentHistoryInfo(joystick, joystick1.id));
                  allPlayer.controllers.AddController((Controller) joystick, false);
                }
              }
            }
          }
        }
        if (this.allowImpreciseJoystickAssignmentMatching)
        {
          foreach (Player allPlayer in (IEnumerable<Player>) ReInput.players.AllPlayers)
          {
            if (data.ContainsPlayer(allPlayer.id))
            {
              UserDataStore_PlayerPrefs.ControllerAssignmentSaveInfo.PlayerInfo player = data.players[data.IndexOfPlayer(allPlayer.id)];
              for (int index1 = 0; index1 < player.joystickCount; ++index1)
              {
                UserDataStore_PlayerPrefs.ControllerAssignmentSaveInfo.JoystickInfo joystickInfo = player.joysticks[index1];
                if (joystickInfo != null)
                {
                  Joystick joystick2 = (Joystick) null;
                  int index2 = assignmentHistoryInfoList.FindIndex((Predicate<UserDataStore_PlayerPrefs.JoystickAssignmentHistoryInfo>) (x => x.oldJoystickId == joystickInfo.id));
                  if (index2 >= 0)
                  {
                    joystick2 = assignmentHistoryInfoList[index2].joystick;
                  }
                  else
                  {
                    List<Joystick> matches;
                    if (this.TryFindJoysticksImprecise(joystickInfo, out matches))
                    {
                      foreach (Joystick joystick3 in matches)
                      {
                        Joystick match = joystick3;
                        if (assignmentHistoryInfoList.Find((Predicate<UserDataStore_PlayerPrefs.JoystickAssignmentHistoryInfo>) (x => x.joystick == match)) == null)
                        {
                          joystick2 = match;
                          break;
                        }
                      }
                      if (joystick2 != null)
                        assignmentHistoryInfoList.Add(new UserDataStore_PlayerPrefs.JoystickAssignmentHistoryInfo(joystick2, joystickInfo.id));
                      else
                        continue;
                    }
                    else
                      continue;
                  }
                  allPlayer.controllers.AddController((Controller) joystick2, false);
                }
              }
            }
          }
        }
      }
      catch
      {
      }
      if (ReInput.configuration.autoAssignJoysticks)
        ReInput.controllers.AutoAssignJoysticks();
      return true;
    }

    private UserDataStore_PlayerPrefs.ControllerAssignmentSaveInfo LoadControllerAssignmentData()
    {
      try
      {
        if (!PlayerPrefs.HasKey(this.playerPrefsKey_controllerAssignments))
          return (UserDataStore_PlayerPrefs.ControllerAssignmentSaveInfo) null;
        string json = PlayerPrefs.GetString(this.playerPrefsKey_controllerAssignments);
        if (string.IsNullOrEmpty(json))
          return (UserDataStore_PlayerPrefs.ControllerAssignmentSaveInfo) null;
        UserDataStore_PlayerPrefs.ControllerAssignmentSaveInfo assignmentSaveInfo = JsonParser.FromJson<UserDataStore_PlayerPrefs.ControllerAssignmentSaveInfo>(json);
        return assignmentSaveInfo == null || assignmentSaveInfo.playerCount == 0 ? (UserDataStore_PlayerPrefs.ControllerAssignmentSaveInfo) null : assignmentSaveInfo;
      }
      catch
      {
        return (UserDataStore_PlayerPrefs.ControllerAssignmentSaveInfo) null;
      }
    }

    private IEnumerator LoadJoystickAssignmentsDeferred()
    {
      this.deferredJoystickAssignmentLoadPending = true;
      yield return (object) new WaitForEndOfFrame();
      if (ReInput.isReady)
      {
        this.LoadJoystickAssignmentsNow((UserDataStore_PlayerPrefs.ControllerAssignmentSaveInfo) null);
        this.SaveControllerAssignments();
        this.deferredJoystickAssignmentLoadPending = false;
      }
    }

    private void SaveAll()
    {
      IList<Player> allPlayers = ReInput.players.AllPlayers;
      for (int index = 0; index < allPlayers.Count; ++index)
        this.SavePlayerDataNow(allPlayers[index]);
      this.SaveAllJoystickCalibrationData();
      if (this.loadControllerAssignments)
        this.SaveControllerAssignments();
      PlayerPrefs.Save();
    }

    private void SavePlayerDataNow(int playerId)
    {
      this.SavePlayerDataNow(ReInput.players.GetPlayer(playerId));
      PlayerPrefs.Save();
    }

    private void SavePlayerDataNow(Player player)
    {
      if (player == null)
        return;
      PlayerSaveData saveData = player.GetSaveData(true);
      this.SaveInputBehaviors(player, saveData);
      this.SaveControllerMaps(player, saveData);
    }

    private void SaveAllJoystickCalibrationData()
    {
      IList<Joystick> joysticks = ReInput.controllers.Joysticks;
      for (int index = 0; index < joysticks.Count; ++index)
        this.SaveJoystickCalibrationData(joysticks[index]);
    }

    private void SaveJoystickCalibrationData(int joystickId) => this.SaveJoystickCalibrationData(ReInput.controllers.GetJoystick(joystickId));

    private void SaveJoystickCalibrationData(Joystick joystick)
    {
      if (joystick == null)
        return;
      JoystickCalibrationMapSaveData calibrationMapSaveData = joystick.GetCalibrationMapSaveData();
      PlayerPrefs.SetString(this.GetJoystickCalibrationMapPlayerPrefsKey(joystick), calibrationMapSaveData.map.ToXmlString());
    }

    private void SaveJoystickData(int joystickId)
    {
      IList<Player> allPlayers = ReInput.players.AllPlayers;
      for (int index = 0; index < allPlayers.Count; ++index)
      {
        Player player = allPlayers[index];
        if (player.controllers.ContainsController(ControllerType.Joystick, joystickId))
          this.SaveControllerMaps(player.id, ControllerType.Joystick, joystickId);
      }
      this.SaveJoystickCalibrationData(joystickId);
    }

    private void SaveControllerDataNow(
      int playerId,
      ControllerType controllerType,
      int controllerId)
    {
      this.SaveControllerMaps(playerId, controllerType, controllerId);
      this.SaveControllerDataNow(controllerType, controllerId);
      PlayerPrefs.Save();
    }

    private void SaveControllerDataNow(ControllerType controllerType, int controllerId)
    {
      if (controllerType == ControllerType.Joystick)
        this.SaveJoystickCalibrationData(controllerId);
      PlayerPrefs.Save();
    }

    private void SaveControllerMaps(Player player, PlayerSaveData playerSaveData)
    {
      foreach (ControllerMapSaveData controllerMapSaveData in playerSaveData.AllControllerMapSaveData)
        this.SaveControllerMap(player, controllerMapSaveData.map);
    }

    private void SaveControllerMaps(int playerId, ControllerType controllerType, int controllerId)
    {
      Player player = ReInput.players.GetPlayer(playerId);
      if (player == null || !player.controllers.ContainsController(controllerType, controllerId))
        return;
      ControllerMapSaveData[] mapSaveData = player.controllers.maps.GetMapSaveData(controllerType, controllerId, true);
      if (mapSaveData == null)
        return;
      for (int index = 0; index < mapSaveData.Length; ++index)
        this.SaveControllerMap(player, mapSaveData[index].map);
    }

    private void SaveControllerMap(Player player, ControllerMap controllerMap)
    {
      PlayerPrefs.SetString(this.GetControllerMapPlayerPrefsKey(player, controllerMap.controller, controllerMap.categoryId, controllerMap.layoutId, true), controllerMap.ToXmlString());
      PlayerPrefs.SetString(this.GetControllerMapKnownActionIdsPlayerPrefsKey(player, controllerMap.controller, controllerMap.categoryId, controllerMap.layoutId, true), this.allActionIdsString);
    }

    private void SaveInputBehaviors(Player player, PlayerSaveData playerSaveData)
    {
      if (player == null)
        return;
      foreach (InputBehavior inputBehavior in playerSaveData.inputBehaviors)
        this.SaveInputBehaviorNow(player, inputBehavior);
    }

    private void SaveInputBehaviorNow(int playerId, int behaviorId)
    {
      Player player = ReInput.players.GetPlayer(playerId);
      if (player == null)
        return;
      InputBehavior inputBehavior = ReInput.mapping.GetInputBehavior(playerId, behaviorId);
      if (inputBehavior == null)
        return;
      this.SaveInputBehaviorNow(player, inputBehavior);
      PlayerPrefs.Save();
    }

    private void SaveInputBehaviorNow(Player player, InputBehavior inputBehavior)
    {
      if (player == null || inputBehavior == null)
        return;
      PlayerPrefs.SetString(this.GetInputBehaviorPlayerPrefsKey(player, inputBehavior.id), inputBehavior.ToXmlString());
    }

    private bool SaveControllerAssignments()
    {
      try
      {
        UserDataStore_PlayerPrefs.ControllerAssignmentSaveInfo assignmentSaveInfo = new UserDataStore_PlayerPrefs.ControllerAssignmentSaveInfo(ReInput.players.allPlayerCount);
        for (int index1 = 0; index1 < ReInput.players.allPlayerCount; ++index1)
        {
          Player allPlayer = ReInput.players.AllPlayers[index1];
          UserDataStore_PlayerPrefs.ControllerAssignmentSaveInfo.PlayerInfo playerInfo = new UserDataStore_PlayerPrefs.ControllerAssignmentSaveInfo.PlayerInfo();
          assignmentSaveInfo.players[index1] = playerInfo;
          playerInfo.id = allPlayer.id;
          playerInfo.hasKeyboard = allPlayer.controllers.hasKeyboard;
          playerInfo.hasMouse = allPlayer.controllers.hasMouse;
          UserDataStore_PlayerPrefs.ControllerAssignmentSaveInfo.JoystickInfo[] joystickInfoArray = new UserDataStore_PlayerPrefs.ControllerAssignmentSaveInfo.JoystickInfo[allPlayer.controllers.joystickCount];
          playerInfo.joysticks = joystickInfoArray;
          for (int index2 = 0; index2 < allPlayer.controllers.joystickCount; ++index2)
          {
            Joystick joystick = allPlayer.controllers.Joysticks[index2];
            joystickInfoArray[index2] = new UserDataStore_PlayerPrefs.ControllerAssignmentSaveInfo.JoystickInfo()
            {
              instanceGuid = joystick.deviceInstanceGuid,
              id = joystick.id,
              hardwareIdentifier = joystick.hardwareIdentifier
            };
          }
        }
        PlayerPrefs.SetString(this.playerPrefsKey_controllerAssignments, JsonWriter.ToJson((object) assignmentSaveInfo));
        PlayerPrefs.Save();
      }
      catch
      {
      }
      return true;
    }

    private bool ControllerAssignmentSaveDataExists() => PlayerPrefs.HasKey(this.playerPrefsKey_controllerAssignments) && !string.IsNullOrEmpty(PlayerPrefs.GetString(this.playerPrefsKey_controllerAssignments));

    private string GetBasePlayerPrefsKey(Player player) => this.playerPrefsKeyPrefix + "|playerName=" + player.name;

    private string GetControllerMapPlayerPrefsKey(
      Player player,
      Controller controller,
      int categoryId,
      int layoutId,
      bool includeDuplicateIndex)
    {
      string str = this.GetBasePlayerPrefsKey(player) + "|dataType=ControllerMap" + "|controllerMapType=" + controller.mapTypeString + "|categoryId=" + (object) categoryId + "|layoutId=" + (object) layoutId + "|hardwareIdentifier=" + controller.hardwareIdentifier;
      if (controller.type == ControllerType.Joystick)
      {
        str = str + "|hardwareGuid=" + controller.hardwareTypeGuid.ToString();
        if (includeDuplicateIndex)
          str = str + "|duplicate=" + UserDataStore_PlayerPrefs.GetDuplicateIndex(player, controller).ToString();
      }
      return str;
    }

    private string GetControllerMapKnownActionIdsPlayerPrefsKey(
      Player player,
      Controller controller,
      int categoryId,
      int layoutId,
      bool includeDuplicateIndex)
    {
      string str = this.GetBasePlayerPrefsKey(player) + "|dataType=ControllerMap_KnownActionIds" + "|controllerMapType=" + controller.mapTypeString + "|categoryId=" + (object) categoryId + "|layoutId=" + (object) layoutId + "|hardwareIdentifier=" + controller.hardwareIdentifier;
      if (controller.type == ControllerType.Joystick)
      {
        str = str + "|hardwareGuid=" + controller.hardwareTypeGuid.ToString();
        if (includeDuplicateIndex)
          str = str + "|duplicate=" + UserDataStore_PlayerPrefs.GetDuplicateIndex(player, controller).ToString();
      }
      return str;
    }

    private string GetJoystickCalibrationMapPlayerPrefsKey(Joystick joystick) => this.playerPrefsKeyPrefix + "|dataType=CalibrationMap" + "|controllerType=" + joystick.type.ToString() + "|hardwareIdentifier=" + joystick.hardwareIdentifier + "|hardwareGuid=" + joystick.hardwareTypeGuid.ToString();

    private string GetInputBehaviorPlayerPrefsKey(Player player, int inputBehaviorId) => this.GetBasePlayerPrefsKey(player) + "|dataType=InputBehavior" + "|id=" + (object) inputBehaviorId;

    private string GetControllerMapXml(
      Player player,
      Controller controller,
      int categoryId,
      int layoutId)
    {
      string mapPlayerPrefsKey = this.GetControllerMapPlayerPrefsKey(player, controller, categoryId, layoutId, true);
      if (!PlayerPrefs.HasKey(mapPlayerPrefsKey))
      {
        if (controller.type != ControllerType.Joystick)
          return string.Empty;
        mapPlayerPrefsKey = this.GetControllerMapPlayerPrefsKey(player, controller, categoryId, layoutId, false);
        if (!PlayerPrefs.HasKey(mapPlayerPrefsKey))
          return string.Empty;
      }
      return PlayerPrefs.GetString(mapPlayerPrefsKey);
    }

    private List<int> GetControllerMapKnownActionIds(
      Player player,
      Controller controller,
      int categoryId,
      int layoutId)
    {
      List<int> intList = new List<int>();
      string idsPlayerPrefsKey = this.GetControllerMapKnownActionIdsPlayerPrefsKey(player, controller, categoryId, layoutId, true);
      if (!PlayerPrefs.HasKey(idsPlayerPrefsKey))
      {
        if (controller.type != ControllerType.Joystick)
          return intList;
        idsPlayerPrefsKey = this.GetControllerMapKnownActionIdsPlayerPrefsKey(player, controller, categoryId, layoutId, false);
        if (!PlayerPrefs.HasKey(idsPlayerPrefsKey))
          return intList;
      }
      string str = PlayerPrefs.GetString(idsPlayerPrefsKey);
      if (string.IsNullOrEmpty(str))
        return intList;
      string[] strArray = str.Split(',');
      for (int index = 0; index < strArray.Length; ++index)
      {
        int result;
        if (!string.IsNullOrEmpty(strArray[index]) && int.TryParse(strArray[index], out result))
          intList.Add(result);
      }
      return intList;
    }

    private string GetJoystickCalibrationMapXml(Joystick joystick)
    {
      string mapPlayerPrefsKey = this.GetJoystickCalibrationMapPlayerPrefsKey(joystick);
      return !PlayerPrefs.HasKey(mapPlayerPrefsKey) ? string.Empty : PlayerPrefs.GetString(mapPlayerPrefsKey);
    }

    private string GetInputBehaviorXml(Player player, int id)
    {
      string behaviorPlayerPrefsKey = this.GetInputBehaviorPlayerPrefsKey(player, id);
      return !PlayerPrefs.HasKey(behaviorPlayerPrefsKey) ? string.Empty : PlayerPrefs.GetString(behaviorPlayerPrefsKey);
    }

    private void AddDefaultMappingsForNewActions(
      ControllerMap controllerMap,
      List<int> knownActionIds)
    {
      if (controllerMap == null || knownActionIds == null || knownActionIds == null || knownActionIds.Count == 0)
        return;
      ControllerMap controllerMapInstance = ReInput.mapping.GetControllerMapInstance(controllerMap.controller, controllerMap.categoryId, controllerMap.layoutId);
      if (controllerMapInstance == null)
        return;
      List<int> intList = new List<int>();
      foreach (int allActionId in this.allActionIds)
      {
        if (!knownActionIds.Contains(allActionId))
          intList.Add(allActionId);
      }
      if (intList.Count == 0)
        return;
      foreach (ActionElementMap allMap in (IEnumerable<ActionElementMap>) controllerMapInstance.AllMaps)
      {
        if (intList.Contains(allMap.actionId) && !controllerMap.DoesElementAssignmentConflict(allMap))
        {
          ElementAssignment elementAssignment = new ElementAssignment(controllerMap.controllerType, allMap.elementType, allMap.elementIdentifierId, allMap.axisRange, allMap.keyCode, allMap.modifierKeyFlags, allMap.actionId, allMap.axisContribution, allMap.invert);
          controllerMap.CreateElementMap(elementAssignment);
        }
      }
    }

    private Joystick FindJoystickPrecise(
      UserDataStore_PlayerPrefs.ControllerAssignmentSaveInfo.JoystickInfo joystickInfo)
    {
      if (joystickInfo == null)
        return (Joystick) null;
      if (joystickInfo.instanceGuid == Guid.Empty)
        return (Joystick) null;
      IList<Joystick> joysticks = ReInput.controllers.Joysticks;
      for (int index = 0; index < joysticks.Count; ++index)
      {
        if (joysticks[index].deviceInstanceGuid == joystickInfo.instanceGuid)
          return joysticks[index];
      }
      return (Joystick) null;
    }

    private bool TryFindJoysticksImprecise(
      UserDataStore_PlayerPrefs.ControllerAssignmentSaveInfo.JoystickInfo joystickInfo,
      out List<Joystick> matches)
    {
      matches = (List<Joystick>) null;
      if (joystickInfo == null || string.IsNullOrEmpty(joystickInfo.hardwareIdentifier))
        return false;
      IList<Joystick> joysticks = ReInput.controllers.Joysticks;
      for (int index = 0; index < joysticks.Count; ++index)
      {
        if (string.Equals(joysticks[index].hardwareIdentifier, joystickInfo.hardwareIdentifier, StringComparison.OrdinalIgnoreCase))
        {
          if (matches == null)
            matches = new List<Joystick>();
          matches.Add(joysticks[index]);
        }
      }
      return matches != null;
    }

    private static int GetDuplicateIndex(Player player, Controller controller)
    {
      int num = 0;
      foreach (Controller controller1 in player.controllers.Controllers)
      {
        if (controller1.type == controller.type)
        {
          bool flag = false;
          if (controller.type == ControllerType.Joystick)
          {
            if (!((controller1 as Joystick).hardwareTypeGuid != (controller as Joystick).hardwareTypeGuid))
            {
              if ((controller as Joystick).hardwareTypeGuid != Guid.Empty)
                flag = true;
            }
            else
              continue;
          }
          if (flag || !(controller1.hardwareIdentifier != controller.hardwareIdentifier))
          {
            if (controller1 == controller)
              return num;
            ++num;
          }
        }
      }
      return num;
    }

    private void RefreshLayoutManager(int playerId) => ReInput.players.GetPlayer(playerId)?.controllers.maps.layoutManager.Apply();

    private class ControllerAssignmentSaveInfo
    {
      public UserDataStore_PlayerPrefs.ControllerAssignmentSaveInfo.PlayerInfo[] players;

      public int playerCount => this.players == null ? 0 : this.players.Length;

      public ControllerAssignmentSaveInfo()
      {
      }

      public ControllerAssignmentSaveInfo(int playerCount)
      {
        this.players = new UserDataStore_PlayerPrefs.ControllerAssignmentSaveInfo.PlayerInfo[playerCount];
        for (int index = 0; index < playerCount; ++index)
          this.players[index] = new UserDataStore_PlayerPrefs.ControllerAssignmentSaveInfo.PlayerInfo();
      }

      public int IndexOfPlayer(int playerId)
      {
        for (int index = 0; index < this.playerCount; ++index)
        {
          if (this.players[index] != null && this.players[index].id == playerId)
            return index;
        }
        return -1;
      }

      public bool ContainsPlayer(int playerId) => this.IndexOfPlayer(playerId) >= 0;

      public class PlayerInfo
      {
        public int id;
        public bool hasKeyboard;
        public bool hasMouse;
        public UserDataStore_PlayerPrefs.ControllerAssignmentSaveInfo.JoystickInfo[] joysticks;

        public int joystickCount => this.joysticks == null ? 0 : this.joysticks.Length;

        public int IndexOfJoystick(int joystickId)
        {
          for (int index = 0; index < this.joystickCount; ++index)
          {
            if (this.joysticks[index] != null && this.joysticks[index].id == joystickId)
              return index;
          }
          return -1;
        }

        public bool ContainsJoystick(int joystickId) => this.IndexOfJoystick(joystickId) >= 0;
      }

      public class JoystickInfo
      {
        public Guid instanceGuid;
        public string hardwareIdentifier;
        public int id;
      }
    }

    private class JoystickAssignmentHistoryInfo
    {
      public readonly Joystick joystick;
      public readonly int oldJoystickId;

      public JoystickAssignmentHistoryInfo(Joystick joystick, int oldJoystickId)
      {
        this.joystick = joystick != null ? joystick : throw new ArgumentNullException(nameof (joystick));
        this.oldJoystickId = oldJoystickId;
      }
    }
  }
}
