// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.AI.Collisions.AICollisionShapeRectangle
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Jitter.LinearMath;

namespace Imi.SharedWithServer.Game.AI.Collisions
{
  public class AICollisionShapeRectangle : AICollisionShapePolyLine
  {
    private float sizeX;
    private float sizeZ;
    private JVector position;

    public float SizeX
    {
      get => this.sizeX;
      set
      {
        this.sizeX = value;
        this.UpdateShape();
      }
    }

    public float SizeZ
    {
      get => this.sizeZ;
      set
      {
        this.sizeZ = value;
        this.UpdateShape();
      }
    }

    public JVector Position
    {
      get => this.position;
      set
      {
        this.position = value;
        this.UpdateShape();
      }
    }

    public AICollisionShapeRectangle(
      JVector position,
      float sizeX,
      float sizeZ,
      bool isTrigger = false,
      GameEntity entity = null)
      : base(isTrigger, entity)
    {
      this.sizeX = sizeX;
      this.sizeZ = sizeZ;
      this.Position = position;
      this.UpdateShape();
    }

    private void UpdateShape()
    {
      this.Clear();
      this.AddVertex(this.Position + new JVector((float) (-(double) this.sizeX * 0.5), 0.0f, (float) (-(double) this.sizeZ * 0.5)));
      this.AddVertex(this.Position + new JVector((float) (-(double) this.sizeX * 0.5), 0.0f, this.sizeZ * 0.5f));
      this.AddVertex(this.Position + new JVector(this.sizeX * 0.5f, 0.0f, this.sizeZ * 0.5f));
      this.AddVertex(this.Position + new JVector(this.sizeX * 0.5f, 0.0f, (float) (-(double) this.sizeZ * 0.5)));
      this.AddVertex(this.Position + new JVector((float) (-(double) this.sizeX * 0.5), 0.0f, (float) (-(double) this.sizeZ * 0.5)));
    }

    public override void Expand(float units)
    {
      for (int index = 0; index < this.vertices.Count; ++index)
      {
        if (index > 0)
          this.vertices[index] += this.normals[index - 1] * units;
        else
          this.vertices[index] += this.normals[this.normals.Count - 1] * units;
        this.vertices[index] += this.normals[index % this.normals.Count] * units;
      }
    }
  }
}
