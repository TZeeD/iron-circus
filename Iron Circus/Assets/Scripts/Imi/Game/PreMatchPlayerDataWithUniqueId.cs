// Decompiled with JetBrains decompiler
// Type: Imi.Game.PreMatchPlayerDataWithUniqueId
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;

namespace Imi.Game
{
  public struct PreMatchPlayerDataWithUniqueId
  {
    public PreMatchPlayerData data;
    public UniqueId uniqueId;

    public PreMatchPlayerDataWithUniqueId(PreMatchPlayerData data, UniqueId uniqueId)
    {
      this.data = data;
      this.uniqueId = uniqueId;
    }
  }
}
