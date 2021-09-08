// Decompiled with JetBrains decompiler
// Type: PickupSpawnpointUnityBehaviour
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.EntitasShared.Components.Pickup;
using Imi.SharedWithServer.Game;
using Imi.SteelCircus.GameElements;
using Imi.SteelCircus.Rendering;
using SteelCircus.Core;
using SteelCircus.GameElements;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PickupSpawnpointUnityBehaviour : PickupSpawnpointUnityBehaviourBase
{
  [SerializeField]
  private bool fillRingContinously;
  [SerializeField]
  private GameObject spawnPointRing;
  [SerializeField]
  private float maxRadius = 0.175f;
  private Material mat;
  private PickupSpawnFloorUi pickupSpawnFloorUi;

  private void Awake()
  {
    this.InitializeBase();
    this.mat = this.spawnPointRing.GetComponent<Renderer>().material;
    this.mat.SetFloat("_Fillpercentage", 0.0f);
    this.mat.SetFloat("_Radius", this.maxRadius);
    this.CreatePickupViews();
  }

  protected override void CreatePickupViews()
  {
    this.PickupViews = new Dictionary<PickupType, GameObject>();
    foreach (PickupData pickupData in this.pickup.spawnData)
    {
      PickupType type = pickupData.type;
      GameObject gameObject = UnityEngine.Object.Instantiate<GameObject>(SingletonScriptableObject<PickupConfig>.Instance.GetPickup(type, this.pickup.pickupSize), this.transform.position, Quaternion.identity);
      this.PickupViews.Add(type, gameObject);
      gameObject.transform.SetParent(this.transform);
      gameObject.SetActive(false);
    }
    GameObject gameObject1 = UnityEngine.Object.Instantiate<GameObject>(Resources.Load<GameObject>("Prefabs/Pickups/PickupCountdownText"), this.transform.position, Quaternion.identity);
    this.pickupSpawnFloorUi = gameObject1.GetComponent<PickupSpawnFloorUi>();
    if (this.pickup.pickupSize == PickupSize.Small)
    {
      this.spawnPointRing.SetActive(false);
      gameObject1.transform.localScale = new Vector3(0.4f, 0.4f, 0.4f);
    }
    MatchObjectsParent.FloorRenderer.AddToLayer(gameObject1.transform, FloorRenderer.FloorLayer.Emissive);
    gameObject1.transform.SetParent(MatchObjectsParent.FloorRenderer.GetCanvas().transform);
    gameObject1.SetActive(false);
  }

  public override void ActivatePickupView(GameEntity entity)
  {
    PickupType activeType = entity.pickup.activeType;
    if (this.PickupViews.ContainsKey(activeType))
    {
      this.PickupViews[activeType].SetActive(true);
      int pickupSize = (int) this.pickup.pickupSize;
      this.pickupGo = this.PickupViews[activeType];
      PickupView component = this.pickupGo.GetComponent<PickupView>();
      component.GameEntity = entity;
      component.PlayPickupSpawn(true, activeType);
    }
    else
      Log.Error("No PickupView found for " + (object) activeType);
  }

  public override void DeactivatePickupView(PickupType type)
  {
    if (this.PickupViews.ContainsKey(type))
    {
      this.PickupViews[type].SetActive(false);
      if (this.pickup.pickupSize != PickupSize.Big)
        return;
      this.mat.SetFloat("_Radius", this.maxRadius);
      this.pickupSpawnFloorUi.gameObject.SetActive(false);
      this.spawnPointRing.SetActive(true);
    }
    else
      Log.Error("No PickupView found for " + (object) type);
  }

  private IEnumerator ShrinkInnerRing()
  {
    this.mat.SetFloat("_Radius", this.maxRadius);
    this.spawnPointRing.SetActive(true);
    float t = 0.0f;
    while ((double) t < 2.0)
    {
      t += Time.deltaTime;
      this.mat.SetFloat("_Radius", this.maxRadius - (float) ((double) this.maxRadius * (double) t / 2.0));
      yield return (object) null;
    }
    this.spawnPointRing.SetActive(false);
    this.mat.SetFloat("_Radius", 0.0f);
  }

  public override void ShowPickupCountdown(UniqueId uId, PickupType type, float timeLeft) => this.pickupSpawnFloorUi.SetupUi(type, timeLeft);

  private void Update()
  {
    if (!this.runCooldown)
      return;
    this.OnUpdate();
  }

  protected override void OnUpdate()
  {
    if ((double) this.timeLeft <= 0.0)
      return;
    this.timeLeft -= Time.deltaTime;
    float num = (float) (1.0 - (double) this.timeLeft / (double) this.pickup.respawnDuration);
    if (this.fillRingContinously)
    {
      this.mat.SetFloat("_Fillpercentage", num);
    }
    else
    {
      if ((double) Math.Abs(num % 0.1f) >= 0.00999999977648258)
        return;
      this.mat.SetFloat("_Fillpercentage", num);
    }
  }

  private void OnDestroy() => this.CleanUpBase();
}
