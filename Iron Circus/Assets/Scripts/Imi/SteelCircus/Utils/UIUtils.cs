// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Utils.UIUtils
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas.Components;
using UnityEngine;
using UnityEngine.UI;

namespace Imi.SteelCircus.Utils
{
  public static class UIUtils
  {
    public const string championSkillIconPath = "UI/SkillUI/Skill Icons/";

    public static void InitializeSkillIcon(
      ChampionType championType,
      ButtonType type,
      Image skillIcon)
    {
      Sprite sprite = UnityEngine.Resources.Load<Sprite>("UI/SkillUI/Skill Icons/" + championType.ToString().ToLower() + "_" + type.ToString().ToLower() + "_ui");
      if ((Object) sprite != (Object) null)
        skillIcon.sprite = sprite;
      else
        Log.Warning(string.Format("SkillIcon {0} for ChampionType: {1} could not be loaded. Path was: {2}", (object) type, (object) championType, (object) ("UI/SkillUI/Skill Icons/" + championType.ToString().ToLower() + "_" + type.ToString().ToLower() + "_ui")));
    }
  }
}
