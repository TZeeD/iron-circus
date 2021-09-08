// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.DebugPreviewAoeState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.JitterUnity;
using Jitter.LinearMath;
using System.Collections.Generic;
using UnityEngine;

namespace Imi.SharedWithServer.Game.Skills
{
  public class DebugPreviewAoeState : SkillState
  {
    public SkillVar<JVector> position;
    public SkillVar<JVector> lookDir;
    public ConfigValue<float> radius;
    private List<GameObject> cachedPreviews = new List<GameObject>();

    protected override SkillStateExecutionFlag SkillStateExecutionFlag => SkillStateExecutionFlag.TickRemoteEntities;

    protected override void TickDerived()
    {
      while (this.position.Length > this.cachedPreviews.Count)
      {
        GameObject primitive = GameObject.CreatePrimitive(PrimitiveType.Sphere);
        Renderer component = primitive.GetComponent<Renderer>();
        if ((Object) component != (Object) null)
        {
          Material material = component.material;
          Color color = material.color;
          color.a = 0.1f;
          material.color = color;
        }
        this.cachedPreviews.Add(primitive);
      }
      for (int index = 0; index < this.cachedPreviews.Count; ++index)
      {
        if (index < this.position.Length)
        {
          this.cachedPreviews[index].transform.position = this.position[index].ToVector3();
          this.cachedPreviews[index].transform.localScale = Vector3.one * this.radius.Get();
          this.cachedPreviews[index].SetActive(true);
        }
        else
          this.cachedPreviews[index].SetActive(false);
      }
    }

    protected override void ExitDerived()
    {
      for (int index = 0; index < this.cachedPreviews.Count; ++index)
        this.cachedPreviews[index].SetActive(false);
    }
  }
}
