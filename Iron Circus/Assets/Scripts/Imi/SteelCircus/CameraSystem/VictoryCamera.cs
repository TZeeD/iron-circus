// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.CameraSystem.VictoryCamera
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using UnityEngine;

namespace Imi.SteelCircus.CameraSystem
{
  public class VictoryCamera : MonoBehaviour
  {
    [SerializeField]
    private GameObject alphaVictoryCamera;
    [SerializeField]
    private GameObject betaVictoryCamera;
    [SerializeField]
    private GameObject drawCamera;

    public void ShowVictoryCamera(Team winningTeam)
    {
      this.alphaVictoryCamera.SetActive(winningTeam == Team.Alpha);
      this.betaVictoryCamera.SetActive(winningTeam == Team.Beta);
      this.drawCamera.SetActive(winningTeam == Team.None);
    }
  }
}
