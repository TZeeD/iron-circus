// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Components.TriggerEnterEventComponent
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas.CodeGeneration.Attributes;
using Jitter.Dynamics;
using Jitter.LinearMath;

namespace Imi.SharedWithServer.ScEntitas.Components
{
  [Game]
  public class TriggerEnterEventComponent : ImiComponent
  {
    [EntityIndex]
    public JRigidbody first;
    [EntityIndex]
    public JRigidbody second;
    public JVector normal;
    public float penetration;
  }
}
