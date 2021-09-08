// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Components.PlayerLoadoutComponent
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using System.Collections.Generic;
using UnityEngine;

namespace Imi.SharedWithServer.ScEntitas.Components
{
  [global::Game]
  public class PlayerLoadoutComponent : ImiComponent
  {
    public bool playerLoadoutFetched;
    public int playerAvatar;
    public Sprite PlayerAvatarSprite;
    public Dictionary<ChampionType, ChampionLoadout> itemLoadouts;
  }
}
