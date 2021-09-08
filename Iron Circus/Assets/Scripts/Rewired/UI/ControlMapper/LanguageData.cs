// Decompiled with JetBrains decompiler
// Type: Rewired.UI.ControlMapper.LanguageData
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Collections.Generic;
using UnityEngine;

namespace Rewired.UI.ControlMapper
{
  public class LanguageData : ScriptableObject
  {
    [SerializeField]
    private string _yes = "Yes";
    [SerializeField]
    private string _no = "No";
    [SerializeField]
    private string _add = "Add";
    [SerializeField]
    private string _replace = "Replace";
    [SerializeField]
    private string _remove = "Remove";
    [SerializeField]
    private string _swap = "Swap";
    [SerializeField]
    private string _cancel = "Cancel";
    [SerializeField]
    private string _none = "None";
    [SerializeField]
    private string _okay = "Okay";
    [SerializeField]
    private string _done = "Done";
    [SerializeField]
    private string _default = "Default";
    [SerializeField]
    private string _assignControllerWindowTitle = "Choose Controller";
    [SerializeField]
    private string _assignControllerWindowMessage = "Press any button or move an axis on the controller you would like to use.";
    [SerializeField]
    private string _controllerAssignmentConflictWindowTitle = "Controller Assignment";
    [SerializeField]
    [Tooltip("{0} = Joystick Name\n{1} = Other Player Name\n{2} = This Player Name")]
    private string _controllerAssignmentConflictWindowMessage = "{0} is already assigned to {1}. Do you want to assign this controller to {2} instead?";
    [SerializeField]
    private string _elementAssignmentPrePollingWindowMessage = "First center or zero all sticks and axes and press any button or wait for the timer to finish.";
    [SerializeField]
    [Tooltip("{0} = Action Name")]
    private string _joystickElementAssignmentPollingWindowMessage = "Now press a button or move an axis to assign it to {0}.";
    [SerializeField]
    [Tooltip("This text is only displayed when split-axis fields have been disabled and the user clicks on the full-axis field. Button/key/D-pad input cannot be assigned to a full-axis field.\n{0} = Action Name")]
    private string _joystickElementAssignmentPollingWindowMessage_fullAxisFieldOnly = "Now move an axis to assign it to {0}.";
    [SerializeField]
    [Tooltip("{0} = Action Name")]
    private string _keyboardElementAssignmentPollingWindowMessage = "Press a key to assign it to {0}. Modifier keys may also be used. To assign a modifier key alone, hold it down for 1 second.";
    [SerializeField]
    [Tooltip("{0} = Action Name")]
    private string _mouseElementAssignmentPollingWindowMessage = "Press a mouse button or move an axis to assign it to {0}.";
    [SerializeField]
    [Tooltip("This text is only displayed when split-axis fields have been disabled and the user clicks on the full-axis field. Button/key/D-pad input cannot be assigned to a full-axis field.\n{0} = Action Name")]
    private string _mouseElementAssignmentPollingWindowMessage_fullAxisFieldOnly = "Move an axis to assign it to {0}.";
    [SerializeField]
    private string _elementAssignmentConflictWindowMessage = "Assignment Conflict";
    [SerializeField]
    [Tooltip("{0} = Element Name")]
    private string _elementAlreadyInUseBlocked = "{0} is already in use cannot be replaced.";
    [SerializeField]
    [Tooltip("{0} = Element Name")]
    private string _elementAlreadyInUseCanReplace = "{0} is already in use. Do you want to replace it?";
    [SerializeField]
    [Tooltip("{0} = Element Name")]
    private string _elementAlreadyInUseCanReplace_conflictAllowed = "{0} is already in use. Do you want to replace it? You may also choose to add the assignment anyway.";
    [SerializeField]
    private string _mouseAssignmentConflictWindowTitle = "Mouse Assignment";
    [SerializeField]
    [Tooltip("{0} = Other Player Name\n{1} = This Player Name")]
    private string _mouseAssignmentConflictWindowMessage = "The mouse is already assigned to {0}. Do you want to assign the mouse to {1} instead?";
    [SerializeField]
    private string _calibrateControllerWindowTitle = "Calibrate Controller";
    [SerializeField]
    private string _calibrateAxisStep1WindowTitle = "Calibrate Zero";
    [SerializeField]
    [Tooltip("{0} = Axis Name")]
    private string _calibrateAxisStep1WindowMessage = "Center or zero {0} and press any button or wait for the timer to finish.";
    [SerializeField]
    private string _calibrateAxisStep2WindowTitle = "Calibrate Range";
    [SerializeField]
    [Tooltip("{0} = Axis Name")]
    private string _calibrateAxisStep2WindowMessage = "Move {0} through its entire range then press any button or wait for the timer to finish.";
    [SerializeField]
    private string _inputBehaviorSettingsWindowTitle = "Sensitivity Settings";
    [SerializeField]
    private string _restoreDefaultsWindowTitle = "Restore Defaults";
    [SerializeField]
    [Tooltip("Message for a single player game.")]
    private string _restoreDefaultsWindowMessage_onePlayer = "This will restore the default input configuration. Are you sure you want to do this?";
    [SerializeField]
    [Tooltip("Message for a multi-player game.")]
    private string _restoreDefaultsWindowMessage_multiPlayer = "This will restore the default input configuration for all players. Are you sure you want to do this?";
    [SerializeField]
    private string _actionColumnLabel = "Actions";
    [SerializeField]
    private string _keyboardColumnLabel = "Keyboard";
    [SerializeField]
    private string _mouseColumnLabel = "Mouse";
    [SerializeField]
    private string _controllerColumnLabel = "Controller";
    [SerializeField]
    private string _removeControllerButtonLabel = "Remove";
    [SerializeField]
    private string _calibrateControllerButtonLabel = "Calibrate";
    [SerializeField]
    private string _assignControllerButtonLabel = "Assign Controller";
    [SerializeField]
    private string _inputBehaviorSettingsButtonLabel = "Sensitivity";
    [SerializeField]
    private string _doneButtonLabel = "Done";
    [SerializeField]
    private string _restoreDefaultsButtonLabel = "Restore Defaults";
    [SerializeField]
    private string _playersGroupLabel = "Players:";
    [SerializeField]
    private string _controllerSettingsGroupLabel = "Controller:";
    [SerializeField]
    private string _assignedControllersGroupLabel = "Assigned Controllers:";
    [SerializeField]
    private string _settingsGroupLabel = "Settings:";
    [SerializeField]
    private string _mapCategoriesGroupLabel = "Categories:";
    [SerializeField]
    private string _calibrateWindow_deadZoneSliderLabel = "Dead Zone:";
    [SerializeField]
    private string _calibrateWindow_zeroSliderLabel = "Zero:";
    [SerializeField]
    private string _calibrateWindow_sensitivitySliderLabel = "Sensitivity:";
    [SerializeField]
    private string _calibrateWindow_invertToggleLabel = "Invert";
    [SerializeField]
    private string _calibrateWindow_calibrateButtonLabel = "Calibrate";
    [SerializeField]
    private LanguageData.CustomEntry[] _customEntries;
    private bool _initialized;
    private Dictionary<string, string> customDict;

    public void Initialize()
    {
      if (this._initialized)
        return;
      this.customDict = LanguageData.CustomEntry.ToDictionary(this._customEntries);
      this._initialized = true;
    }

    public string GetCustomEntry(string key)
    {
      string str;
      return string.IsNullOrEmpty(key) || !this.customDict.TryGetValue(key, out str) ? string.Empty : str;
    }

    public bool ContainsCustomEntryKey(string key) => !string.IsNullOrEmpty(key) && this.customDict.ContainsKey(key);

    public string yes => this._yes;

    public string no => this._no;

    public string add => this._add;

    public string replace => this._replace;

    public string remove => this._remove;

    public string swap => this._swap;

    public string cancel => this._cancel;

    public string none => this._none;

    public string okay => this._okay;

    public string done => this._done;

    public string default_ => this._default;

    public string assignControllerWindowTitle => this._assignControllerWindowTitle;

    public string assignControllerWindowMessage => this._assignControllerWindowMessage;

    public string controllerAssignmentConflictWindowTitle => this._controllerAssignmentConflictWindowTitle;

    public string elementAssignmentPrePollingWindowMessage => this._elementAssignmentPrePollingWindowMessage;

    public string elementAssignmentConflictWindowMessage => this._elementAssignmentConflictWindowMessage;

    public string mouseAssignmentConflictWindowTitle => this._mouseAssignmentConflictWindowTitle;

    public string calibrateControllerWindowTitle => this._calibrateControllerWindowTitle;

    public string calibrateAxisStep1WindowTitle => this._calibrateAxisStep1WindowTitle;

    public string calibrateAxisStep2WindowTitle => this._calibrateAxisStep2WindowTitle;

    public string inputBehaviorSettingsWindowTitle => this._inputBehaviorSettingsWindowTitle;

    public string restoreDefaultsWindowTitle => this._restoreDefaultsWindowTitle;

    public string actionColumnLabel => this._actionColumnLabel;

    public string keyboardColumnLabel => this._keyboardColumnLabel;

    public string mouseColumnLabel => this._mouseColumnLabel;

    public string controllerColumnLabel => this._controllerColumnLabel;

    public string removeControllerButtonLabel => this._removeControllerButtonLabel;

    public string calibrateControllerButtonLabel => this._calibrateControllerButtonLabel;

    public string assignControllerButtonLabel => this._assignControllerButtonLabel;

    public string inputBehaviorSettingsButtonLabel => this._inputBehaviorSettingsButtonLabel;

    public string doneButtonLabel => this._doneButtonLabel;

    public string restoreDefaultsButtonLabel => this._restoreDefaultsButtonLabel;

    public string controllerSettingsGroupLabel => this._controllerSettingsGroupLabel;

    public string playersGroupLabel => this._playersGroupLabel;

    public string assignedControllersGroupLabel => this._assignedControllersGroupLabel;

    public string settingsGroupLabel => this._settingsGroupLabel;

    public string mapCategoriesGroupLabel => this._mapCategoriesGroupLabel;

    public string restoreDefaultsWindowMessage => ReInput.players.playerCount > 1 ? this._restoreDefaultsWindowMessage_multiPlayer : this._restoreDefaultsWindowMessage_onePlayer;

    public string calibrateWindow_deadZoneSliderLabel => this._calibrateWindow_deadZoneSliderLabel;

    public string calibrateWindow_zeroSliderLabel => this._calibrateWindow_zeroSliderLabel;

    public string calibrateWindow_sensitivitySliderLabel => this._calibrateWindow_sensitivitySliderLabel;

    public string calibrateWindow_invertToggleLabel => this._calibrateWindow_invertToggleLabel;

    public string calibrateWindow_calibrateButtonLabel => this._calibrateWindow_calibrateButtonLabel;

    public string GetControllerAssignmentConflictWindowMessage(
      string joystickName,
      string otherPlayerName,
      string currentPlayerName)
    {
      return string.Format(this._controllerAssignmentConflictWindowMessage, (object) joystickName, (object) otherPlayerName, (object) currentPlayerName);
    }

    public string GetJoystickElementAssignmentPollingWindowMessage(string actionName) => string.Format(this._joystickElementAssignmentPollingWindowMessage, (object) actionName);

    public string GetJoystickElementAssignmentPollingWindowMessage_FullAxisFieldOnly(
      string actionName)
    {
      return string.Format(this._joystickElementAssignmentPollingWindowMessage_fullAxisFieldOnly, (object) actionName);
    }

    public string GetKeyboardElementAssignmentPollingWindowMessage(string actionName) => string.Format(this._keyboardElementAssignmentPollingWindowMessage, (object) actionName);

    public string GetMouseElementAssignmentPollingWindowMessage(string actionName) => string.Format(this._mouseElementAssignmentPollingWindowMessage, (object) actionName);

    public string GetMouseElementAssignmentPollingWindowMessage_FullAxisFieldOnly(string actionName) => string.Format(this._mouseElementAssignmentPollingWindowMessage_fullAxisFieldOnly, (object) actionName);

    public string GetElementAlreadyInUseBlocked(string elementName) => string.Format(this._elementAlreadyInUseBlocked, (object) elementName);

    public string GetElementAlreadyInUseCanReplace(string elementName, bool allowConflicts) => !allowConflicts ? string.Format(this._elementAlreadyInUseCanReplace, (object) elementName) : string.Format(this._elementAlreadyInUseCanReplace_conflictAllowed, (object) elementName);

    public string GetMouseAssignmentConflictWindowMessage(
      string otherPlayerName,
      string thisPlayerName)
    {
      return string.Format(this._mouseAssignmentConflictWindowMessage, (object) otherPlayerName, (object) thisPlayerName);
    }

    public string GetCalibrateAxisStep1WindowMessage(string axisName) => string.Format(this._calibrateAxisStep1WindowMessage, (object) axisName);

    public string GetCalibrateAxisStep2WindowMessage(string axisName) => string.Format(this._calibrateAxisStep2WindowMessage, (object) axisName);

    [Serializable]
    private class CustomEntry
    {
      public string key;
      public string value;

      public CustomEntry()
      {
      }

      public CustomEntry(string key, string value)
      {
        this.key = key;
        this.value = value;
      }

      public static Dictionary<string, string> ToDictionary(
        LanguageData.CustomEntry[] array)
      {
        if (array == null)
          return new Dictionary<string, string>();
        Dictionary<string, string> dictionary = new Dictionary<string, string>();
        for (int index = 0; index < array.Length; ++index)
        {
          if (array[index] != null && !string.IsNullOrEmpty(array[index].key) && !string.IsNullOrEmpty(array[index].value))
          {
            if (dictionary.ContainsKey(array[index].key))
              Debug.LogError((object) ("Key \"" + array[index].key + "\" is already in dictionary!"));
            else
              dictionary.Add(array[index].key, array[index].value);
          }
        }
        return dictionary;
      }
    }
  }
}
