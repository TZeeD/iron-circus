// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Components.BallOwnerComponent
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

namespace Imi.SharedWithServer.ScEntitas.Components
{
  [Game]
  public class BallOwnerComponent : ImiComponent
  {
    public ulong playerId;

    public bool IsOwner(ulong playerId) => (long) this.playerId == (long) playerId;

    public bool IsOwner(GameEntity entity) => entity.hasPlayerId && (long) entity.playerId.value == (long) this.playerId;
  }
}
