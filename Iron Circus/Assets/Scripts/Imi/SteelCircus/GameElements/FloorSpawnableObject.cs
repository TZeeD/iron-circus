// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.GameElements.FloorSpawnableObject
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.FX;
using System;
using UnityEngine;

namespace Imi.SteelCircus.GameElements
{
  public class FloorSpawnableObject : MonoBehaviour
  {
    private FloorSpawnFX spawnFX;

    protected virtual void Spawn(float radius = 0.75f)
    {
      this.spawnFX = FloorSpawnFX.Get(this.transform.position, radius);
      this.spawnFX.onSpawnedObjectPositionChanged += new Action<FloorSpawnFX, Vector3>(this.OnSpawnedObjectPositionChanged);
      this.spawnFX.onSpawnComplete += new Action<FloorSpawnFX>(this.OnSpawnComplete);
    }

    protected virtual void Spawn(Vector3 position, float radius)
    {
      this.spawnFX = FloorSpawnFX.Get(position, radius);
      this.spawnFX.onSpawnedObjectPositionChanged += new Action<FloorSpawnFX, Vector3>(this.OnSpawnedObjectPositionChanged);
      this.spawnFX.onSpawnComplete += new Action<FloorSpawnFX>(this.OnSpawnComplete);
    }

    protected virtual void OnSpawnedObjectPositionChanged(FloorSpawnFX spawnFX, Vector3 pos) => this.transform.position = pos;

    protected virtual void OnSpawnComplete(FloorSpawnFX spawnFX)
    {
      spawnFX.onSpawnComplete -= new Action<FloorSpawnFX>(this.OnSpawnComplete);
      spawnFX.onSpawnedObjectPositionChanged -= new Action<FloorSpawnFX, Vector3>(this.OnSpawnedObjectPositionChanged);
      spawnFX = (FloorSpawnFX) null;
    }

    private void OnDestroy() => this.VirtualOnDestroy();

    protected virtual void VirtualOnDestroy()
    {
      if (!((UnityEngine.Object) this.spawnFX != (UnityEngine.Object) null))
        return;
      this.spawnFX.onSpawnComplete -= new Action<FloorSpawnFX>(this.OnSpawnComplete);
      this.spawnFX.onSpawnedObjectPositionChanged -= new Action<FloorSpawnFX, Vector3>(this.OnSpawnedObjectPositionChanged);
    }
  }
}
