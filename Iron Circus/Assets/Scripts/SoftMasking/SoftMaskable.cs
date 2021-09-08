// Decompiled with JetBrains decompiler
// Type: SoftMasking.SoftMaskable
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SoftMasking.Extensions;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace SoftMasking
{
  [ExecuteInEditMode]
  [DisallowMultipleComponent]
  [AddComponentMenu("")]
  public class SoftMaskable : UIBehaviour, IMaterialModifier
  {
    private ISoftMask _mask;
    private Graphic _graphic;
    private Material _replacement;
    private bool _affectedByMask;
    private bool _destroyed;
    private static List<ISoftMask> s_softMasks = new List<ISoftMask>();
    private static List<Canvas> s_canvases = new List<Canvas>();

    public bool shaderIsNotSupported { get; private set; }

    public bool isMaskingEnabled => this.mask != null && this.mask.isAlive && this.mask.isMaskingEnabled && this._affectedByMask;

    public ISoftMask mask
    {
      get => this._mask;
      private set
      {
        if (this._mask == value)
          return;
        if (this._mask != null)
          this.replacement = (Material) null;
        this._mask = value == null || !value.isAlive ? (ISoftMask) null : value;
        this.Invalidate();
      }
    }

    public Material GetModifiedMaterial(Material baseMaterial)
    {
      if (this.isMaskingEnabled)
      {
        this.replacement = this.mask.GetReplacement(baseMaterial);
        if ((bool) (Object) this.replacement)
        {
          this.shaderIsNotSupported = false;
          return this.replacement;
        }
        if (!baseMaterial.HasDefaultUIShader())
          this.SetShaderNotSupported(baseMaterial);
      }
      else
      {
        this.shaderIsNotSupported = false;
        this.replacement = (Material) null;
      }
      return baseMaterial;
    }

    public void Invalidate()
    {
      if (!(bool) (Object) this.graphic)
        return;
      this.graphic.SetMaterialDirty();
    }

    public void MaskMightChanged()
    {
      if (!this.FindMaskOrDie())
        return;
      this.Invalidate();
    }

    protected override void Awake()
    {
      base.Awake();
      this.hideFlags = HideFlags.HideInInspector;
    }

    protected override void OnEnable()
    {
      base.OnEnable();
      if (!this.FindMaskOrDie())
        return;
      this.RequestChildTransformUpdate();
    }

    protected override void OnDisable()
    {
      base.OnDisable();
      this.mask = (ISoftMask) null;
    }

    protected override void OnDestroy()
    {
      base.OnDestroy();
      this._destroyed = true;
    }

    protected override void OnTransformParentChanged()
    {
      base.OnTransformParentChanged();
      this.FindMaskOrDie();
    }

    protected override void OnCanvasHierarchyChanged()
    {
      base.OnCanvasHierarchyChanged();
      this.FindMaskOrDie();
    }

    private void OnTransformChildrenChanged() => this.RequestChildTransformUpdate();

    private void RequestChildTransformUpdate()
    {
      if (this.mask == null)
        return;
      this.mask.UpdateTransformChildren(this.transform);
    }

    private Graphic graphic => !(bool) (Object) this._graphic ? (this._graphic = this.GetComponent<Graphic>()) : this._graphic;

    private Material replacement
    {
      get => this._replacement;
      set
      {
        if (!((Object) this._replacement != (Object) value))
          return;
        if ((Object) this._replacement != (Object) null && this.mask != null)
          this.mask.ReleaseReplacement(this._replacement);
        this._replacement = value;
      }
    }

    private bool FindMaskOrDie()
    {
      if (this._destroyed)
        return false;
      this.mask = SoftMaskable.NearestMask(this.transform, out this._affectedByMask) ?? SoftMaskable.NearestMask(this.transform, out this._affectedByMask, false);
      if (this.mask != null)
        return true;
      this._destroyed = true;
      Object.DestroyImmediate((Object) this);
      return false;
    }

    private static ISoftMask NearestMask(
      Transform transform,
      out bool processedByThisMask,
      bool enabledOnly = true)
    {
      processedByThisMask = true;
      for (Transform transform1 = transform; (bool) (Object) transform1; transform1 = transform1.parent)
      {
        if ((Object) transform1 != (Object) transform)
        {
          ISoftMask isoftMask = SoftMaskable.GetISoftMask(transform1, enabledOnly);
          if (isoftMask != null)
            return isoftMask;
        }
        if (SoftMaskable.IsOverridingSortingCanvas(transform1))
          processedByThisMask = false;
      }
      return (ISoftMask) null;
    }

    private static ISoftMask GetISoftMask(Transform current, bool shouldBeEnabled = true)
    {
      ISoftMask component = SoftMaskable.GetComponent<ISoftMask>((Component) current, SoftMaskable.s_softMasks);
      return component != null && component.isAlive && (!shouldBeEnabled || component.isMaskingEnabled) ? component : (ISoftMask) null;
    }

    private static bool IsOverridingSortingCanvas(Transform transform)
    {
      Canvas component = SoftMaskable.GetComponent<Canvas>((Component) transform, SoftMaskable.s_canvases);
      return (bool) (Object) component && component.overrideSorting;
    }

    private static T GetComponent<T>(Component component, List<T> cachedList) where T : class
    {
      component.GetComponents<T>(cachedList);
      using (new ClearListAtExit<T>(cachedList))
        return cachedList.Count > 0 ? cachedList[0] : default (T);
    }

    private void SetShaderNotSupported(Material material)
    {
      if (this.shaderIsNotSupported)
        return;
      Debug.LogWarningFormat((Object) this.gameObject, "SoftMask will not work on {0} because material {1} doesn't support masking. Add masking support to your material or set Graphic's material to None to use a default one.", (object) this.graphic, (object) material);
      this.shaderIsNotSupported = true;
    }
  }
}
