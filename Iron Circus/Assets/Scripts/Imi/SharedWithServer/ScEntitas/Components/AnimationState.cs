// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Components.AnimationState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace Imi.SharedWithServer.ScEntitas.Components
{
  public struct AnimationState
  {
    public static readonly AnimationState Invalid = new AnimationState()
    {
      variation = -1,
      normalizedProgress = -1f
    };
    public int variation;
    public float normalizedProgress;

    public void SerializeDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.Int(ref this.variation);
      messageSerDes.Float(ref this.normalizedProgress);
    }
  }
}
