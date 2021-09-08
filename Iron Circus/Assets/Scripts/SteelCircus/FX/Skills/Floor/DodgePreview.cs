// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.Floor.DodgePreview
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SteelCircus.ScriptableObjects;
using UnityEngine;

namespace SteelCircus.FX.Skills.Floor
{
  public class DodgePreview : FloorEffectBase
  {
    private const float playerRadius = 2.175f;
    protected static readonly int _AspectRatio = Shader.PropertyToID(nameof (_AspectRatio));
    protected static readonly int _InnerAnimation = Shader.PropertyToID(nameof (_InnerAnimation));
    private float counter;
    private float dodgeDuration = 0.45f;
    private GameEntity owner;
    private float localPlayerDelayDuration;
    private const float localPlayerMaxDelay = 0.1f;
    [SerializeField]
    private GameObject renderableObjectsParent;

    protected override void Update()
    {
      this.counter += Time.deltaTime;
      this.renderableObjectsParent.SetActive((double) this.counter >= (double) this.localPlayerDelayDuration);
      if ((double) this.counter >= (double) this.localPlayerDelayDuration)
        this.SetPropertyIfExists(DodgePreview._InnerAnimation, Mathf.Clamp01((float) (((double) this.counter - (double) this.localPlayerDelayDuration) / ((double) this.dodgeDuration - (double) this.localPlayerDelayDuration))));
      if ((double) this.counter < (double) this.dodgeDuration)
        return;
      Object.Destroy((Object) this.gameObject);
    }

    public override void SetOwner(GameEntity entity)
    {
      base.SetOwner(entity);
      this.owner = entity;
      this.SetPropertyIfExists(FloorEffectBase._ColorBuildupBG, SingletonScriptableObject<ColorsConfig>.Instance.aoeColorNeutral);
      this.SetPropertyIfExists(DodgePreview._InnerAnimation, 0.0f);
      this.SetPropertyIfExists(FloorEffectBase._BuildupBGTime, 1f);
    }

    public override void SetArgs(object args)
    {
      base.SetArgs(args);
      TackleDodgeConfig.DodgeFXParams dodgeFxParams = (TackleDodgeConfig.DodgeFXParams) args;
      double distance = (double) dodgeFxParams.distance;
      this.dodgeDuration = dodgeFxParams.duration;
      if (this.owner.isLocalEntity)
        this.localPlayerDelayDuration = Mathf.Min(0.1f, (float) ((double) this.owner.connectionInfo.rttMillis * 0.5 / 1000.0));
      float z = (float) (distance + 2.17499995231628);
      foreach (Transform scaleNode in this.scaleNodes)
        scaleNode.localScale = new Vector3(2.175f, 1f, z);
      this.SetPropertyIfExists(DodgePreview._AspectRatio, z / 2.175f);
      this.transform.position -= this.transform.forward * 2.175f * 0.5f;
      this.Update();
    }
  }
}
