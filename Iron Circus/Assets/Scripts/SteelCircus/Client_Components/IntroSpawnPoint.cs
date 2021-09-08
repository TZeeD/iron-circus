// Decompiled with JetBrains decompiler
// Type: SteelCircus.Client_Components.IntroSpawnPoint
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using SharedWithServer.Game;
using UnityEngine;

namespace SteelCircus.Client_Components
{
  public class IntroSpawnPoint : MonoBehaviour
  {
    public Team team;
    public SpawnPositionType spawnPosition;
    [Header("Gizmos Editor Only")]
    [SerializeField]
    private bool drawGizmo = true;
    [SerializeField]
    private Color gizmoColor;
    [SerializeField]
    private Mesh mesh;

    private void OnDrawGizmos()
    {
      if (!this.drawGizmo)
        return;
      Gizmos.color = this.gizmoColor;
      if ((Object) this.mesh != (Object) null)
        Gizmos.DrawMesh(this.mesh, this.transform.position, this.transform.rotation);
      else
        Gizmos.DrawCube(this.transform.position, new Vector3(1f, 4f, 1f));
    }
  }
}
