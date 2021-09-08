// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.GameElements.PickupView
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.SteelCircus.FX;
using SteelCircus.GameElements;
using System.Collections;
using UnityEngine;

namespace Imi.SteelCircus.GameElements
{
  public class PickupView : FloorSpawnableObject, IPickupView
  {
    [SerializeField]
    private Animation pickupBaseAnimation;
    [SerializeField]
    private Animator pickupAnimator;
    [SerializeField]
    private GameObject pickupHologramSpehere;
    [SerializeField]
    private GameObject pickupHologramIcon;
    [ColorUsage(true, true)]
    [SerializeField]
    private Color lensOffColor;
    [ColorUsage(true, true)]
    [SerializeField]
    private Color lensOnColor;
    [SerializeField]
    private Renderer lensRenderer;
    [ColorUsage(true, true)]
    [SerializeField]
    private Color lensProjectionColor;
    [SerializeField]
    private Renderer lensProjection;
    private Material lensProjectionMat;
    private Material lensMat;
    private bool animStarted;
    public GameEntity GameEntity;

    private void Awake()
    {
      this.lensMat = this.lensRenderer.materials[1];
      this.lensMat.SetColor("_EmissionColor", this.lensOffColor);
      this.lensProjectionMat = this.lensProjection.material;
    }

    public void PlaySpawnEffect()
    {
      if (this.GameEntity.pickup.pickupSize == PickupSize.Small)
      {
        this.pickupHologramSpehere.SetActive(true);
        this.pickupHologramIcon.SetActive(true);
        this.Spawn(0.35f);
      }
      else
        this.Spawn();
      if (this.GameEntity.pickup.activeType == PickupType.RefreshSkills)
        AudioController.Play("SkillSpawn");
      else if (this.GameEntity.pickup.activeType == PickupType.RegainHealth)
      {
        AudioController.Play("HealthSpawn");
      }
      else
      {
        if (this.GameEntity.pickup.activeType != PickupType.RefreshSprint)
          return;
        AudioController.Play("SkillSpawn");
      }
    }

    private void OnDestroy() => this.VirtualOnDestroy();

    private void Update()
    {
      if (this.pickupBaseAnimation.isPlaying || !this.animStarted)
        return;
      this.lensMat.SetColor("_EmissionColor", this.lensOnColor);
      this.animStarted = false;
    }

    protected override void OnSpawnComplete(FloorSpawnFX spawnFX)
    {
      base.OnSpawnComplete(spawnFX);
      if (!this.gameObject.activeInHierarchy)
        return;
      if (this.GameEntity.pickup.pickupSize == PickupSize.Small)
      {
        this.pickupAnimator.SetTrigger("play");
      }
      else
      {
        this.pickupBaseAnimation.Play();
        this.pickupAnimator.SetTrigger("play");
        this.StartCoroutine(this.FadeInLensProjection());
      }
      this.animStarted = true;
    }

    private IEnumerator FadeInLensProjection()
    {
      Color lensColor = this.lensProjectionMat.color;
      for (int i = 0; i <= 5; ++i)
      {
        this.lensProjectionMat.SetColor("_Color", Color.Lerp(lensColor, this.lensProjectionColor, (float) i * 0.2f));
        yield return (object) new WaitForSeconds(0.1f);
      }
      this.pickupHologramSpehere.SetActive(true);
      this.pickupHologramIcon.SetActive(true);
    }

    public void PlayPickupSpawn(bool activeOnStart, PickupType pickupType) => this.PlaySpawnEffect();
  }
}
