// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.CameraSystem.GoalCamera
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using UnityEngine;

namespace Imi.SteelCircus.CameraSystem
{
  public class GoalCamera : MonoBehaviour
  {
    [SerializeField]
    private GameObject alphaGoalCamera;
    [SerializeField]
    private GameObject betaGoalCamera;

    public void ShowGoalCamera(Team scoringTeam)
    {
      this.alphaGoalCamera.SetActive(scoringTeam == Team.Alpha);
      this.betaGoalCamera.SetActive(scoringTeam == Team.Beta);
    }
  }
}
