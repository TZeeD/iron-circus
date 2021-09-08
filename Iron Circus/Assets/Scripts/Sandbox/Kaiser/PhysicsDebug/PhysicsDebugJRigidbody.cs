// Decompiled with JetBrains decompiler
// Type: Sandbox.Kaiser.PhysicsDebug.PhysicsDebugJRigidbody
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.JitterUnity;
using Jitter.Collision.Shapes;
using Jitter.Dynamics;
using Jitter.LinearMath;
using UnityEngine;

namespace Sandbox.Kaiser.PhysicsDebug
{
  public class PhysicsDebugJRigidbody : MonoBehaviour
  {
    private JRigidbody body;
    public JVector dimensions;
    public bool isKinematic;
    public bool isTrigger;
    public bool isStatic;

    public void SetBody(JRigidbody body)
    {
      this.body = body;
      this.SetToRigidbody();
    }

    private void SetToRigidbody()
    {
      this.isKinematic = this.body.IsKinematic;
      this.isTrigger = this.body.IsTrigger;
      this.isStatic = this.body.IsStatic;
      this.transform.position = this.body.Position.ToVector3();
      this.transform.LookAt(this.transform.position + this.body.Orientation.Forward().ToVector3());
      if (this.body.Shape is BoxShape)
        this.dimensions = (this.body.Shape as BoxShape).Size;
      if (this.body.Shape is SphereShape)
      {
        this.dimensions.X = (this.body.Shape as SphereShape).Radius;
        this.dimensions.Y = this.dimensions.Z = 0.0f;
      }
      if (this.body.Shape is CylinderShape)
      {
        CylinderShape shape = this.body.Shape as CylinderShape;
        this.dimensions.X = shape.Radius;
        this.dimensions.Y = shape.Height;
        this.dimensions.Z = 0.0f;
      }
      if (!(this.body.Shape is CapsuleShape))
        return;
      CapsuleShape shape1 = this.body.Shape as CapsuleShape;
      this.dimensions.X = shape1.Radius;
      this.dimensions.Y = shape1.Length;
      this.dimensions.Z = 0.0f;
    }

    private void Update()
    {
      if (this.body == null)
        return;
      this.body.IsKinematic = this.isKinematic;
      this.body.IsTrigger = this.isTrigger;
      this.body.IsStatic = this.isStatic;
      this.body.Position = this.transform.position.ToJVector();
      Vector3 eulerAngles = this.transform.eulerAngles;
      this.body.Orientation = JMatrix.CreateFromQuaternion(JQuaternion.CreateFromEuler(eulerAngles.x, eulerAngles.y, eulerAngles.z));
      if (this.body.Shape is BoxShape)
        (this.body.Shape as BoxShape).Size = this.dimensions;
      if (this.body.Shape is SphereShape)
        (this.body.Shape as SphereShape).Radius = this.dimensions.X;
      if (this.body.Shape is CylinderShape)
      {
        CylinderShape shape = this.body.Shape as CylinderShape;
        shape.Radius = this.dimensions.X;
        shape.Height = this.dimensions.Y;
      }
      if (!(this.body.Shape is CapsuleShape))
        return;
      CapsuleShape shape1 = this.body.Shape as CapsuleShape;
      shape1.Radius = this.dimensions.X;
      shape1.Length = this.dimensions.Y;
    }
  }
}
