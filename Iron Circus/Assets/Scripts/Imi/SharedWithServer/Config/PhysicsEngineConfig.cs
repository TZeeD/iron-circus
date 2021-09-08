// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Config.PhysicsEngineConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

namespace Imi.SharedWithServer.Config
{
  public class PhysicsEngineConfig : GameConfigEntry
  {
    public float allowedPenetration = 0.01f;
    public float bias = 0.25f;
    public float breakThreshold = 0.01f;
    public float maximumBias = 10f;
    public float minVelocity = 1f / 1000f;
  }
}
