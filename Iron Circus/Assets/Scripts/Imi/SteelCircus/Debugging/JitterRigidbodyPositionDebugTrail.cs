// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Debugging.JitterRigidbodyPositionDebugTrail
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas.Unity;
using Imi.SteelCircus.JitterUnity;
using Jitter.Collision.Shapes;
using Jitter.Dynamics;
using Jitter.LinearMath;
using System.Collections.Generic;
using UnityEngine;

namespace Imi.SteelCircus.Debugging
{
  public class JitterRigidbodyPositionDebugTrail : MonoBehaviour
  {
    public int length = 100;
    public float size = 0.125f;
    public Gradient gradient;
    private JRigidbody jJRigidbody;
    private List<JVector> positions;

    private void Start()
    {
      this.positions = new List<JVector>();
      this.Init();
    }

    private void Init()
    {
      if (this.jJRigidbody != null)
        return;
      EntityLink component = this.GetComponent<EntityLink>();
      if (!((Object) component != (Object) null) || !(component.entity is GameEntity entity) || !entity.hasRigidbody)
        return;
      this.jJRigidbody = entity.rigidbody.value;
    }

    private void Update()
    {
      this.Init();
      if (this.positions.Count > 0)
      {
        if (!this.positions[this.positions.Count - 1].Equals(this.jJRigidbody.Position))
          this.positions.Add(this.jJRigidbody.Position);
        if (this.positions.Count <= this.length)
          return;
        this.positions.RemoveRange(0, this.positions.Count - this.length);
      }
      else
        this.positions.Add(this.jJRigidbody.Position);
    }

    private void OnDrawGizmos()
    {
      int num = 0;
      foreach (JVector position in this.positions)
      {
        Gizmos.color = this.gradient.Evaluate((float) num / (float) this.length);
        Gizmos.DrawSphere(position.ToVector3(), ((SphereShape) this.jJRigidbody.Shape).Radius * this.size);
        ++num;
      }
    }
  }
}
