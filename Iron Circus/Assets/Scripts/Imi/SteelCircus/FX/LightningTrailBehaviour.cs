// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.FX.LightningTrailBehaviour
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using DigitalRuby.LightningBolt;
using System.Collections.Generic;
using UnityEngine;

namespace Imi.SteelCircus.FX
{
  public class LightningTrailBehaviour : MonoBehaviour
  {
    private List<Vector3> startPositions;
    private LightningBoltScript[] bolts;
    private LineRenderer[] lineRenderers;

    private void Awake()
    {
      this.bolts = this.GetComponentsInChildren<LightningBoltScript>(true);
      this.lineRenderers = this.GetComponentsInChildren<LineRenderer>(true);
    }

    private void OnEnable()
    {
      this.startPositions = new List<Vector3>();
      foreach (LightningBoltScript bolt in this.bolts)
      {
        bolt.Generations = Random.Range(5, 7);
        bolt.Duration = Random.Range(0.025f, 0.075f);
        bolt.Rows = Random.Range(1, 2);
        bolt.Columns = Random.Range(1, 2);
        bolt.ChaosFactor = Random.Range(0.2f, 0.3f);
        bolt.EndObject.transform.position = bolt.transform.position;
        this.startPositions.Add(bolt.transform.position);
      }
      this.ResetLineRenderers();
    }

    private void Update()
    {
      int index = 0;
      foreach (LightningBoltScript bolt in this.bolts)
      {
        bolt.EndObject.transform.position = this.startPositions[index];
        ++index;
      }
    }

    private void ResetLineRenderers()
    {
      foreach (LineRenderer lineRenderer in this.lineRenderers)
      {
        lineRenderer.positionCount = 0;
        lineRenderer.widthMultiplier = Random.Range(2.5f, 3.5f);
      }
    }
  }
}
