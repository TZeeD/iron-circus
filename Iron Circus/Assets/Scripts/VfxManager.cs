// Decompiled with JetBrains decompiler
// Type: VfxManager
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SteelCircus.JitterUnity;
using Jitter.LinearMath;
using SteelCircus.Core;
using SteelCircus.FX.Skills;
using System.Collections.Generic;
using UnityEngine;

public static class VfxManager
{
  public static readonly VfxPrefab DefaultAoePrefab = new VfxPrefab(Resources.Load<GameObject>("Prefabs/Effects/AoePreviews/Default/DefaultAoePreview"));
  private static Dictionary<VfxManager.FXKey, GameObject> activeEffects = new Dictionary<VfxManager.FXKey, GameObject>(50);
  private static Dictionary<VfxManager.FXKey, int> lastEffectSpawnTicks = new Dictionary<VfxManager.FXKey, int>(50);

  public static void PlayVfxOneShot(
    SkillGraph instigator,
    VfxPrefab effect,
    JVector position,
    JVector lookDir,
    bool localSpace = false,
    object args = null)
  {
    GameObject fromPool = VfxManager.GetFromPool(instigator, effect, position, lookDir, localSpace);
    VfxManager.SetSkillGraph(fromPool, instigator);
    VfxManager.SetOwner(fromPool, instigator.GetOwner());
    VfxManager.SetArgs(fromPool, args);
  }

  public static void PlayAoeVfxOneShot(
    SkillGraph instigator,
    VfxPrefab effect,
    AreaOfEffect aoe,
    JVector position,
    JVector lookDir,
    object args = null)
  {
    GameObject fromPool = VfxManager.GetFromPool(instigator, effect, position, lookDir);
    VfxManager.SetSkillGraph(fromPool, instigator);
    VfxManager.SetOwner(fromPool, instigator.GetOwner());
    VfxManager.SetAoe(fromPool, aoe);
    VfxManager.SetArgs(fromPool, args);
  }

  public static void StartVfx(
    SkillGraph instigator,
    VfxPrefab effect,
    JVector position,
    JVector lookDir,
    bool localSpace = true,
    object args = null)
  {
    VfxManager.FXKey key = new VfxManager.FXKey(instigator, effect);
    if (VfxManager.activeEffects.ContainsKey(key))
      return;
    GameObject fromPool = VfxManager.GetFromPool(instigator, effect, position, lookDir, localSpace);
    VfxManager.SetSkillGraph(fromPool, instigator);
    VfxManager.SetOwner(fromPool, instigator.GetOwner());
    VfxManager.SetArgs(fromPool, args);
    VfxManager.activeEffects.Add(key, fromPool);
  }

  public static void StartAoeVfx(
    SkillGraph instigator,
    VfxPrefab effect,
    AreaOfEffect aoe,
    JVector position,
    JVector lookDir,
    bool localSpace = true,
    object args = null)
  {
    VfxManager.FXKey key = new VfxManager.FXKey(instigator, effect);
    if (VfxManager.activeEffects.ContainsKey(key))
      return;
    GameObject fromPool = VfxManager.GetFromPool(instigator, effect, position, lookDir, localSpace);
    VfxManager.SetSkillGraph(fromPool, instigator);
    VfxManager.SetOwner(fromPool, instigator.GetOwner());
    VfxManager.SetAoe(fromPool, aoe);
    VfxManager.SetArgs(fromPool, args);
    VfxManager.activeEffects.Add(key, fromPool);
  }

  public static void UpdateVfx(
    SkillGraph instigator,
    VfxPrefab effect,
    TransformComponent transform)
  {
    VfxManager.FXKey key = new VfxManager.FXKey(instigator, effect);
    if (!VfxManager.activeEffects.ContainsKey(key))
      return;
    Transform transform1 = VfxManager.activeEffects[key].transform;
    transform1.position = transform.position.ToVector3();
    transform1.rotation = Quaternion.LookRotation(transform.Forward.ToVector3(), Vector3.up);
  }

  public static void UpdateVfx(
    SkillGraph instigator,
    VfxPrefab effect,
    JVector position,
    JQuaternion rotation,
    bool localPosition = true,
    bool localRotation = true)
  {
    VfxManager.FXKey key = new VfxManager.FXKey(instigator, effect);
    if (!VfxManager.activeEffects.ContainsKey(key))
      return;
    Transform transform = VfxManager.activeEffects[key].transform;
    if (localPosition)
      transform.localPosition = position.ToVector3();
    else
      transform.position = position.ToVector3();
    if (localRotation)
      transform.localRotation = rotation.ToQuaternion();
    else
      transform.rotation = rotation.ToQuaternion();
  }

  public static void UpdateVfx(
    SkillGraph instigator,
    VfxPrefab effect,
    JVector position,
    bool isLocal = true)
  {
    VfxManager.FXKey key = new VfxManager.FXKey(instigator, effect);
    if (!VfxManager.activeEffects.ContainsKey(key))
      return;
    Transform transform = VfxManager.activeEffects[key].transform;
    if (isLocal)
      transform.localPosition = position.ToVector3();
    else
      transform.position = position.ToVector3();
  }

  public static void UpdateVfxAoe(SkillGraph instigator, VfxPrefab effect, AreaOfEffect aoe)
  {
    VfxManager.FXKey key = new VfxManager.FXKey(instigator, effect);
    if (!VfxManager.activeEffects.ContainsKey(key))
      return;
    VfxManager.SetAoe(VfxManager.activeEffects[key], aoe);
  }

  public static void UpdateRotationVfx(
    SkillGraph instigator,
    VfxPrefab effect,
    JVector lookDir,
    bool isLocal = true)
  {
    VfxManager.FXKey key = new VfxManager.FXKey(instigator, effect);
    if (!VfxManager.activeEffects.ContainsKey(key))
      return;
    Transform transform = VfxManager.activeEffects[key].transform;
    if (isLocal)
      transform.localRotation = Quaternion.LookRotation(lookDir.ToVector3(), Vector3.up);
    else
      transform.rotation = Quaternion.LookRotation(lookDir.ToVector3(), Vector3.up);
  }

  public static void UnparentVfx(SkillGraph instigator, VfxPrefab effect)
  {
    VfxManager.FXKey key = new VfxManager.FXKey(instigator, effect);
    if (!VfxManager.activeEffects.ContainsKey(key))
      return;
    VfxManager.activeEffects[key].transform.SetParent(MatchObjectsParent.Transform, true);
  }

  public static void ParentVfx(SkillGraph instigator, VfxPrefab effect)
  {
    VfxManager.FXKey key = new VfxManager.FXKey(instigator, effect);
    if (!VfxManager.activeEffects.ContainsKey(key))
      return;
    GameObject activeEffect = VfxManager.activeEffects[key];
    GameObject gameObject = instigator.GetOwner()?.unityView?.gameObject;
    if (!((Object) gameObject != (Object) null))
      return;
    activeEffect.transform.parent = gameObject.transform;
  }

  public static bool IsVfxParented(SkillGraph instigator, VfxPrefab effect)
  {
    VfxManager.FXKey key = new VfxManager.FXKey(instigator, effect);
    if (!VfxManager.activeEffects.ContainsKey(key))
      return false;
    GameObject activeEffect = VfxManager.activeEffects[key];
    if (!((Object) activeEffect != (Object) null))
      return false;
    return (Object) activeEffect.transform.parent != (Object) null || (Object) activeEffect.transform.parent == (Object) MatchObjectsParent.Transform;
  }

  public static void UpdateVfx(SkillGraph instigator, VfxPrefab effect, object args)
  {
    VfxManager.FXKey key = new VfxManager.FXKey(instigator, effect);
    if (!VfxManager.activeEffects.ContainsKey(key))
      return;
    VfxManager.SetArgs(VfxManager.activeEffects[key], args);
  }

  public static void StopVfx(SkillGraph instigator, VfxPrefab effect, bool deferred = false)
  {
    VfxManager.FXKey key = new VfxManager.FXKey(instigator, effect);
    if (!VfxManager.activeEffects.ContainsKey(key))
      return;
    GameObject activeEffect = VfxManager.activeEffects[key];
    VfxManager.activeEffects.Remove(key);
    if (!deferred)
    {
      VfxManager.ReturnToPool(activeEffect);
    }
    else
    {
      IVfxWithDeferredStop componentInChildren = activeEffect.GetComponentInChildren<IVfxWithDeferredStop>();
      if (componentInChildren == null)
      {
        Debug.LogError((object) "deferred paramter in StopVfx() may only be true if the effect has an IVfxWithDeferredStop component.");
        VfxManager.ReturnToPool(activeEffect);
      }
      else
        componentInChildren.OnStopRequested();
    }
  }

  public static void ReturnToPool(GameObject go) => Object.Destroy((Object) go);

  public static void Reset()
  {
    VfxManager.activeEffects.Clear();
    VfxManager.lastEffectSpawnTicks.Clear();
  }

  private static GameObject GetFromPool(
    SkillGraph instigator,
    VfxPrefab effect,
    JVector position,
    JVector lookDir,
    bool localSpace = false)
  {
    if ((double) lookDir.LengthSquared() == 0.0)
      lookDir = JVector.Forward;
    Transform parent = (Transform) null;
    if (localSpace)
    {
      GameObject gameObject = instigator.GetOwner()?.unityView?.gameObject;
      if ((Object) gameObject != (Object) null)
        parent = gameObject.transform;
    }
    GameObject go = Object.Instantiate<GameObject>(effect.value, parent);
    go.transform.localPosition = position.ToVector3();
    go.transform.localRotation = Quaternion.LookRotation(lookDir.ToVector3());
    if (!localSpace)
      MatchObjectsParent.Add(go);
    return go;
  }

  private static void SetOwner(GameObject vfxInstance, GameEntity owner)
  {
    foreach (IVfx componentsInChild in vfxInstance.GetComponentsInChildren<IVfx>())
      componentsInChild.SetOwner(owner);
  }

  private static void SetSkillGraph(GameObject vfxInstance, SkillGraph graph)
  {
    foreach (IVfx componentsInChild in vfxInstance.GetComponentsInChildren<IVfx>())
      componentsInChild.SetSkillGraph(graph);
  }

  private static void SetAoe(GameObject vfxInstance, AreaOfEffect aoe)
  {
    foreach (IAoeVfx componentsInChild in vfxInstance.GetComponentsInChildren<IAoeVfx>())
      componentsInChild.SetAoe(aoe);
  }

  private static void SetArgs(GameObject vfxInstance, object args)
  {
    foreach (IVfx componentsInChild in vfxInstance.GetComponentsInChildren<IVfx>())
      componentsInChild.SetArgs(args);
  }

  private struct FXKey
  {
    public SkillGraph instigator;
    public VfxPrefab effect;

    public FXKey(SkillGraph instigator, VfxPrefab effect)
    {
      this.instigator = instigator;
      this.effect = effect;
    }
  }
}
