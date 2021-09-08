// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.Services.PatchNotesService
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using SteelCircus.UI.Popups;
using System;
using System.IO;
using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.Core.Services
{
  public class PatchNotesService
  {
    private string patchNotes;
    private bool firstStartWithCurrentVersion;

    public PatchNotesService() => this.patchNotes = this.LoadPatchNotes();

    private string LoadPatchNotes()
    {
      string path = Application.streamingAssetsPath + "/" + "PatchNotes.txt";
      Log.Debug(path + " Exists: " + File.Exists(path).ToString());
      return File.Exists(path) ? File.ReadAllText(path) : "";
    }

    public void ShowPatchNotes()
    {
      if (string.IsNullOrEmpty(this.patchNotes))
        return;
      PopupManager.Instance.ShowPopup(PopupManager.Popup.OneButton, (IPopupSettings) new Popup(this.patchNotes, "OK", title: "PATCH NOTES"), (Action) null, (Action) null, (Action) null, (Action) null, (Selectable) null);
    }

    public void ShowPatchNotesOnFirstStartup()
    {
      if (!this.firstStartWithCurrentVersion || string.IsNullOrEmpty(this.patchNotes))
        return;
      PopupManager.Instance.ShowPopup(PopupManager.Popup.TwoButtons, (IPopupSettings) new Popup("@PatchNotesPopupDescription", "@ShowPatchNotesButton", "@CancelButton", title: "@PatchNotesPopupTitle"), (Action) null, (Action) null, (Action) null, (Action) null, (Selectable) null);
      this.firstStartWithCurrentVersion = true;
    }

    public void SetFirstStartWithCurrentVersion() => this.firstStartWithCurrentVersion = true;
  }
}
