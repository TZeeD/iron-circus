// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Messages.PlayerHealthChangedMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace Imi.SharedWithServer.Networking.Messages
{
  public class PlayerHealthChangedMessage : Message
  {
    public int oldHealth;
    public int currentHealth;
    public bool isDead;
    public int maxHealth;
    public ulong playerId;

    public PlayerHealthChangedMessage()
      : base(RumpfieldMessageType.PlayerHealthChanged, true)
    {
    }

    public PlayerHealthChangedMessage(
      ulong playerId,
      int oldHealth,
      int currentHealth,
      int maxHealth,
      bool isDead)
      : base(RumpfieldMessageType.PlayerHealthChanged, true)
    {
      this.playerId = playerId;
      this.oldHealth = oldHealth;
      this.currentHealth = currentHealth;
      this.maxHealth = maxHealth;
      this.isDead = isDead;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.ULong(ref this.playerId);
      messageSerDes.Int(ref this.oldHealth);
      messageSerDes.Int(ref this.currentHealth);
      messageSerDes.Int(ref this.maxHealth);
      messageSerDes.Bool(ref this.isDead);
    }
  }
}
