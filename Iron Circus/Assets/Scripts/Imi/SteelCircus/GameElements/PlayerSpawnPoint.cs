// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.GameElements.PlayerSpawnPoint
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas.Components;
using SteelCircus;
using UnityEngine;

namespace Imi.SteelCircus.GameElements
{
  public class PlayerSpawnPoint : MonoBehaviour, IConvertableToEntitas
  {
    [SerializeField]
    private Color gizmoColor;
    [SerializeField]
    private MatchType matchType;
    [SerializeField]
    private Team team;

    public IComponent ConvertToEntitasComponent() => (IComponent) new PlayerSpawnPointComponent()
    {
      team = this.team,
      matchType = this.matchType
    };

    private void OnDrawGizmos()
    {
      Gizmos.color = this.gizmoColor;
      Gizmos.DrawSphere(this.transform.position, 0.25f);
    }
  }
}
