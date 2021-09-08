// Decompiled with JetBrains decompiler
// Type: Jitter.World
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.Collision;
using Jitter.DataStructures;
using Jitter.Dynamics;
using Jitter.Dynamics.Constraints;
using Jitter.LinearMath;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Diagnostics;

namespace Jitter
{
  public class World
  {
    private float accumulatedTime;
    private readonly Queue<Arbiter> addedArbiterQueue = new Queue<Arbiter>();
    private readonly Action<object> arbiterCallback;
    private readonly CollisionDetectedHandler collisionDetectionHandler;
    private readonly HashSet<Constraint> constraints = new HashSet<Constraint>();
    private int contactIterations = 10;
    private float deactivationTime = 2f;
    private JVector gravity = new JVector(0.0f, -9.81f, 0.0f);
    private float inactiveAngularThresholdSq = 0.1f;
    private float inactiveLinearThresholdSq = 0.1f;
    private readonly Action<object> integrateCallback;
    private readonly IslandManager islands = new IslandManager();
    private readonly Queue<Arbiter> removedArbiterQueue = new Queue<Arbiter>();
    private readonly Stack<Arbiter> removedArbiterStack = new Stack<Arbiter>();
    private readonly HashSet<JRigidbody> rigidbodies = new HashSet<JRigidbody>();
    private int smallIterations = 4;
    private readonly HashSet<SoftBody> softbodies = new HashSet<SoftBody>();
    private readonly ThreadManager threadManager = ThreadManager.Instance;
    private float timestep;
    private readonly Stopwatch sw = new Stopwatch();
    private readonly double[] debugTimes = new double[10];

    public World(CollisionSystem collision)
    {
      if (collision == null)
        throw new ArgumentNullException("The CollisionSystem can't be null.", nameof (collision));
      this.arbiterCallback = new Action<object>(this.ArbiterCallback);
      this.integrateCallback = new Action<object>(this.IntegrateCallback);
      this.Rigidbodies = new ReadOnlyHashset<JRigidbody>(this.rigidbodies);
      this.Constraints = new ReadOnlyHashset<Constraint>(this.constraints);
      this.SoftBodies = new ReadOnlyHashset<SoftBody>(this.softbodies);
      this.CollisionSystem = collision;
      this.collisionDetectionHandler = new CollisionDetectedHandler(this.CollisionDetected);
      this.CollisionSystem.CollisionDetected += this.collisionDetectionHandler;
      this.ArbiterMap = new ArbiterMap();
      this.AllowDeactivation = true;
      this.CollisionSystem.CollisionDetected += new CollisionDetectedHandler(this.RaiseCollisionDetected);
    }

    public ReadOnlyHashset<JRigidbody> Triggers { get; }

    public ReadOnlyHashset<JRigidbody> Rigidbodies { get; }

    public ReadOnlyHashset<Constraint> Constraints { get; }

    public ReadOnlyHashset<SoftBody> SoftBodies { get; }

    public World.WorldEvents Events { get; } = new World.WorldEvents();

    public ArbiterMap ArbiterMap { get; }

    public ContactSettings ContactSettings { get; } = new ContactSettings();

    public ReadOnlyCollection<CollisionIsland> Islands => (ReadOnlyCollection<CollisionIsland>) this.islands;

    public CollisionSystem CollisionSystem { set; get; }

    public JVector Gravity
    {
      get => this.gravity;
      set => this.gravity = value;
    }

    public bool AllowDeactivation { get; set; }

    public event CollisionDetectedHandler RigidbodyCollisionDetected;

    public event CollisionDetectedHandler TriggerCollisionDetected;

    private void RaiseCollisionDetected(
      JRigidbody body1,
      JRigidbody body2,
      JVector point1,
      JVector point2,
      JVector normal,
      float penetration)
    {
      if (body1.isTrigger || body2.isTrigger)
      {
        if (this.TriggerCollisionDetected == null)
          return;
        this.TriggerCollisionDetected(body1, body2, point1, point2, normal, penetration);
      }
      else
      {
        if (this.RigidbodyCollisionDetected == null)
          return;
        this.RigidbodyCollisionDetected(body1, body2, point1, point2, normal, penetration);
      }
    }

    public void AddBody(SoftBody body)
    {
      if (body == null)
        throw new ArgumentNullException(nameof (body), "body can't be null.");
      if (this.softbodies.Contains(body))
        throw new ArgumentException("The body was already added to the world.", nameof (body));
      this.softbodies.Add(body);
      this.CollisionSystem.AddEntity((IBroadphaseEntity) body);
      this.Events.RaiseAddedSoftBody(body);
      foreach (Constraint edgeSpring in body.EdgeSprings)
        this.AddConstraint(edgeSpring);
      foreach (SoftBody.MassPoint vertexBody in body.VertexBodies)
      {
        this.Events.RaiseAddedRigidbody((JRigidbody) vertexBody);
        this.rigidbodies.Add((JRigidbody) vertexBody);
      }
    }

    public bool RemoveBody(SoftBody body)
    {
      if (!this.softbodies.Remove(body))
        return false;
      this.CollisionSystem.RemoveEntity((IBroadphaseEntity) body);
      this.Events.RaiseRemovedSoftBody(body);
      foreach (Constraint edgeSpring in body.EdgeSprings)
        this.RemoveConstraint(edgeSpring);
      foreach (JRigidbody vertexBody in body.VertexBodies)
        this.RemoveBody(vertexBody, true);
      return true;
    }

    public void ResetResourcePools()
    {
      IslandManager.Pool.ResetResourcePool();
      Arbiter.Pool.ResetResourcePool();
      Contact.Pool.ResetResourcePool();
    }

    public void Clear()
    {
      foreach (JRigidbody rigidbody in this.rigidbodies)
      {
        this.CollisionSystem.RemoveEntity((IBroadphaseEntity) rigidbody);
        if (rigidbody.island != null)
        {
          rigidbody.island.ClearLists();
          rigidbody.island = (CollisionIsland) null;
        }
        rigidbody.connections.Clear();
        rigidbody.arbiters.Clear();
        rigidbody.constraints.Clear();
        this.Events.RaiseRemovedRigidbody(rigidbody);
      }
      foreach (IBroadphaseEntity softbody in this.softbodies)
        this.CollisionSystem.RemoveEntity(softbody);
      this.rigidbodies.Clear();
      foreach (Constraint constraint in this.constraints)
        this.Events.RaiseRemovedConstraint(constraint);
      this.constraints.Clear();
      this.softbodies.Clear();
      this.islands.RemoveAll();
      this.ArbiterMap.Clear();
      this.ResetResourcePools();
    }

    public void SetInactivityThreshold(float angularVelocity, float linearVelocity, float time)
    {
      if ((double) angularVelocity < 0.0)
        throw new ArgumentException("Angular velocity threshold has to be larger than zero", nameof (angularVelocity));
      if ((double) linearVelocity < 0.0)
        throw new ArgumentException("Linear velocity threshold has to be larger than zero", nameof (linearVelocity));
      if ((double) time < 0.0)
        throw new ArgumentException("Deactivation time threshold has to be larger than zero", nameof (time));
      this.inactiveAngularThresholdSq = angularVelocity * angularVelocity;
      this.inactiveLinearThresholdSq = linearVelocity * linearVelocity;
      this.deactivationTime = time;
    }

    public void SetIterations(int iterations, int smallIterations)
    {
      if (iterations < 1)
        throw new ArgumentException("The number of collision iterations has to be larger than zero", nameof (iterations));
      if (smallIterations < 1)
        throw new ArgumentException("The number of collision iterations has to be larger than zero", nameof (smallIterations));
      this.contactIterations = iterations;
      this.smallIterations = smallIterations;
    }

    public bool RemoveBody(JRigidbody body) => this.RemoveBody(body, false);

    private bool RemoveBody(JRigidbody body, bool removeMassPoints)
    {
      if (!removeMassPoints && body.IsParticle || !this.rigidbodies.Remove(body))
        return false;
      foreach (Arbiter arbiter in body.arbiters)
      {
        this.ArbiterMap.Remove(arbiter);
        this.Events.RaiseBodiesEndCollide(arbiter.body1, arbiter.body2);
      }
      foreach (Constraint constraint in body.constraints)
      {
        this.constraints.Remove(constraint);
        this.Events.RaiseRemovedConstraint(constraint);
      }
      this.CollisionSystem.RemoveEntity((IBroadphaseEntity) body);
      this.islands.RemoveBody(body);
      this.Events.RaiseRemovedRigidbody(body);
      return true;
    }

    public void AddBody(JRigidbody body)
    {
      if (body == null)
        throw new ArgumentNullException("body can't be null.", nameof (body));
      if (this.rigidbodies.Contains(body))
      {
        Console.WriteLine("The body was already added to the world.");
      }
      else
      {
        this.Events.RaiseAddedRigidbody(body);
        this.CollisionSystem.AddEntity((IBroadphaseEntity) body);
        this.rigidbodies.Add(body);
      }
    }

    public bool RemoveConstraint(Constraint constraint)
    {
      if (!this.constraints.Remove(constraint))
        return false;
      this.Events.RaiseRemovedConstraint(constraint);
      this.islands.ConstraintRemoved(constraint);
      return true;
    }

    public void AddConstraint(Constraint constraint)
    {
      if (this.constraints.Contains(constraint))
        throw new ArgumentException("The constraint was already added to the world.", nameof (constraint));
      this.constraints.Add(constraint);
      this.islands.ConstraintCreated(constraint);
      this.Events.RaiseAddedConstraint(constraint);
    }

    public void Step(float timestep, bool multithread)
    {
      this.timestep = timestep;
      if ((double) timestep == 0.0)
        return;
      if ((double) timestep < 0.0)
        throw new ArgumentException("The timestep can't be negative.", nameof (timestep));
      this.sw.Restart();
      this.Events.RaiseWorldPreStep(timestep);
      foreach (JRigidbody rigidbody in this.rigidbodies)
        rigidbody.PreStep(timestep);
      this.debugTimes[4] = this.sw.Elapsed.TotalMilliseconds;
      this.sw.Restart();
      this.UpdateContacts();
      this.debugTimes[3] = this.sw.Elapsed.TotalMilliseconds;
      this.sw.Restart();
      while (this.removedArbiterQueue.Count > 0)
        this.islands.ArbiterRemoved(this.removedArbiterQueue.Dequeue());
      double totalMilliseconds1 = this.sw.Elapsed.TotalMilliseconds;
      this.sw.Restart();
      foreach (SoftBody softbody in this.softbodies)
      {
        softbody.Update(timestep);
        softbody.DoSelfCollision(this.collisionDetectionHandler);
      }
      this.debugTimes[9] = this.sw.Elapsed.TotalMilliseconds;
      this.sw.Restart();
      this.CollisionSystem.Detect(multithread);
      double[] debugTimes1 = this.debugTimes;
      TimeSpan elapsed = this.sw.Elapsed;
      double totalMilliseconds2 = elapsed.TotalMilliseconds;
      debugTimes1[0] = totalMilliseconds2;
      this.sw.Restart();
      while (this.addedArbiterQueue.Count > 0)
        this.islands.ArbiterCreated(this.addedArbiterQueue.Dequeue());
      double[] debugTimes2 = this.debugTimes;
      elapsed = this.sw.Elapsed;
      double num = elapsed.TotalMilliseconds + totalMilliseconds1;
      debugTimes2[1] = num;
      this.sw.Restart();
      this.CheckDeactivation();
      double[] debugTimes3 = this.debugTimes;
      elapsed = this.sw.Elapsed;
      double totalMilliseconds3 = elapsed.TotalMilliseconds;
      debugTimes3[5] = totalMilliseconds3;
      this.sw.Restart();
      this.IntegrateForces();
      double[] debugTimes4 = this.debugTimes;
      elapsed = this.sw.Elapsed;
      double totalMilliseconds4 = elapsed.TotalMilliseconds;
      debugTimes4[6] = totalMilliseconds4;
      this.sw.Restart();
      this.sw.Start();
      this.HandleArbiter(this.contactIterations, multithread);
      double[] debugTimes5 = this.debugTimes;
      elapsed = this.sw.Elapsed;
      double totalMilliseconds5 = elapsed.TotalMilliseconds;
      debugTimes5[2] = totalMilliseconds5;
      this.sw.Restart();
      this.sw.Start();
      this.Integrate(multithread);
      double[] debugTimes6 = this.debugTimes;
      elapsed = this.sw.Elapsed;
      double totalMilliseconds6 = elapsed.TotalMilliseconds;
      debugTimes6[7] = totalMilliseconds6;
      this.sw.Restart();
      this.sw.Start();
      foreach (JRigidbody rigidbody in this.rigidbodies)
        rigidbody.PostStep(timestep);
      this.Events.RaiseWorldPostStep(timestep);
      this.debugTimes[8] = this.sw.Elapsed.TotalMilliseconds;
      this.sw.Stop();
    }

    public void Step(float totalTime, bool multithread, float timestep, int maxSteps)
    {
      int num = 0;
      this.accumulatedTime += totalTime;
      while ((double) this.accumulatedTime > (double) timestep)
      {
        this.Step(timestep, multithread);
        this.accumulatedTime -= timestep;
        ++num;
        if (num > maxSteps)
        {
          this.accumulatedTime = 0.0f;
          break;
        }
      }
    }

    private void UpdateArbiterContacts(Arbiter arbiter)
    {
      if (arbiter.contactList.Count == 0)
      {
        lock (this.removedArbiterStack)
          this.removedArbiterStack.Push(arbiter);
      }
      else
      {
        for (int index = arbiter.contactList.Count - 1; index >= 0; --index)
        {
          Contact contact = arbiter.contactList[index];
          contact.UpdatePosition();
          if ((double) contact.penetration < -(double) this.ContactSettings.breakThreshold)
          {
            Contact.Pool.GiveBack(contact);
            arbiter.contactList.RemoveAt(index);
          }
          else
          {
            JVector result;
            JVector.Subtract(ref contact.p1, ref contact.p2, out result);
            float num = JVector.Dot(ref result, ref contact.normal);
            result -= num * contact.normal;
            if ((double) result.LengthSquared() > (double) this.ContactSettings.breakThreshold * (double) this.ContactSettings.breakThreshold * 100.0)
            {
              Contact.Pool.GiveBack(contact);
              arbiter.contactList.RemoveAt(index);
            }
          }
        }
      }
    }

    private void UpdateContacts()
    {
      foreach (Arbiter arbiter in this.ArbiterMap.Arbiters)
        this.UpdateArbiterContacts(arbiter);
      while (this.removedArbiterStack.Count > 0)
      {
        Arbiter arbiter = this.removedArbiterStack.Pop();
        Arbiter.Pool.GiveBack(arbiter);
        this.ArbiterMap.Remove(arbiter);
        this.removedArbiterQueue.Enqueue(arbiter);
        this.Events.RaiseBodiesEndCollide(arbiter.body1, arbiter.body2);
      }
    }

    private void ArbiterCallback(object obj)
    {
      CollisionIsland collisionIsland = obj as CollisionIsland;
      int num = collisionIsland.Bodies.Count + collisionIsland.Constraints.Count <= 3 ? this.smallIterations : this.contactIterations;
      for (int index1 = -1; index1 < num; ++index1)
      {
        foreach (Arbiter arbiter in collisionIsland.arbiter)
        {
          int count = arbiter.contactList.Count;
          for (int index2 = 0; index2 < count; ++index2)
          {
            if (index1 == -1)
              arbiter.contactList[index2].PrepareForIteration(this.timestep);
            else
              arbiter.contactList[index2].Iterate();
          }
        }
        foreach (Constraint constraint in collisionIsland.constraints)
        {
          if (constraint.body1 == null || constraint.body1.IsActive || constraint.body2 == null || constraint.body2.IsActive)
          {
            if (index1 == -1)
              constraint.PrepareForIteration(this.timestep);
            else
              constraint.Iterate();
          }
        }
      }
    }

    private void HandleArbiter(int iterations, bool multiThreaded)
    {
      if (multiThreaded)
      {
        for (int index = 0; index < this.islands.Count; ++index)
        {
          if (this.islands[index].IsActive())
            this.threadManager.AddTask(this.arbiterCallback, (object) this.islands[index]);
        }
        this.threadManager.Execute();
      }
      else
      {
        for (int index = 0; index < this.islands.Count; ++index)
        {
          if (this.islands[index].IsActive())
            this.arbiterCallback((object) this.islands[index]);
        }
      }
    }

    private void IntegrateForces()
    {
      foreach (JRigidbody rigidbody in this.rigidbodies)
      {
        if (!rigidbody.isStatic && rigidbody.IsActive && !rigidbody.isKinematic && !rigidbody.isTrigger)
        {
          JVector result;
          JVector.Multiply(ref rigidbody.force, rigidbody.inverseMass * this.timestep, out result);
          JVector.Add(ref result, ref rigidbody.linearVelocity, out rigidbody.linearVelocity);
          if (!rigidbody.isParticle)
          {
            JVector.Multiply(ref rigidbody.torque, this.timestep, out result);
            JVector.Transform(ref result, ref rigidbody.invInertiaWorld, out result);
            JVector.Add(ref result, ref rigidbody.angularVelocity, out rigidbody.angularVelocity);
          }
          if (rigidbody.affectedByGravity)
          {
            JVector.Multiply(ref this.gravity, this.timestep, out result);
            JVector.Add(ref rigidbody.linearVelocity, ref result, out rigidbody.linearVelocity);
          }
        }
        rigidbody.force.MakeZero();
        rigidbody.torque.MakeZero();
      }
    }

    private void IntegrateCallback(object obj)
    {
      JRigidbody jrigidbody = obj as JRigidbody;
      JVector result1;
      JVector.Multiply(ref jrigidbody.linearVelocity, this.timestep, out result1);
      JVector.Add(ref result1, ref jrigidbody.position, out jrigidbody.position);
      if (!jrigidbody.isParticle)
      {
        float num = jrigidbody.angularVelocity.Length();
        JVector result2;
        if ((double) num < 1.0 / 1000.0)
          JVector.Multiply(ref jrigidbody.angularVelocity, (float) (0.5 * (double) this.timestep - (double) this.timestep * (double) this.timestep * (double) this.timestep * 0.020833333954215 * (double) num * (double) num), out result2);
        else
          JVector.Multiply(ref jrigidbody.angularVelocity, (float) Math.Sin(0.5 * (double) num * (double) this.timestep) / num, out result2);
        JQuaternion result3 = new JQuaternion(result2.X, result2.Y, result2.Z, (float) Math.Cos((double) num * (double) this.timestep * 0.5));
        JQuaternion result4;
        JQuaternion.CreateFromMatrix(ref jrigidbody.orientation, out result4);
        JQuaternion.Multiply(ref result3, ref result4, out result3);
        result3.Normalize();
        JMatrix.CreateFromQuaternion(ref result3, out jrigidbody.orientation);
      }
      if ((double) jrigidbody.LinearDrag > 0.0)
        JVector.Multiply(ref jrigidbody.linearVelocity, JMath.Clamp((float) (1.0 - (double) jrigidbody.LinearDrag * (double) this.timestep), 0.0f, 1f), out jrigidbody.linearVelocity);
      if ((double) jrigidbody.AngularDrag > 0.0)
        JVector.Multiply(ref jrigidbody.angularVelocity, JMath.Clamp((float) (1.0 - (double) jrigidbody.AngularDrag * (double) this.timestep), 0.0f, 1f), out jrigidbody.angularVelocity);
      jrigidbody.Update();
      if (!this.CollisionSystem.EnableSpeculativeContacts && !jrigidbody.EnableSpeculativeContacts)
        return;
      jrigidbody.SweptExpandBoundingBox(this.timestep);
    }

    private void Integrate(bool multithread)
    {
      if (multithread)
      {
        foreach (JRigidbody rigidbody in this.rigidbodies)
        {
          if (!rigidbody.isStatic && !rigidbody.isKinematic && !rigidbody.isTrigger && rigidbody.IsActive)
            this.threadManager.AddTask(this.integrateCallback, (object) rigidbody);
        }
        this.threadManager.Execute();
      }
      else
      {
        foreach (JRigidbody rigidbody in this.rigidbodies)
        {
          if (!rigidbody.isStatic && !rigidbody.isKinematic && !rigidbody.isTrigger && rigidbody.IsActive)
            this.integrateCallback((object) rigidbody);
        }
      }
    }

    private void CollisionDetected(
      JRigidbody body1,
      JRigidbody body2,
      JVector point1,
      JVector point2,
      JVector normal,
      float penetration)
    {
      Arbiter arbiter = (Arbiter) null;
      lock (this.ArbiterMap)
      {
        this.ArbiterMap.LookUpArbiter(body1, body2, out arbiter);
        if (arbiter == null)
        {
          arbiter = Arbiter.Pool.GetNew();
          arbiter.body1 = body1;
          arbiter.body2 = body2;
          this.ArbiterMap.Add(new ArbiterKey(body1, body2), arbiter);
          this.addedArbiterQueue.Enqueue(arbiter);
          this.Events.RaiseBodiesBeginCollide(body1, body2);
        }
      }
      Contact contact;
      if (arbiter.body1 == body1)
      {
        JVector normal1 = normal * -1f;
        contact = arbiter.AddContact(point1, point2, normal1, penetration, this.ContactSettings);
      }
      else
        contact = arbiter.AddContact(point2, point1, normal, penetration, this.ContactSettings);
      if (contact == null)
        return;
      this.Events.RaiseContactCreated(contact);
    }

    private void CheckDeactivation()
    {
      foreach (CollisionIsland island in (ReadOnlyCollection<CollisionIsland>) this.islands)
      {
        bool flag = true;
        if (!this.AllowDeactivation)
        {
          flag = false;
        }
        else
        {
          foreach (JRigidbody body in island.bodies)
          {
            if (body.AllowDeactivation && (double) body.angularVelocity.LengthSquared() < (double) this.inactiveAngularThresholdSq && (double) body.linearVelocity.LengthSquared() < (double) this.inactiveLinearThresholdSq)
            {
              body.inactiveTime += this.timestep;
              if ((double) body.inactiveTime < (double) this.deactivationTime)
                flag = false;
            }
            else
            {
              body.inactiveTime = 0.0f;
              flag = false;
            }
          }
        }
        foreach (JRigidbody body in island.bodies)
        {
          if (body.isActive == flag)
          {
            if (body.isActive)
            {
              body.IsActive = false;
              this.Events.RaiseDeactivatedBody(body);
            }
            else
            {
              body.IsActive = true;
              this.Events.RaiseActivatedBody(body);
            }
          }
        }
      }
    }

    public double[] DebugTimes => this.debugTimes;

    public delegate void WorldStep(float timestep);

    public class WorldEvents
    {
      internal WorldEvents()
      {
      }

      public event World.WorldStep PreStep;

      public event World.WorldStep PostStep;

      public event Action<JRigidbody> AddedRigidbody;

      public event Action<JRigidbody> RemovedRigidbody;

      public event Action<Constraint> AddedConstraint;

      public event Action<Constraint> RemovedConstraint;

      public event Action<SoftBody> AddedSoftBody;

      public event Action<SoftBody> RemovedSoftBody;

      public event Action<JRigidbody, JRigidbody> BodiesBeginCollide;

      public event Action<JRigidbody, JRigidbody> BodiesEndCollide;

      public event Action<Contact> ContactCreated;

      public event Action<JRigidbody> DeactivatedBody;

      public event Action<JRigidbody> ActivatedBody;

      internal void RaiseWorldPreStep(float timestep)
      {
        if (this.PreStep == null)
          return;
        this.PreStep(timestep);
      }

      internal void RaiseWorldPostStep(float timestep)
      {
        if (this.PostStep == null)
          return;
        this.PostStep(timestep);
      }

      internal void RaiseAddedRigidbody(JRigidbody body)
      {
        if (this.AddedRigidbody == null)
          return;
        this.AddedRigidbody(body);
      }

      internal void RaiseRemovedRigidbody(JRigidbody body)
      {
        if (this.RemovedRigidbody == null)
          return;
        this.RemovedRigidbody(body);
      }

      internal void RaiseAddedConstraint(Constraint constraint)
      {
        if (this.AddedConstraint == null)
          return;
        this.AddedConstraint(constraint);
      }

      internal void RaiseRemovedConstraint(Constraint constraint)
      {
        if (this.RemovedConstraint == null)
          return;
        this.RemovedConstraint(constraint);
      }

      internal void RaiseAddedSoftBody(SoftBody body)
      {
        if (this.AddedSoftBody == null)
          return;
        this.AddedSoftBody(body);
      }

      internal void RaiseRemovedSoftBody(SoftBody body)
      {
        if (this.RemovedSoftBody == null)
          return;
        this.RemovedSoftBody(body);
      }

      internal void RaiseBodiesBeginCollide(JRigidbody body1, JRigidbody body2)
      {
        if (this.BodiesBeginCollide == null)
          return;
        this.BodiesBeginCollide(body1, body2);
      }

      internal void RaiseBodiesEndCollide(JRigidbody body1, JRigidbody body2)
      {
        if (this.BodiesEndCollide == null)
          return;
        this.BodiesEndCollide(body1, body2);
      }

      internal void RaiseActivatedBody(JRigidbody body)
      {
        if (this.ActivatedBody == null)
          return;
        this.ActivatedBody(body);
      }

      internal void RaiseDeactivatedBody(JRigidbody body)
      {
        if (this.DeactivatedBody == null)
          return;
        this.DeactivatedBody(body);
      }

      internal void RaiseContactCreated(Contact contact)
      {
        if (this.ContactCreated == null)
          return;
        this.ContactCreated(contact);
      }
    }

    public enum DebugType
    {
      CollisionDetect,
      BuildIslands,
      HandleArbiter,
      UpdateContacts,
      PreStep,
      DeactivateBodies,
      IntegrateForces,
      Integrate,
      PostStep,
      ClothUpdate,
      Num,
    }
  }
}
