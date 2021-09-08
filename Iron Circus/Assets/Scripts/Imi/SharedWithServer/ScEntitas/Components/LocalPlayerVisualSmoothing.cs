// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Components.LocalPlayerVisualSmoothing
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using SteelCircus.Core;

namespace Imi.SharedWithServer.ScEntitas.Components
{
  [global::Game]
  public class LocalPlayerVisualSmoothing : ImiComponent
  {
    public float currentLerpFactor = 1f;
    public float currentLerpDuration = 0.5f;
    public float tickStartTime;
    public float frameDtOffset;
    public TransformState interpolationStartTransform;
    public TransformState interpolationEndTransform;
    public TransformState smoothedTransform;
    public TimelineVector positionTimeline;
  }
}
