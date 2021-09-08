// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.CageFX
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game.Skills;
using Imi.SteelCircus.ScriptableObjects;
using UnityEngine;

namespace SteelCircus.FX.Skills
{
  public class CageFX : MonoBehaviour, IVfx
  {
    [SerializeField]
    private Transform cageModel;
    protected static readonly int _Color = Shader.PropertyToID(nameof (_Color));

    public void SetOwner(GameEntity entity)
    {
      ColorsConfig instance = SingletonScriptableObject<ColorsConfig>.Instance;
      this.cageModel.GetComponent<Renderer>().material.SetColor(CageFX._Color, instance.LightColor(entity.playerTeam.value));
    }

    public void SetArgs(object args)
    {
    }

    public void SetSkillGraph(SkillGraph graph)
    {
    }
  }
}
