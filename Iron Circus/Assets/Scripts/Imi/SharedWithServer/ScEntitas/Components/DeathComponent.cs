// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Components.DeathComponent
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Jitter.LinearMath;

namespace Imi.SharedWithServer.ScEntitas.Components
{
  [Game]
  public sealed class DeathComponent : ImiComponent
  {
    public JVector playerSpawnPoint;
    public JVector lastPlayerPosition;
    public float respawnDuration;
    public float lerpFactor;
  }
}
