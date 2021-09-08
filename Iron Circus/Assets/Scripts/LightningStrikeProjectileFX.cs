// Decompiled with JetBrains decompiler
// Type: LightningStrikeProjectileFX
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas.Unity;
using Imi.SharedWithServer.ScEntitas;
using Imi.SteelCircus.ScriptableObjects;
using SteelCircus.Core;
using UnityEngine;

public class LightningStrikeProjectileFX : MonoBehaviour
{
  private GameEntity entity;
  [SerializeField]
  private ParticleSystem trail;
  [SerializeField]
  private float brightness = 3f;
  protected static readonly int _Color = Shader.PropertyToID(nameof (_Color));

  private void Start()
  {
    this.entity = (GameEntity) this.gameObject.GetEntityLink().entity;
    if (this.entity == null || !this.entity.hasProjectile)
    {
      Object.Destroy((Object) this.gameObject);
    }
    else
    {
      GameEntity entityWithPlayerId = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(this.entity.projectile.owner);
      if (entityWithPlayerId == null)
      {
        Object.Destroy((Object) this.gameObject);
      }
      else
      {
        ColorsConfig instance = SingletonScriptableObject<ColorsConfig>.Instance;
        this.trail.GetComponent<ParticleSystemRenderer>().material.SetColor(LightningStrikeProjectileFX._Color, instance.LightColor(entityWithPlayerId.playerTeam.value) * this.brightness);
        this.trail.transform.parent = (Transform) null;
        MatchObjectsParent.Add(this.trail.transform);
      }
    }
  }

  private void OnDestroy()
  {
    if (!((Object) this.trail != (Object) null))
      return;
    this.trail.emission.enabled = false;
  }

  private void Update()
  {
    if (!((Object) this.trail != (Object) null) || !((Object) this.transform != (Object) null))
      return;
    this.trail.transform.position = this.transform.position;
  }
}
