// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.ModFloorUiState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.GameElements;
using Imi.SteelCircus.UI.Floor;
using SharedWithServer.ScEvents;
using UnityEngine;

namespace Imi.SharedWithServer.Game.Skills
{
  public class ModFloorUiState : SkillState
  {
    public FloorUiVisibilityState state;
    public bool showOverheadUi;

    protected override SkillStateExecutionFlag SkillStateExecutionFlag => SkillStateExecutionFlag.TickRemoteEntities;

    protected override void OnBecameActiveThisTick()
    {
      Events.Global.FireEventShowHidePlayerUi(this.skillGraph.GetOwnerId(), this.state != FloorUiVisibilityState.Hidden, this.showOverheadUi);
      this.UpdateFloorUiState(this.skillGraph.GetOwner(), this.state);
    }

    protected override void OnBecameInactiveThisTick()
    {
      this.UpdateFloorUiState(this.skillGraph.GetOwner(), FloorUiVisibilityState.Normal);
      Events.Global.FireEventShowHidePlayerUi(this.skillGraph.GetOwnerId(), true, true);
    }

    private void UpdateFloorUiState(GameEntity entity, FloorUiVisibilityState floorUiState)
    {
      if (!entity.hasUnityView)
        return;
      GameObject gameObject = entity.unityView.gameObject;
      if ((Object) gameObject == (Object) null)
        return;
      Player component = gameObject.GetComponent<Player>();
      if ((Object) component == (Object) null)
        return;
      PlayerFloorUI floorUi = component.FloorUI;
      if (floorUi.GetState() == floorUiState)
        return;
      floorUi.SetState(floorUiState);
    }
  }
}
