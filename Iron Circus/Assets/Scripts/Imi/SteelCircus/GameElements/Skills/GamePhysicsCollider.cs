// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.GameElements.Skills.GamePhysicsCollider
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SteelCircus.JitterUnity;
using Jitter.Collision.Shapes;
using Jitter.Dynamics;
using Jitter.LinearMath;
using SteelCircus;
using System;
using System.Collections.Generic;
using UnityEngine;

namespace Imi.SteelCircus.GameElements.Skills
{
  public class GamePhysicsCollider : MonoBehaviour, IConvertableToEntitas
  {
    public CollisionLayer collisionLayer;
    [Space]
    [EnumButton(1)]
    public CollisionLayer collisionMask;
    private Dictionary<System.Type, Func<Collider, JRigidbody>> colliderConverter = new Dictionary<System.Type, Func<Collider, JRigidbody>>()
    {
      {
        typeof (BoxCollider),
        new Func<Collider, JRigidbody>(GamePhysicsCollider.ConvertBox)
      },
      {
        typeof (SphereCollider),
        new Func<Collider, JRigidbody>(GamePhysicsCollider.ConvertSphere)
      },
      {
        typeof (CapsuleCollider),
        new Func<Collider, JRigidbody>(GamePhysicsCollider.ConvertCapsule)
      }
    };

    public IComponent ConvertToEntitasComponent() => (IComponent) new RigidbodyComponent()
    {
      value = this.CreateRigidbody(this.GetComponent<Collider>())
    };

    private JRigidbody CreateRigidbody(Collider uColl)
    {
      System.Type type = uColl.GetType();
      if (!this.colliderConverter.ContainsKey(type))
      {
        Debug.LogWarning((object) ("No converter for collider type: " + uColl.GetType().Name));
        return (JRigidbody) null;
      }
      JRigidbody jrigidbody = this.colliderConverter[type](uColl);
      jrigidbody.name = uColl.name;
      JVector position = jrigidbody.Position;
      jrigidbody.Position = uColl.transform.TransformPoint(position.ToVector3()).ToJVector();
      jrigidbody.Orientation = uColl.transform.rotation.ToJMatrix();
      jrigidbody.CollisionLayer = (int) this.collisionLayer;
      jrigidbody.CollisionMask = (int) this.collisionMask;
      jrigidbody.AffectedByGravity = false;
      jrigidbody.IsStatic = uColl.gameObject.isStatic;
      jrigidbody.IsActive |= uColl.gameObject.activeInHierarchy;
      jrigidbody.IsTrigger = uColl.isTrigger;
      return jrigidbody;
    }

    private static JRigidbody ConvertBox(Collider collider)
    {
      BoxCollider boxCollider = (BoxCollider) collider;
      Vector3 lossyScale = boxCollider.transform.lossyScale;
      return new JRigidbody((Shape) new BoxShape(Vector3.Scale(boxCollider.size, lossyScale).ToJVector()))
      {
        Position = boxCollider.center.ToJVector()
      };
    }

    public Collider DebugRecreateUnityBox(JRigidbody input, GameObject output)
    {
      BoxShape shape = (BoxShape) input.Shape;
      BoxCollider boxCollider = output.AddComponent<BoxCollider>();
      boxCollider.size = shape.Size.ToVector3();
      return (Collider) boxCollider;
    }

    private static JRigidbody ConvertSphere(Collider collider)
    {
      SphereCollider sphereCollider = (SphereCollider) collider;
      Vector3 lossyScale = sphereCollider.transform.lossyScale;
      return new JRigidbody((Shape) new SphereShape(Mathf.Max(lossyScale.x, lossyScale.y, lossyScale.z) * sphereCollider.radius))
      {
        Position = sphereCollider.center.ToJVector()
      };
    }

    public Collider DebugRecreateUnitySphere(JRigidbody input, GameObject output)
    {
      SphereShape shape = (SphereShape) input.Shape;
      SphereCollider sphereCollider = output.AddComponent<SphereCollider>();
      sphereCollider.radius = shape.Radius;
      return (Collider) sphereCollider;
    }

    private static JRigidbody ConvertCapsule(Collider collider)
    {
      CapsuleCollider capsuleCollider = (CapsuleCollider) collider;
      if (capsuleCollider.direction != 1)
        Debug.LogError((object) "Only Capsule colliders with direction Y-Axis are exported properly!");
      Vector3 lossyScale = capsuleCollider.transform.lossyScale;
      float radius = Mathf.Max(lossyScale.x, lossyScale.z) * capsuleCollider.radius;
      return new JRigidbody((Shape) new CapsuleShape(lossyScale.y * capsuleCollider.height, radius))
      {
        Position = capsuleCollider.center.ToJVector()
      };
    }

    public Collider DebugRecreateUnityCapsule(JRigidbody input, GameObject output)
    {
      CapsuleShape shape = (CapsuleShape) input.Shape;
      CapsuleCollider capsuleCollider = output.AddComponent<CapsuleCollider>();
      capsuleCollider.radius = shape.Radius;
      capsuleCollider.height = shape.Length;
      return (Collider) capsuleCollider;
    }
  }
}
