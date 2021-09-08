// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Components.StatusEffectComponent
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.Networking.Messages.SerDes;
using System.Collections.Generic;

namespace Imi.SharedWithServer.ScEntitas.Components
{
  [global::Game]
  public class StatusEffectComponent : ImiComponent
  {
    public List<StatusEffect> effects;
    public StatusModifier modifierStack;
    public StatusEffectType effectStack;

    public bool WasAdded(int tick, StatusEffectType statusEffectType)
    {
      foreach (StatusEffect effect in this.effects)
      {
        if (effect.type == (SyncableValue<StatusEffectType>) statusEffectType && effect.appliedInTick == (SyncableValue<int>) tick)
          return true;
      }
      return false;
    }

    public bool HasModifier(StatusModifier modifier) => (this.modifierStack & modifier) > StatusModifier.None;

    public bool HasEffect(StatusEffectType effectType) => (this.effectStack & effectType) > StatusEffectType.None;

    public StatusEffect GetEffect(StatusEffectType effectType)
    {
      if (this.effects != null)
      {
        foreach (StatusEffect effect in this.effects)
        {
          if (effect.type.Get() == effectType)
            return effect;
        }
      }
      return (StatusEffect) null;
    }

    public void UpdateModifierStack() => StatusEffect.CalcModifierStack((IEnumerable<StatusEffect>) this.effects, out this.effectStack, out this.modifierStack);

    public void Serialize(IMessageSerDes messageSerDes)
    {
      int modifierStack = (int) this.modifierStack;
      messageSerDes.Int(ref modifierStack);
      byte count = (byte) this.effects.Count;
      messageSerDes.Byte(ref count);
      foreach (StatusEffect effect in this.effects)
        effect.SerializeOrDeserialize(messageSerDes);
    }

    public static StatusEffectComponent Deserialize(
      IMessageSerDes messageSerDes)
    {
      StatusEffectComponent statusEffectComponent = new StatusEffectComponent();
      int num1 = 0;
      messageSerDes.Int(ref num1);
      statusEffectComponent.modifierStack = (StatusModifier) num1;
      byte num2 = 0;
      messageSerDes.Byte(ref num2);
      statusEffectComponent.effects = new List<StatusEffect>();
      for (int index = 0; index < (int) num2; ++index)
        statusEffectComponent.effects.Add(StatusEffect.Deserialize(messageSerDes));
      return statusEffectComponent;
    }
  }
}
