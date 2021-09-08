// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.FX.FloorSpawnFX
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SteelCircus.Core;
using System;
using UnityEngine;

namespace Imi.SteelCircus.FX
{
  public class FloorSpawnFX : MonoBehaviour
  {
    [SerializeField]
    private Transform spawnedObjectPosition;
    [SerializeField]
    private bool debugDontDestroy;
    private FloorSpawnFX.State state;
    [SerializeField]
    private Transform normals;
    [SerializeField]
    private Transform tube;
    [SerializeField]
    private Transform stencil;
    [SerializeField]
    private Transform platform;
    public float radius = 1f;
    [SerializeField]
    private float timeToOpen = 0.2f;
    [SerializeField]
    private AnimationCurve openAnimationCurve;
    [SerializeField]
    private float timeToSpawn = 0.2f;
    [SerializeField]
    private float timeToClose = 0.5f;
    [SerializeField]
    private AnimationCurve closeAnimationCurve;
    [SerializeField]
    private AnimationCurve platformAnimationCurve;
    private float counter;
    private Material normalsMaterial;
    [SerializeField]
    private float platformTopPos = -0.1f;
    [SerializeField]
    private float platformBottomPos = -3f;
    private static GameObject prefab;

    public event Action<FloorSpawnFX> onSpawnComplete;

    public event Action<FloorSpawnFX, Vector3> onSpawnedObjectPositionChanged;

    public Transform SpawnedObjectPosition => this.spawnedObjectPosition;

    public static FloorSpawnFX Get(Vector3 position, float radius = 1f)
    {
      if ((UnityEngine.Object) FloorSpawnFX.prefab == (UnityEngine.Object) null)
        FloorSpawnFX.prefab = Resources.Load<GameObject>("Prefabs/Effects/FloorSpawnVFX");
      GameObject gameObject = MatchObjectsParent.Add(UnityEngine.Object.Instantiate<GameObject>(FloorSpawnFX.prefab));
      FloorSpawnFX component = gameObject.GetComponent<FloorSpawnFX>();
      component.radius = radius;
      position.y = 0.0f;
      gameObject.transform.position = position;
      return component;
    }

    private void Awake()
    {
      this.normalsMaterial = this.normals.GetComponent<Renderer>().material;
      this.platform.transform.localPosition = Vector3.up * this.platformBottomPos;
      this.RaisePositionChanged();
      this.normalsMaterial.SetFloat("_AnimationProgress", 0.0f);
      this.stencil.localScale = Vector3.zero;
    }

    private void Start()
    {
      MatchObjectsParent.FloorRenderer.AddNormals(this.normals);
      this.normals.localEulerAngles = this.transform.localEulerAngles + new Vector3(90f, 0.0f, 0.0f);
      this.normals.localPosition = this.transform.localPosition;
      this.platform.transform.localPosition = Vector3.up * this.platformBottomPos;
      this.RaisePositionChanged();
      this.normals.localScale = this.radius * 5f * Vector3.one;
      Vector3 vector3 = Vector3.one * this.radius;
      vector3.y = 1f;
      this.tube.localScale = vector3;
      this.platform.localScale = vector3;
    }

    private void LateUpdate()
    {
      switch (this.state)
      {
        case FloorSpawnFX.State.Opening:
          this.AnimateOpen();
          break;
        case FloorSpawnFX.State.Spawning:
          this.AnimateSpawn();
          break;
        case FloorSpawnFX.State.Closing:
          this.AnimateClose();
          break;
        case FloorSpawnFX.State.DebugPause:
          this.counter += Time.deltaTime / 1.5f;
          if ((double) this.counter < 1.0)
            break;
          this.state = FloorSpawnFX.State.Opening;
          this.counter = 0.0f;
          break;
      }
    }

    private void AnimateOpen()
    {
      this.counter += Time.deltaTime / this.timeToOpen;
      this.counter = Mathf.Clamp01(this.counter);
      float num = this.openAnimationCurve.Evaluate(this.counter);
      this.platform.transform.localPosition = Vector3.up * Mathf.LerpUnclamped(this.platformBottomPos, this.platformTopPos, this.platformAnimationCurve.Evaluate(this.counter * (this.timeToOpen / (this.timeToOpen + this.timeToSpawn))));
      this.RaisePositionChanged();
      this.normalsMaterial.SetFloat("_AnimationProgress", num);
      this.stencil.localScale = Mathf.Clamp01((float) (((double) num - 0.5) * 2.0)) * this.radius * Vector3.one;
      if ((double) this.counter != 1.0)
        return;
      this.state = FloorSpawnFX.State.Spawning;
      this.counter = 0.0f;
    }

    private void AnimateSpawn()
    {
      this.counter += Time.deltaTime / this.timeToSpawn;
      this.counter = Mathf.Clamp01(this.counter);
      this.platform.transform.localPosition = Vector3.up * Mathf.LerpUnclamped(this.platformBottomPos, this.platformTopPos, this.platformAnimationCurve.Evaluate((this.counter * this.timeToSpawn + this.timeToOpen) / (this.timeToOpen + this.timeToSpawn)));
      this.RaisePositionChanged();
      if ((double) this.counter != 1.0)
        return;
      if (this.onSpawnComplete != null)
        this.onSpawnComplete(this);
      this.state = FloorSpawnFX.State.Closing;
      this.counter = 0.0f;
    }

    private void AnimateClose()
    {
      this.counter += Time.deltaTime / this.timeToClose;
      this.counter = Mathf.Clamp01(this.counter);
      float num = 1f - this.closeAnimationCurve.Evaluate(this.counter);
      this.normalsMaterial.SetFloat("_AnimationProgress", num);
      this.stencil.localScale = Mathf.Clamp01((float) (((double) num - 0.5) * 2.0)) * this.radius * Vector3.one;
      if ((double) this.counter != 1.0)
        return;
      if (!this.debugDontDestroy)
      {
        UnityEngine.Object.Destroy((UnityEngine.Object) this.gameObject);
        UnityEngine.Object.Destroy((UnityEngine.Object) this.normals.gameObject);
      }
      else
      {
        this.state = FloorSpawnFX.State.DebugPause;
        this.counter = 0.0f;
      }
    }

    private void RaisePositionChanged()
    {
      if (this.onSpawnedObjectPositionChanged == null)
        return;
      this.onSpawnedObjectPositionChanged(this, this.SpawnedObjectPosition.position);
    }

    private enum State
    {
      Opening,
      Spawning,
      Closing,
      DebugPause,
    }
  }
}
