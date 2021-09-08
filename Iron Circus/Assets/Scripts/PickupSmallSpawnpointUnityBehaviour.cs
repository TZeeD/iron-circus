// Decompiled with JetBrains decompiler
// Type: PickupSmallSpawnpointUnityBehaviour
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.EntitasShared.Components.Pickup;
using Imi.SharedWithServer.Game;
using Imi.SteelCircus.GameElements;
using SteelCircus.GameElements;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PickupSmallSpawnpointUnityBehaviour : PickupSpawnpointUnityBehaviourBase
{
  [SerializeField]
  private GameObject spawnPointRing;
  [SerializeField]
  private float minRadius = 0.1f;
  [SerializeField]
  private float maxRadius = 1f;
  [SerializeField]
  private float minOpacity = 0.1f;
  [SerializeField]
  private float maxOpacity = 1f;
  [SerializeField]
  private float openRingDuration = 0.5f;
  [SerializeField]
  private float closeRingDuration = 0.5f;
  private Material mat;

  private void Awake()
  {
    this.InitializeBase();
    this.mat = this.spawnPointRing.GetComponent<Renderer>().material;
    this.mat.SetFloat("_Radius", this.minRadius);
    this.mat.SetFloat("_Fillpercentage", 0.0f);
    this.CreatePickupViews();
  }

  protected override void OnUpdate()
  {
  }

  protected override void CreatePickupViews()
  {
    this.PickupViews = new Dictionary<PickupType, GameObject>();
    foreach (PickupData pickupData in this.pickup.spawnData)
    {
      PickupType type = pickupData.type;
      GameObject gameObject = Object.Instantiate<GameObject>(SingletonScriptableObject<PickupConfig>.Instance.GetPickup(type, this.pickup.pickupSize), this.transform.position, Quaternion.identity);
      this.PickupViews.Add(type, gameObject);
      if ((Object) gameObject.GetComponent<PickupView>() == (Object) null)
        gameObject.GetComponent<IPickupView>().PlayPickupSpawn(this.pickup.isActiveOnStart, type);
      if (this.pickup.isActiveOnStart)
        this.mat.SetFloat("_Fillpercentage", 1f);
      gameObject.SetActive(false);
    }
  }

  public override void ActivatePickupView(GameEntity entity)
  {
    PickupType activeType = entity.pickup.activeType;
    if (this.PickupViews.ContainsKey(activeType))
    {
      this.pickupGo = this.PickupViews[activeType];
      this.StartCoroutine(this.PlayRingCloseOpenAnimation());
      this.pickupGo.SetActive(true);
      PickupView component = this.pickupGo.GetComponent<PickupView>();
      if ((Object) component != (Object) null)
        component.GameEntity = entity;
      this.pickupGo.GetComponent<IPickupView>().PlayPickupSpawn(true, activeType);
    }
    else
      Log.Error("No PickupView found for " + (object) activeType);
  }

  public override void DeactivatePickupView(PickupType type)
  {
    if (this.PickupViews.ContainsKey(type))
    {
      this.PickupViews[type].SetActive(false);
      this.mat.SetFloat("_Fillpercentage", 0.0f);
    }
    else
      Log.Error("No PickupView found for " + (object) type);
  }

  public override void ShowPickupCountdown(UniqueId uId, PickupType type, float timeLeft)
  {
  }

  private IEnumerator PlayRingCloseOpenAnimation()
  {
    PickupSmallSpawnpointUnityBehaviour spawnpointUnityBehaviour = this;
    yield return (object) spawnpointUnityBehaviour.StartCoroutine(spawnpointUnityBehaviour.CloseUpRing(spawnpointUnityBehaviour.closeRingDuration));
    yield return (object) spawnpointUnityBehaviour.StartCoroutine(spawnpointUnityBehaviour.OpenUpRing(spawnpointUnityBehaviour.openRingDuration));
  }

  private IEnumerator CloseUpRing(float closeDuration)
  {
    this.mat.SetFloat("_Radius", this.minRadius);
    float t = 0.0f;
    while ((double) t < (double) closeDuration)
    {
      t += Time.deltaTime;
      float num1 = Mathf.Lerp(this.minRadius, this.maxRadius, t / closeDuration);
      double num2 = (double) Mathf.Lerp(this.minOpacity, this.maxOpacity, t / closeDuration);
      this.mat.SetFloat("_Radius", num1);
      yield return (object) null;
    }
    this.mat.SetFloat("_Radius", this.maxRadius);
  }

  private IEnumerator OpenUpRing(float openDuration)
  {
    this.mat.SetFloat("_Radius", this.maxRadius);
    float t = 0.0f;
    while ((double) t < (double) openDuration)
    {
      t += Time.deltaTime;
      float num1 = this.maxRadius - this.maxRadius * (t / openDuration);
      double maxOpacity1 = (double) this.maxOpacity;
      double maxOpacity2 = (double) this.maxOpacity;
      double num2 = (double) t / (double) openDuration;
      this.mat.SetFloat("_Radius", num1);
      yield return (object) null;
    }
    this.mat.SetFloat("_Radius", this.minRadius);
  }

  private void OnDestroy() => this.CleanUpBase();
}
