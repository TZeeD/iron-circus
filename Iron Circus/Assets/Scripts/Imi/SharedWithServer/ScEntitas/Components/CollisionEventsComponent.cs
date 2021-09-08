// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Components.CollisionEventsComponent
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas.CodeGeneration.Attributes;
using System.Collections.Generic;

namespace Imi.SharedWithServer.ScEntitas.Components
{
  [Game]
  [Unique]
  public class CollisionEventsComponent : ImiComponent
  {
    public List<JCollision> collisions;
    public List<JCollision> triggerEnter;
    public List<JCollision> triggerStay;
  }
}
