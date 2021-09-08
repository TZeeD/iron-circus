// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.RampageTrailFX
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game.Skills;
using Imi.SteelCircus.Utils.Extensions;
using UnityEngine;

namespace SteelCircus.FX.Skills
{
  public class RampageTrailFX : MonoBehaviour, IVfx
  {
    [SerializeField]
    private TrailFollowTransform leftHand;
    [SerializeField]
    private TrailFollowTransform rightHand;
    [SerializeField]
    private string leftHandBoneName;
    [SerializeField]
    private string rightHandBoneName;
    public AnimationCurve moveSpeedToTrailLength = AnimationCurve.Linear(0.0f, 0.1f, 20f, 0.1f);

    public void SetOwner(GameEntity entity)
    {
      Transform transform = entity.unityView.gameObject.transform;
      Transform deepChild1 = transform.FindDeepChild(this.leftHandBoneName);
      Transform deepChild2 = transform.FindDeepChild(this.rightHandBoneName);
      this.leftHand.Target = deepChild1;
      this.rightHand.Target = deepChild2;
      this.leftHand.moveSpeedToTrailLength = this.moveSpeedToTrailLength;
      this.rightHand.moveSpeedToTrailLength = this.moveSpeedToTrailLength;
    }

    public void SetArgs(object args)
    {
    }

    public void SetSkillGraph(SkillGraph graph)
    {
    }
  }
}
