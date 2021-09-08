// Decompiled with JetBrains decompiler
// Type: SteelCircus.Debugging.DebugShortcuts
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages;
using SharedWithServer.Networking.Messages;
using SharedWithServer.ScEvents;
using UnityEngine;

namespace SteelCircus.Debugging
{
  public class DebugShortcuts : MonoBehaviour
  {
    [SerializeField]
    private bool enableDebugShortcuts;
    [SerializeField]
    private bool enableNetworkEvents;
    private bool areShortcutsAllowedForBuildType;
    private bool isFreeroamCameraAllowed;
    private static DebugShortcuts instance;

    private void Start()
    {
      DebugShortcuts.instance = this;
      if (Debug.isDebugBuild)
        this.areShortcutsAllowedForBuildType = true;
      this.areShortcutsAllowedForBuildType = false;
    }

    private void Update()
    {
      if (!this.enableDebugShortcuts)
        return;
      this.GloballyAllowedShortcuts();
      if (!this.areShortcutsAllowedForBuildType)
        return;
      this.HandleLocalShortcuts();
      if (!this.enableNetworkEvents)
        return;
      this.HandleNetworkedShortcuts();
    }

    private void HandleLocalShortcuts()
    {
      if (this.isFreeroamCameraAllowed && Input.GetKeyDown(KeyCode.F2))
        this.RaiseLocalDebugEvent(DebugEventType.FreeroamCamera);
      if (Input.GetKey(KeyCode.LeftShift) && Input.GetKeyDown(KeyCode.T))
      {
        float num = 0.2f;
        float realtimeSinceStartup = Time.realtimeSinceStartup;
        while ((double) Time.realtimeSinceStartup < (double) realtimeSinceStartup + (double) num)
          ;
      }
      if (this.areShortcutsAllowedForBuildType && Input.GetKeyDown(KeyCode.Keypad7))
        this.RaiseLocalDebugEvent(DebugEventType.ToggleArenaBackground);
      if (this.areShortcutsAllowedForBuildType && Input.GetKeyDown(KeyCode.F1))
        this.RaiseLocalDebugEvent(DebugEventType.ToggleDevelopementConsole);
      if (!this.areShortcutsAllowedForBuildType || !Input.GetKeyDown(KeyCode.F12))
        return;
      this.RaiseLocalDebugEvent(DebugEventType.ToggleDebugRewardsPanel);
    }

    private void GloballyAllowedShortcuts()
    {
      if (Input.GetKey(KeyCode.LeftShift) && Input.GetKeyDown(KeyCode.N))
        this.RaiseLocalDebugEvent(DebugEventType.ToggleGraphView);
      if (Input.GetKey(KeyCode.LeftAlt) && Input.GetKeyDown(KeyCode.N))
        this.RaiseLocalDebugEvent(DebugEventType.ToggleNetworkUI);
      if (Input.GetKey(KeyCode.LeftControl) && Input.GetKeyDown(KeyCode.N))
        this.RaiseLocalDebugEvent(DebugEventType.ToggleNetworkUIUpdateRate);
      if (!Input.GetKey(KeyCode.LeftShift) || !Input.GetKeyDown(KeyCode.F))
        return;
      this.RaiseLocalDebugEvent(DebugEventType.ToggleFPSDisplay);
    }

    private void HandleNetworkedShortcuts()
    {
      if (this.areShortcutsAllowedForBuildType && Input.GetKeyDown(KeyCode.Keypad0))
      {
        if (Input.GetKey(KeyCode.LeftShift) || Input.GetKey(KeyCode.RightShift))
          this.RaiseNetworkedDebugEvent(DebugEventType.DebugCrashServer);
        else
          this.RaiseNetworkedDebugEvent(DebugEventType.SkipSkillCooldowns);
      }
      if (this.areShortcutsAllowedForBuildType && Input.GetKeyDown(KeyCode.Keypad1))
        this.RaiseNetworkedDebugEvent(DebugEventType.AddMatchTime);
      if (this.areShortcutsAllowedForBuildType && Input.GetKeyDown(KeyCode.Keypad2))
        this.RaiseNetworkedDebugEvent(DebugEventType.DropBall);
      if (this.areShortcutsAllowedForBuildType && Input.GetKeyDown(KeyCode.Keypad3))
        this.RaiseNetworkedDebugEvent(DebugEventType.Kill);
      if (this.areShortcutsAllowedForBuildType && Input.GetKeyDown(KeyCode.Keypad4))
        this.RaiseNetworkedDebugEvent(DebugEventType.SpawnPickups);
      if (this.areShortcutsAllowedForBuildType && Input.GetKeyDown(KeyCode.Keypad5))
        this.RaiseNetworkedDebugEvent(DebugEventType.CycleFakePlayerBehaviour);
      if (this.areShortcutsAllowedForBuildType && Input.GetKeyDown(KeyCode.Keypad6) || Input.GetKeyDown(KeyCode.Alpha9))
        this.RaiseNetworkedDebugEvent(DebugEventType.ToggleRecordFakePlayer);
      if (this.areShortcutsAllowedForBuildType && Input.GetKeyDown(KeyCode.Keypad9))
        this.RaiseNetworkedDebugEvent(DebugEventType.EndMatch);
      if (this.areShortcutsAllowedForBuildType && Input.GetKeyDown(KeyCode.B))
        this.RaiseNetworkedDebugEvent(DebugEventType.BurstMessages);
      if (!this.areShortcutsAllowedForBuildType || !Input.GetKeyDown(KeyCode.KeypadDivide))
        return;
      this.RaiseNetworkedDebugEvent(DebugEventType.ToggleAfkCheck);
    }

    private void RaiseLocalDebugEvent(DebugEventType type) => Events.Global.FireEventDebug(ulong.MaxValue, type);

    private void RaiseNetworkedDebugEvent(DebugEventType type)
    {
      Events.Global.FireEventDebug(ulong.MaxValue, type);
      Contexts.sharedInstance.meta.metaNetwork.value.SendReliable((Message) new SimpleDebugMessage(type));
    }
  }
}
