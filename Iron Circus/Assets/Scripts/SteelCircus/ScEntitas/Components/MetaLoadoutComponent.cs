// Decompiled with JetBrains decompiler
// Type: SteelCircus.ScEntitas.Components.MetaLoadoutComponent
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas.Components;
using System.Collections.Generic;
using UnityEngine;

namespace SteelCircus.ScEntitas.Components
{
  [Meta]
  public class MetaLoadoutComponent : ImiComponent
  {
    public int avatarIconId;
    public Sprite avatarIconSprite;
    public Dictionary<ChampionType, ChampionLoadout> itemLoadouts;
  }
}
