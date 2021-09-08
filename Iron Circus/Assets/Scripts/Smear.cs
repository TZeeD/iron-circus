// Decompiled with JetBrains decompiler
// Type: Smear
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections.Generic;
using UnityEngine;

public class Smear : MonoBehaviour
{
  private Queue<Vector3> m_recentPositions = new Queue<Vector3>();
  public int FramesBufferSize;
  public Renderer Renderer;
  private Material m_instancedMaterial;

  private Material InstancedMaterial
  {
    get => this.m_instancedMaterial;
    set => this.m_instancedMaterial = value;
  }

  private void Start() => this.InstancedMaterial = this.Renderer.material;

  private void LateUpdate()
  {
    if (this.m_recentPositions.Count > this.FramesBufferSize)
      this.InstancedMaterial.SetVector("_PrevPosition", (Vector4) this.m_recentPositions.Dequeue());
    this.InstancedMaterial.SetVector("_Position", (Vector4) this.transform.position);
    this.m_recentPositions.Enqueue(this.transform.position);
  }
}
