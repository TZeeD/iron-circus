// Decompiled with JetBrains decompiler
// Type: SteelCircus.Debugging.Proxies.DebugProxyPlayer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.SteelCircus.JitterUnity;
using Imi.SteelCircus.Utils.Extensions;
using Jitter.LinearMath;
using SharedWithServer.ScEvents;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;

namespace SteelCircus.Debugging.Proxies
{
  public class DebugProxyPlayer : MonoBehaviour
  {
    public UniqueId id;
    private int lastTick;
    public Mesh arrowMesh;
    public Material arrowMaterial;
    public const int PoolSize = 200;
    private List<ProxyArrow> pooledElements;
    private List<ProxyArrow> activeElements;
    private Transform poolParent;
    private Matrix4x4[] matrices;
    private MaterialPropertyBlock propertyBlock;
    private Vector4[] colors;
    private bool initialized;

    private void Init()
    {
      GameObject original = Resources.Load<GameObject>("Prefabs/Testing/debug_proxy_arrow");
      this.propertyBlock = new MaterialPropertyBlock();
      this.colors = new Vector4[200];
      GameObject gameObject1 = new GameObject("Pool");
      gameObject1.transform.parent = this.transform;
      gameObject1.transform.SetToIdentity();
      this.poolParent = gameObject1.transform;
      this.pooledElements = new List<ProxyArrow>(200);
      this.activeElements = new List<ProxyArrow>(200);
      this.matrices = new Matrix4x4[200];
      for (int index = 0; index < 200; ++index)
      {
        GameObject gameObject2 = Object.Instantiate<GameObject>(original);
        gameObject2.transform.parent = this.poolParent;
        this.pooledElements.Add(gameObject2.GetComponent<ProxyArrow>());
        gameObject2.SetActive(false);
      }
    }

    private void Start() => Events.Global.OnEventProxyTransform += new Events.EventProxyTransform(this.OnProxyPosition);

    private void OnDestroy() => Events.Global.OnEventProxyTransform -= new Events.EventProxyTransform(this.OnProxyPosition);

    private void OnProxyPosition(
      int tick,
      UniqueId uniqueId,
      JVector position,
      JQuaternion rotation,
      bool show)
    {
      if (!(this.id == uniqueId))
        return;
      if (!this.initialized)
      {
        this.initialized = true;
        this.Init();
      }
      this.lastTick = tick;
      this.gameObject.SetActive(show);
      if (!show)
        return;
      this.Get(position.ToVector3(), rotation.ToQuaternion()).name = string.Format("Tick {0}", (object) this.lastTick);
    }

    private void ReturnToPool(ProxyArrow obj)
    {
      GameObject gameObject = obj.gameObject;
      gameObject.SetActive(false);
      this.pooledElements.Add(obj);
      this.activeElements.Remove(obj);
      gameObject.transform.parent = this.poolParent;
    }

    public GameObject Get(Vector3 position, Quaternion rotation)
    {
      int index = this.pooledElements.Count - 1;
      if (index == -1)
      {
        this.ReturnToPool(this.activeElements[0]);
        index = 0;
      }
      ProxyArrow pooledElement = this.pooledElements[index];
      GameObject gameObject = pooledElement.gameObject;
      this.pooledElements.RemoveAt(index);
      this.activeElements.Add(pooledElement);
      gameObject.SetActive(true);
      gameObject.transform.parent = this.transform;
      gameObject.transform.position = position;
      gameObject.transform.rotation = rotation;
      pooledElement.Init();
      return gameObject;
    }

    private void Update()
    {
      if (!this.initialized)
        return;
      for (int index = 0; index < this.activeElements.Count; ++index)
      {
        ProxyArrow activeElement = this.activeElements[index];
        activeElement.counter += Time.deltaTime;
        if ((double) activeElement.counter >= (double) activeElement.lifeTime)
        {
          this.ReturnToPool(activeElement);
          --index;
        }
        else
        {
          activeElement.UpdateVisuals();
          this.matrices[index] = activeElement.transform.localToWorldMatrix;
          this.colors[index] = (Vector4) Color.Lerp(activeElement.startColor, activeElement.endColor, activeElement.counter / activeElement.lifeTime);
        }
      }
      this.propertyBlock.SetVectorArray("_Color", this.colors);
    }

    private void OnRenderObject()
    {
      if (!this.initialized || (Camera.current.cullingMask & 1 << this.gameObject.layer) == 0)
        return;
      int count = this.activeElements.Count;
      if (count == 0)
        return;
      Graphics.DrawMeshInstanced(this.arrowMesh, 0, this.arrowMaterial, this.matrices, count, this.propertyBlock, ShadowCastingMode.Off, false);
    }
  }
}
