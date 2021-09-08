// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.FX.AudienceParticleSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace Imi.SteelCircus.FX
{
  public class AudienceParticleSystem : MonoBehaviour
  {
    private void Start() => this.Init();

    private void Init()
    {
      ParticleSystem component = this.GetComponent<ParticleSystem>();
      component.Simulate(0.0f);
      component.Clear();
      ParticleSystem.ShapeModule shape = component.shape;
      Mesh mesh = shape.mesh;
      Vector3 position = shape.position;
      Vector3 rotation = shape.rotation;
      Vector3 scale = shape.scale;
      Quaternion q = Quaternion.Euler(rotation);
      Vector3 s = scale;
      Matrix4x4 matrix4x4 = this.transform.localToWorldMatrix * Matrix4x4.TRS(position, q, s);
      Vector3[] vertices = mesh.vertices;
      Vector3[] normals = mesh.normals;
      for (int index = 0; index < vertices.Length; ++index)
      {
        Vector3 vector3 = matrix4x4.MultiplyPoint(vertices[index]);
        Vector3 normalized = matrix4x4.MultiplyVector(normals[index]).normalized;
        component.Emit(new ParticleSystem.EmitParams()
        {
          position = vector3,
          velocity = normalized * 1E-10f
        }, 1);
      }
    }
  }
}
