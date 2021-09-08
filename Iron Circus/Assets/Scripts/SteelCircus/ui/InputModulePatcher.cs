// Decompiled with JetBrains decompiler
// Type: SteelCircus.ui.InputModulePatcher
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using UnityEngine;
using UnityEngine.EventSystems;

namespace SteelCircus.ui
{
  public class InputModulePatcher : MonoBehaviour
  {
    [SerializeField]
    private StandaloneInputModule inputModule;
    [SerializeField]
    private string horizontalOSX;
    [SerializeField]
    private string verticalOSX;
    [SerializeField]
    private string selectOSX;
    [SerializeField]
    private string cancelOSX;
    [Space]
    [SerializeField]
    private string horizontalWindows;
    [SerializeField]
    private string verticalWindows;
    [SerializeField]
    private string selectWindows;
    [SerializeField]
    private string cancelWindows;

    private void Awake()
    {
      switch (Application.platform)
      {
        case RuntimePlatform.OSXEditor:
          this.setUpOSX();
          break;
        case RuntimePlatform.OSXPlayer:
          this.setUpOSX();
          break;
        case RuntimePlatform.WindowsPlayer:
          this.setUpWindows();
          break;
        case RuntimePlatform.WindowsEditor:
          this.setUpWindows();
          break;
        default:
          throw new ArgumentOutOfRangeException();
      }
    }

    private void setUpOSX()
    {
      this.inputModule.horizontalAxis = this.horizontalOSX;
      this.inputModule.verticalAxis = this.verticalOSX;
      this.inputModule.submitButton = this.selectOSX;
      this.inputModule.cancelButton = this.cancelOSX;
    }

    private void setUpWindows()
    {
      this.inputModule.horizontalAxis = this.horizontalWindows;
      this.inputModule.verticalAxis = this.verticalWindows;
      this.inputModule.submitButton = this.selectWindows;
      this.inputModule.cancelButton = this.cancelWindows;
    }
  }
}
