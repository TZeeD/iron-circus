// Decompiled with JetBrains decompiler
// Type: SharedWithServer.ScEntitas.Systems.Gameplay.ObstacleCheckResult
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Jitter.LinearMath;
using System;
using System.Collections.Generic;

namespace SharedWithServer.ScEntitas.Systems.Gameplay
{
  [Serializable]
  public struct ObstacleCheckResult
  {
    public bool collided;
    public JVector projectedPosition;
    public JVector resultDirection;
    public List<SphereCastData> sphereCastResults;
  }
}
