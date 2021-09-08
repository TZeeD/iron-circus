// Decompiled with JetBrains decompiler
// Type: SoftMasking.SoftMask
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SoftMasking.Extensions;
using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace SoftMasking
{
  [ExecuteInEditMode]
  [DisallowMultipleComponent]
  [AddComponentMenu("UI/Soft Mask", 14)]
  [RequireComponent(typeof (RectTransform))]
  [HelpURL("https://docs.google.com/document/d/1XhJFNFHNyKXwWsErLkd1FBw0YgOCeo4qkjrMW9_H-hc")]
  public class SoftMask : UIBehaviour, ISoftMask, ICanvasRaycastFilter
  {
    [SerializeField]
    private Shader _defaultShader;
    [SerializeField]
    private Shader _defaultETC1Shader;
    [SerializeField]
    private SoftMask.MaskSource _source;
    [SerializeField]
    private RectTransform _separateMask;
    [SerializeField]
    private Sprite _sprite;
    [SerializeField]
    private SoftMask.BorderMode _spriteBorderMode;
    [SerializeField]
    private Texture2D _texture;
    [SerializeField]
    private Rect _textureUVRect = SoftMask.DefaultUVRect;
    [SerializeField]
    private Color _channelWeights = MaskChannel.alpha;
    [SerializeField]
    private float _raycastThreshold;
    private MaterialReplacements _materials;
    private SoftMask.MaterialParameters _parameters;
    private Sprite _lastUsedSprite;
    private Rect _lastMaskRect;
    private bool _maskingWasEnabled;
    private bool _destroyed;
    private bool _dirty;
    private RectTransform _maskTransform;
    private Graphic _graphic;
    private Canvas _canvas;
    private static readonly Rect DefaultUVRect = new Rect(0.0f, 0.0f, 1f, 1f);
    private static readonly List<SoftMask> s_masks = new List<SoftMask>();
    private static readonly List<SoftMaskable> s_maskables = new List<SoftMaskable>();

    public SoftMask() => this._materials = new MaterialReplacements((IMaterialReplacer) new MaterialReplacerChain(MaterialReplacer.globalReplacers, (IMaterialReplacer) new SoftMask.MaterialReplacerImpl(this)), (Action<Material>) (m => this._parameters.Apply(m)));

    public Shader defaultShader
    {
      get => this._defaultShader;
      set => this.SetShader(ref this._defaultShader, value);
    }

    public Shader defaultETC1Shader
    {
      get => this._defaultETC1Shader;
      set => this.SetShader(ref this._defaultETC1Shader, value, false);
    }

    public SoftMask.MaskSource source
    {
      get => this._source;
      set
      {
        if (this._source == value)
          return;
        this.Set<SoftMask.MaskSource>(ref this._source, value);
      }
    }

    public RectTransform separateMask
    {
      get => this._separateMask;
      set
      {
        if (!((UnityEngine.Object) this._separateMask != (UnityEngine.Object) value))
          return;
        this.Set<RectTransform>(ref this._separateMask, value);
        this._graphic = (Graphic) null;
        this._maskTransform = (RectTransform) null;
      }
    }

    public Sprite sprite
    {
      get => this._sprite;
      set
      {
        if (!((UnityEngine.Object) this._sprite != (UnityEngine.Object) value))
          return;
        this.Set<Sprite>(ref this._sprite, value);
      }
    }

    public SoftMask.BorderMode spriteBorderMode
    {
      get => this._spriteBorderMode;
      set
      {
        if (this._spriteBorderMode == value)
          return;
        this.Set<SoftMask.BorderMode>(ref this._spriteBorderMode, value);
      }
    }

    public Texture2D texture
    {
      get => this._texture;
      set
      {
        if (!((UnityEngine.Object) this._texture != (UnityEngine.Object) value))
          return;
        this.Set<Texture2D>(ref this._texture, value);
      }
    }

    public Rect textureUVRect
    {
      get => this._textureUVRect;
      set
      {
        if (!(this._textureUVRect != value))
          return;
        this.Set<Rect>(ref this._textureUVRect, value);
      }
    }

    public Color channelWeights
    {
      get => this._channelWeights;
      set
      {
        if (!(this._channelWeights != value))
          return;
        this.Set<Color>(ref this._channelWeights, value);
      }
    }

    public float raycastThreshold
    {
      get => this._raycastThreshold;
      set => this._raycastThreshold = value;
    }

    public bool isUsingRaycastFiltering => (double) this._raycastThreshold > 0.0;

    public bool isMaskingEnabled => this.isActiveAndEnabled && (bool) (UnityEngine.Object) this.canvas;

    public SoftMask.Errors PollErrors() => new SoftMask.Diagnostics(this).PollErrors();

    public bool IsRaycastLocationValid(Vector2 sp, Camera cam)
    {
      Vector2 localPoint;
      if (!RectTransformUtility.ScreenPointToLocalPointInRectangle(this.maskTransform, sp, cam, out localPoint) || !SoftMask.Mathr.Inside(localPoint, this.LocalMaskRect(Vector4.zero)))
        return false;
      if (!(bool) (UnityEngine.Object) this._parameters.texture || !this.isUsingRaycastFiltering)
        return true;
      float mask;
      if (this._parameters.SampleMask(localPoint, out mask))
        return (double) mask >= (double) this._raycastThreshold;
      Debug.LogErrorFormat((UnityEngine.Object) this, "Raycast Threshold greater than 0 can't be used on Soft Mask with texture '{0}' because it's not readable. You can make the texture readable in the Texture Import Settings.", (object) this._parameters.activeTexture.name);
      return true;
    }

    protected override void Start()
    {
      base.Start();
      this.WarnIfDefaultShaderIsNotSet();
    }

    protected override void OnEnable()
    {
      base.OnEnable();
      this.SubscribeOnWillRenderCanvases();
      this.SpawnMaskablesInChildren(this.transform);
      this.FindGraphic();
      if (this.isMaskingEnabled)
        this.UpdateMaskParameters();
      this.NotifyChildrenThatMaskMightChanged();
    }

    protected override void OnDisable()
    {
      base.OnDisable();
      this.UnsubscribeFromWillRenderCanvases();
      if ((bool) (UnityEngine.Object) this._graphic)
      {
        this._graphic.UnregisterDirtyVerticesCallback(new UnityAction(this.OnGraphicDirty));
        this._graphic.UnregisterDirtyMaterialCallback(new UnityAction(this.OnGraphicDirty));
        this._graphic = (Graphic) null;
      }
      this.NotifyChildrenThatMaskMightChanged();
      this.DestroyMaterials();
    }

    protected override void OnDestroy()
    {
      base.OnDestroy();
      this._destroyed = true;
      this.NotifyChildrenThatMaskMightChanged();
    }

    protected virtual void LateUpdate()
    {
      bool isMaskingEnabled = this.isMaskingEnabled;
      if (isMaskingEnabled)
      {
        if (this._maskingWasEnabled != isMaskingEnabled)
          this.SpawnMaskablesInChildren(this.transform);
        Graphic graphic = this._graphic;
        this.FindGraphic();
        if (this._lastMaskRect != this.maskTransform.rect || this._graphic != graphic)
          this._dirty = true;
      }
      this._maskingWasEnabled = isMaskingEnabled;
    }

    protected override void OnRectTransformDimensionsChange()
    {
      base.OnRectTransformDimensionsChange();
      this._dirty = true;
    }

    protected override void OnDidApplyAnimationProperties()
    {
      base.OnDidApplyAnimationProperties();
      this._dirty = true;
    }

    protected override void OnTransformParentChanged()
    {
      base.OnTransformParentChanged();
      this._canvas = (Canvas) null;
      this._dirty = true;
    }

    protected override void OnCanvasHierarchyChanged()
    {
      base.OnCanvasHierarchyChanged();
      this._canvas = (Canvas) null;
      this._dirty = true;
      this.NotifyChildrenThatMaskMightChanged();
    }

    private void OnTransformChildrenChanged() => this.SpawnMaskablesInChildren(this.transform);

    private void SubscribeOnWillRenderCanvases()
    {
      SoftMask.Touch<CanvasUpdateRegistry>(CanvasUpdateRegistry.instance);
      Canvas.willRenderCanvases += new Canvas.WillRenderCanvases(this.OnWillRenderCanvases);
    }

    private void UnsubscribeFromWillRenderCanvases() => Canvas.willRenderCanvases -= new Canvas.WillRenderCanvases(this.OnWillRenderCanvases);

    private void OnWillRenderCanvases()
    {
      if (!this.isMaskingEnabled)
        return;
      this.UpdateMaskParameters();
    }

    private static T Touch<T>(T obj) => obj;

    private RectTransform maskTransform => !(bool) (UnityEngine.Object) this._maskTransform ? (this._maskTransform = (bool) (UnityEngine.Object) this._separateMask ? this._separateMask : this.GetComponent<RectTransform>()) : this._maskTransform;

    private Canvas canvas => !(bool) (UnityEngine.Object) this._canvas ? (this._canvas = this.NearestEnabledCanvas()) : this._canvas;

    private bool isBasedOnGraphic => this._source == SoftMask.MaskSource.Graphic;

    bool ISoftMask.isAlive => (bool) (UnityEngine.Object) this && !this._destroyed;

    Material ISoftMask.GetReplacement(Material original) => this._materials.Get(original);

    void ISoftMask.ReleaseReplacement(Material replacement) => this._materials.Release(replacement);

    void ISoftMask.UpdateTransformChildren(Transform transform) => this.SpawnMaskablesInChildren(transform);

    private void OnGraphicDirty()
    {
      if (!this.isBasedOnGraphic)
        return;
      this._dirty = true;
    }

    private void FindGraphic()
    {
      if ((bool) (UnityEngine.Object) this._graphic || !this.isBasedOnGraphic)
        return;
      this._graphic = this.maskTransform.GetComponent<Graphic>();
      if (!(bool) (UnityEngine.Object) this._graphic)
        return;
      this._graphic.RegisterDirtyVerticesCallback(new UnityAction(this.OnGraphicDirty));
      this._graphic.RegisterDirtyMaterialCallback(new UnityAction(this.OnGraphicDirty));
    }

    private Canvas NearestEnabledCanvas()
    {
      Canvas[] componentsInParent = this.GetComponentsInParent<Canvas>(false);
      for (int index = 0; index < componentsInParent.Length; ++index)
      {
        if (componentsInParent[index].isActiveAndEnabled)
          return componentsInParent[index];
      }
      return (Canvas) null;
    }

    private void UpdateMaskParameters()
    {
      if (this._dirty || this.maskTransform.hasChanged)
      {
        this.CalculateMaskParameters();
        this.maskTransform.hasChanged = false;
        this._lastMaskRect = this.maskTransform.rect;
        this._dirty = false;
      }
      this._materials.ApplyAll();
    }

    private void SpawnMaskablesInChildren(Transform root)
    {
      using (new ClearListAtExit<SoftMaskable>(SoftMask.s_maskables))
      {
        for (int index = 0; index < root.childCount; ++index)
        {
          Transform child = root.GetChild(index);
          child.GetComponents<SoftMaskable>(SoftMask.s_maskables);
          if (SoftMask.s_maskables.Count == 0)
            child.gameObject.AddComponent<SoftMaskable>();
        }
      }
    }

    private void InvalidateChildren() => this.ForEachChildMaskable((Action<SoftMaskable>) (x => x.Invalidate()));

    private void NotifyChildrenThatMaskMightChanged() => this.ForEachChildMaskable((Action<SoftMaskable>) (x => x.MaskMightChanged()));

    private void ForEachChildMaskable(Action<SoftMaskable> f)
    {
      this.transform.GetComponentsInChildren<SoftMaskable>(SoftMask.s_maskables);
      using (new ClearListAtExit<SoftMaskable>(SoftMask.s_maskables))
      {
        for (int index = 0; index < SoftMask.s_maskables.Count; ++index)
        {
          SoftMaskable maskable = SoftMask.s_maskables[index];
          if ((bool) (UnityEngine.Object) maskable && (UnityEngine.Object) maskable.gameObject != (UnityEngine.Object) this.gameObject)
            f(maskable);
        }
      }
    }

    private void DestroyMaterials() => this._materials.DestroyAllAndClear();

    private SoftMask.SourceParameters DeduceSourceParameters()
    {
      SoftMask.SourceParameters sourceParameters = new SoftMask.SourceParameters();
      switch (this._source)
      {
        case SoftMask.MaskSource.Graphic:
          if (this._graphic is Image)
          {
            sourceParameters.image = (Image) this._graphic;
            sourceParameters.sprite = sourceParameters.image.sprite;
            sourceParameters.spriteBorderMode = this.ToBorderMode(sourceParameters.image.type);
            sourceParameters.texture = (bool) (UnityEngine.Object) sourceParameters.sprite ? sourceParameters.sprite.texture : (Texture2D) null;
            break;
          }
          if (this._graphic is RawImage)
          {
            RawImage graphic = (RawImage) this._graphic;
            sourceParameters.texture = graphic.texture as Texture2D;
            sourceParameters.textureUVRect = graphic.uvRect;
            break;
          }
          break;
        case SoftMask.MaskSource.Sprite:
          sourceParameters.sprite = this._sprite;
          sourceParameters.spriteBorderMode = this._spriteBorderMode;
          sourceParameters.texture = (bool) (UnityEngine.Object) sourceParameters.sprite ? sourceParameters.sprite.texture : (Texture2D) null;
          break;
        case SoftMask.MaskSource.Texture:
          sourceParameters.texture = this._texture;
          sourceParameters.textureUVRect = this._textureUVRect;
          break;
        default:
          Debug.LogErrorFormat((UnityEngine.Object) this, "Unknown MaskSource: {0}", (object) this._source);
          break;
      }
      return sourceParameters;
    }

    private SoftMask.BorderMode ToBorderMode(Image.Type imageType)
    {
      switch (imageType)
      {
        case Image.Type.Simple:
          return SoftMask.BorderMode.Simple;
        case Image.Type.Sliced:
          return SoftMask.BorderMode.Sliced;
        case Image.Type.Tiled:
          return SoftMask.BorderMode.Tiled;
        default:
          Debug.LogErrorFormat((UnityEngine.Object) this, "SoftMask doesn't support image type {0}. Image type Simple will be used.", (object) imageType);
          return SoftMask.BorderMode.Simple;
      }
    }

    private void CalculateMaskParameters()
    {
      SoftMask.SourceParameters sourceParameters = this.DeduceSourceParameters();
      if ((bool) (UnityEngine.Object) sourceParameters.sprite)
        this.CalculateSpriteBased(sourceParameters.sprite, sourceParameters.spriteBorderMode);
      else if ((bool) (UnityEngine.Object) sourceParameters.texture)
        this.CalculateTextureBased(sourceParameters.texture, sourceParameters.textureUVRect);
      else
        this.CalculateSolidFill();
    }

    private void CalculateSpriteBased(Sprite sprite, SoftMask.BorderMode borderMode)
    {
      Sprite lastUsedSprite = this._lastUsedSprite;
      this._lastUsedSprite = sprite;
      SoftMask.Errors errors = SoftMask.Diagnostics.CheckSprite(sprite);
      if (errors != SoftMask.Errors.NoError)
      {
        if ((UnityEngine.Object) lastUsedSprite != (UnityEngine.Object) sprite)
          this.WarnSpriteErrors(errors);
        this.CalculateSolidFill();
      }
      else if (!(bool) (UnityEngine.Object) sprite)
      {
        this.CalculateSolidFill();
      }
      else
      {
        this.FillCommonParameters();
        Vector4 vector1 = SoftMask.Mathr.ToVector(sprite.rect);
        Rect rect = sprite.textureRect;
        Vector2 position1 = rect.position;
        rect = sprite.rect;
        Vector2 position2 = rect.position;
        Vector2 o = position1 - position2 - sprite.textureRectOffset;
        Vector4 vector4_1 = SoftMask.Mathr.Move(vector1, o);
        Vector4 vector2 = SoftMask.Mathr.ToVector(sprite.textureRect);
        Vector4 v1 = SoftMask.Mathr.BorderOf(vector4_1, vector2);
        Vector2 s = new Vector2((float) sprite.texture.width, (float) sprite.texture.height);
        Vector4 vector4_2 = this.LocalMaskRect(Vector4.zero);
        this._parameters.maskRectUV = SoftMask.Mathr.Div(vector2, s);
        if (borderMode == SoftMask.BorderMode.Simple)
        {
          Vector4 v2 = SoftMask.Mathr.Div(v1, SoftMask.Mathr.Size(vector4_1));
          this._parameters.maskRect = SoftMask.Mathr.ApplyBorder(vector4_2, SoftMask.Mathr.Mul(v2, SoftMask.Mathr.Size(vector4_2)));
        }
        else
        {
          this._parameters.maskRect = SoftMask.Mathr.ApplyBorder(vector4_2, v1 * this.GraphicToCanvasScale(sprite));
          Vector4 v3 = SoftMask.Mathr.Div(vector4_1, s);
          this._parameters.maskBorder = this.LocalMaskRect(SoftMask.AdjustBorders(sprite.border * this.GraphicToCanvasScale(sprite), vector4_2));
          this._parameters.maskBorderUV = SoftMask.Mathr.ApplyBorder(v3, SoftMask.Mathr.Div(sprite.border, s));
        }
        this._parameters.texture = sprite.texture;
        this._parameters.borderMode = borderMode;
        if (borderMode != SoftMask.BorderMode.Tiled)
          return;
        this._parameters.tileRepeat = this.MaskRepeat(sprite, this._parameters.maskBorder);
      }
    }

    private static Vector4 AdjustBorders(Vector4 border, Vector4 rect)
    {
      Vector2 vector2 = SoftMask.Mathr.Size(rect);
      for (int index = 0; index <= 1; ++index)
      {
        float num1 = border[index] + border[index + 2];
        if ((double) vector2[index] < (double) num1 && (double) num1 != 0.0)
        {
          float num2 = vector2[index] / num1;
          border[index] *= num2;
          border[index + 2] *= num2;
        }
      }
      return border;
    }

    private void CalculateTextureBased(Texture2D texture, Rect uvRect)
    {
      this.FillCommonParameters();
      this._parameters.maskRect = this.LocalMaskRect(Vector4.zero);
      this._parameters.maskRectUV = SoftMask.Mathr.ToVector(uvRect);
      this._parameters.texture = texture;
      this._parameters.borderMode = SoftMask.BorderMode.Simple;
    }

    private void CalculateSolidFill() => this.CalculateTextureBased((Texture2D) null, SoftMask.DefaultUVRect);

    private void FillCommonParameters()
    {
      this._parameters.worldToMask = this.WorldToMask();
      this._parameters.maskChannelWeights = this._channelWeights;
    }

    private float GraphicToCanvasScale(Sprite sprite) => (float) (((bool) (UnityEngine.Object) this.canvas ? (double) this.canvas.referencePixelsPerUnit : 100.0) / ((bool) (UnityEngine.Object) sprite ? (double) sprite.pixelsPerUnit : 100.0));

    private Matrix4x4 WorldToMask() => this.maskTransform.worldToLocalMatrix * this.canvas.rootCanvas.transform.localToWorldMatrix;

    private Vector4 LocalMaskRect(Vector4 border) => SoftMask.Mathr.ApplyBorder(SoftMask.Mathr.ToVector(this.maskTransform.rect), border);

    private Vector2 MaskRepeat(Sprite sprite, Vector4 centralPart)
    {
      Vector4 r = SoftMask.Mathr.ApplyBorder(SoftMask.Mathr.ToVector(sprite.textureRect), sprite.border);
      return SoftMask.Mathr.Div(SoftMask.Mathr.Size(centralPart) * this.GraphicToCanvasScale(sprite), SoftMask.Mathr.Size(r));
    }

    private void WarnIfDefaultShaderIsNotSet()
    {
      if ((bool) (UnityEngine.Object) this._defaultShader)
        return;
      Debug.LogWarning((object) "SoftMask may not work because its defaultShader is not set", (UnityEngine.Object) this);
    }

    private void WarnSpriteErrors(SoftMask.Errors errors)
    {
      if ((errors & SoftMask.Errors.TightPackedSprite) != SoftMask.Errors.NoError)
        Debug.LogError((object) "SoftMask doesn't support tight packed sprites", (UnityEngine.Object) this);
      if ((errors & SoftMask.Errors.AlphaSplitSprite) == SoftMask.Errors.NoError)
        return;
      Debug.LogError((object) "SoftMask doesn't support sprites with an alpha split texture", (UnityEngine.Object) this);
    }

    private void Set<T>(ref T field, T value)
    {
      field = value;
      this._dirty = true;
    }

    private void SetShader(ref Shader field, Shader value, bool warnIfNotSet = true)
    {
      if (!((UnityEngine.Object) field != (UnityEngine.Object) value))
        return;
      field = value;
      if (warnIfNotSet)
        this.WarnIfDefaultShaderIsNotSet();
      this.DestroyMaterials();
      this.InvalidateChildren();
    }

    [Serializable]
    public enum MaskSource
    {
      Graphic,
      Sprite,
      Texture,
    }

    [Serializable]
    public enum BorderMode
    {
      Simple,
      Sliced,
      Tiled,
    }

    [System.Flags]
    [Serializable]
    public enum Errors
    {
      NoError = 0,
      UnsupportedShaders = 1,
      NestedMasks = 2,
      TightPackedSprite = 4,
      AlphaSplitSprite = 8,
      UnsupportedImageType = 16, // 0x00000010
      UnreadableTexture = 32, // 0x00000020
    }

    private struct SourceParameters
    {
      public Image image;
      public Sprite sprite;
      public SoftMask.BorderMode spriteBorderMode;
      public Texture2D texture;
      public Rect textureUVRect;
    }

    private class MaterialReplacerImpl : IMaterialReplacer
    {
      private readonly SoftMask _owner;

      public MaterialReplacerImpl(SoftMask owner) => this._owner = owner;

      public int order => 0;

      public Material Replace(Material original)
      {
        if ((UnityEngine.Object) original == (UnityEngine.Object) null || original.HasDefaultUIShader())
          return SoftMask.MaterialReplacerImpl.Replace(original, this._owner._defaultShader);
        if (original.HasDefaultETC1UIShader())
          return SoftMask.MaterialReplacerImpl.Replace(original, this._owner._defaultETC1Shader);
        return original.SupportsSoftMask() ? new Material(original) : (Material) null;
      }

      private static Material Replace(Material original, Shader defaultReplacementShader)
      {
        Material material = (bool) (UnityEngine.Object) defaultReplacementShader ? new Material(defaultReplacementShader) : (Material) null;
        if ((bool) (UnityEngine.Object) material && (bool) (UnityEngine.Object) original)
          material.CopyPropertiesFromMaterial(original);
        return material;
      }
    }

    private static class Mathr
    {
      public static Vector4 ToVector(Rect r) => new Vector4(r.xMin, r.yMin, r.xMax, r.yMax);

      public static Vector4 Div(Vector4 v, Vector2 s) => new Vector4(v.x / s.x, v.y / s.y, v.z / s.x, v.w / s.y);

      public static Vector2 Div(Vector2 v, Vector2 s) => new Vector2(v.x / s.x, v.y / s.y);

      public static Vector4 Mul(Vector4 v, Vector2 s) => new Vector4(v.x * s.x, v.y * s.y, v.z * s.x, v.w * s.y);

      public static Vector2 Size(Vector4 r) => new Vector2(r.z - r.x, r.w - r.y);

      public static Vector4 Move(Vector4 v, Vector2 o) => new Vector4(v.x + o.x, v.y + o.y, v.z + o.x, v.w + o.y);

      public static Vector4 BorderOf(Vector4 outer, Vector4 inner) => new Vector4(inner.x - outer.x, inner.y - outer.y, outer.z - inner.z, outer.w - inner.w);

      public static Vector4 ApplyBorder(Vector4 v, Vector4 b) => new Vector4(v.x + b.x, v.y + b.y, v.z - b.z, v.w - b.w);

      public static Vector2 Min(Vector4 r) => new Vector2(r.x, r.y);

      public static Vector2 Max(Vector4 r) => new Vector2(r.z, r.w);

      public static Vector2 Remap(Vector2 c, Vector4 from, Vector4 to)
      {
        Vector2 s = SoftMask.Mathr.Max(from) - SoftMask.Mathr.Min(from);
        Vector2 b = SoftMask.Mathr.Max(to) - SoftMask.Mathr.Min(to);
        return Vector2.Scale(SoftMask.Mathr.Div(c - SoftMask.Mathr.Min(from), s), b) + SoftMask.Mathr.Min(to);
      }

      public static bool Inside(Vector2 v, Vector4 r) => (double) v.x >= (double) r.x && (double) v.y >= (double) r.y && (double) v.x <= (double) r.z && (double) v.y <= (double) r.w;
    }

    private struct MaterialParameters
    {
      public Vector4 maskRect;
      public Vector4 maskBorder;
      public Vector4 maskRectUV;
      public Vector4 maskBorderUV;
      public Vector2 tileRepeat;
      public Color maskChannelWeights;
      public Matrix4x4 worldToMask;
      public Texture2D texture;
      public SoftMask.BorderMode borderMode;

      public Texture2D activeTexture => !(bool) (UnityEngine.Object) this.texture ? Texture2D.whiteTexture : this.texture;

      public bool SampleMask(Vector2 localPos, out float mask)
      {
        Vector2 vector2 = this.XY2UV(localPos);
        try
        {
          mask = this.MaskValue(this.texture.GetPixelBilinear(vector2.x, vector2.y));
          return true;
        }
        catch (UnityException ex)
        {
          mask = 0.0f;
          return false;
        }
      }

      public void Apply(Material mat)
      {
        mat.SetTexture(SoftMask.MaterialParameters.Ids.SoftMask, (Texture) this.activeTexture);
        mat.SetVector(SoftMask.MaterialParameters.Ids.SoftMask_Rect, this.maskRect);
        mat.SetVector(SoftMask.MaterialParameters.Ids.SoftMask_UVRect, this.maskRectUV);
        mat.SetColor(SoftMask.MaterialParameters.Ids.SoftMask_ChannelWeights, this.maskChannelWeights);
        mat.SetMatrix(SoftMask.MaterialParameters.Ids.SoftMask_WorldToMask, this.worldToMask);
        mat.EnableKeyword("SOFTMASK_SIMPLE", this.borderMode == SoftMask.BorderMode.Simple);
        mat.EnableKeyword("SOFTMASK_SLICED", this.borderMode == SoftMask.BorderMode.Sliced);
        mat.EnableKeyword("SOFTMASK_TILED", this.borderMode == SoftMask.BorderMode.Tiled);
        if (this.borderMode == SoftMask.BorderMode.Simple)
          return;
        mat.SetVector(SoftMask.MaterialParameters.Ids.SoftMask_BorderRect, this.maskBorder);
        mat.SetVector(SoftMask.MaterialParameters.Ids.SoftMask_UVBorderRect, this.maskBorderUV);
        if (this.borderMode != SoftMask.BorderMode.Tiled)
          return;
        mat.SetVector(SoftMask.MaterialParameters.Ids.SoftMask_TileRepeat, (Vector4) this.tileRepeat);
      }

      private Vector2 XY2UV(Vector2 localPos)
      {
        switch (this.borderMode)
        {
          case SoftMask.BorderMode.Simple:
            return this.MapSimple(localPos);
          case SoftMask.BorderMode.Sliced:
            return this.MapBorder(localPos, false);
          case SoftMask.BorderMode.Tiled:
            return this.MapBorder(localPos, true);
          default:
            Debug.LogError((object) "Unknown BorderMode");
            return this.MapSimple(localPos);
        }
      }

      private Vector2 MapSimple(Vector2 localPos) => SoftMask.Mathr.Remap(localPos, this.maskRect, this.maskRectUV);

      private Vector2 MapBorder(Vector2 localPos, bool repeat) => new Vector2(this.Inset(localPos.x, this.maskRect.x, this.maskBorder.x, this.maskBorder.z, this.maskRect.z, this.maskRectUV.x, this.maskBorderUV.x, this.maskBorderUV.z, this.maskRectUV.z, repeat ? this.tileRepeat.x : 1f), this.Inset(localPos.y, this.maskRect.y, this.maskBorder.y, this.maskBorder.w, this.maskRect.w, this.maskRectUV.y, this.maskBorderUV.y, this.maskBorderUV.w, this.maskRectUV.w, repeat ? this.tileRepeat.y : 1f));

      private float Inset(float v, float x1, float x2, float u1, float u2, float repeat = 1f)
      {
        float num = x2 - x1;
        return Mathf.Lerp(u1, u2, (double) num != 0.0 ? this.Frac((v - x1) / num * repeat) : 0.0f);
      }

      private float Inset(
        float v,
        float x1,
        float x2,
        float x3,
        float x4,
        float u1,
        float u2,
        float u3,
        float u4,
        float repeat = 1f)
      {
        if ((double) v < (double) x2)
          return this.Inset(v, x1, x2, u1, u2);
        return (double) v < (double) x3 ? this.Inset(v, x2, x3, u2, u3, repeat) : this.Inset(v, x3, x4, u3, u4);
      }

      private float Frac(float v) => v - Mathf.Floor(v);

      private float MaskValue(Color mask)
      {
        Color color = mask * this.maskChannelWeights;
        return color.a + color.r + color.g + color.b;
      }

      private static class Ids
      {
        public static readonly int SoftMask = Shader.PropertyToID("_SoftMask");
        public static readonly int SoftMask_Rect = Shader.PropertyToID("_SoftMask_Rect");
        public static readonly int SoftMask_UVRect = Shader.PropertyToID("_SoftMask_UVRect");
        public static readonly int SoftMask_ChannelWeights = Shader.PropertyToID("_SoftMask_ChannelWeights");
        public static readonly int SoftMask_WorldToMask = Shader.PropertyToID("_SoftMask_WorldToMask");
        public static readonly int SoftMask_BorderRect = Shader.PropertyToID("_SoftMask_BorderRect");
        public static readonly int SoftMask_UVBorderRect = Shader.PropertyToID("_SoftMask_UVBorderRect");
        public static readonly int SoftMask_TileRepeat = Shader.PropertyToID("_SoftMask_TileRepeat");
      }
    }

    private struct Diagnostics
    {
      private SoftMask _softMask;

      public Diagnostics(SoftMask softMask) => this._softMask = softMask;

      public SoftMask.Errors PollErrors()
      {
        SoftMask softMask = this._softMask;
        SoftMask.Errors errors = SoftMask.Errors.NoError;
        softMask.GetComponentsInChildren<SoftMaskable>(SoftMask.s_maskables);
        using (new ClearListAtExit<SoftMaskable>(SoftMask.s_maskables))
        {
          if (SoftMask.s_maskables.Any<SoftMaskable>((Func<SoftMaskable, bool>) (m => m.mask == softMask && m.shaderIsNotSupported)))
            errors |= SoftMask.Errors.UnsupportedShaders;
        }
        if (this.ThereAreNestedMasks())
          errors |= SoftMask.Errors.NestedMasks;
        return errors | SoftMask.Diagnostics.CheckSprite(this.sprite) | this.CheckImage() | this.CheckTexture();
      }

      public static SoftMask.Errors CheckSprite(Sprite sprite)
      {
        SoftMask.Errors errors = SoftMask.Errors.NoError;
        if (!(bool) (UnityEngine.Object) sprite)
          return errors;
        if (sprite.packed && sprite.packingMode == SpritePackingMode.Tight)
          errors |= SoftMask.Errors.TightPackedSprite;
        if ((bool) (UnityEngine.Object) sprite.associatedAlphaSplitTexture)
          errors |= SoftMask.Errors.AlphaSplitSprite;
        return errors;
      }

      private Image image => this._softMask.DeduceSourceParameters().image;

      private Sprite sprite => this._softMask.DeduceSourceParameters().sprite;

      private Texture2D texture => this._softMask.DeduceSourceParameters().texture;

      private bool ThereAreNestedMasks()
      {
        SoftMask softMask = this._softMask;
        bool flag1 = false;
        using (new ClearListAtExit<SoftMask>(SoftMask.s_masks))
        {
          softMask.GetComponentsInParent<SoftMask>(false, SoftMask.s_masks);
          bool flag2 = flag1 | SoftMask.s_masks.Any<SoftMask>((Func<SoftMask, bool>) (x => SoftMask.Diagnostics.AreCompeting(softMask, x)));
          softMask.GetComponentsInChildren<SoftMask>(false, SoftMask.s_masks);
          return flag2 | SoftMask.s_masks.Any<SoftMask>((Func<SoftMask, bool>) (x => SoftMask.Diagnostics.AreCompeting(softMask, x)));
        }
      }

      private SoftMask.Errors CheckImage()
      {
        SoftMask.Errors errors = SoftMask.Errors.NoError;
        if (!this._softMask.isBasedOnGraphic || !(bool) (UnityEngine.Object) this.image || SoftMask.Diagnostics.IsSupportedImageType(this.image.type))
          return errors;
        errors |= SoftMask.Errors.UnsupportedImageType;
        return errors;
      }

      private SoftMask.Errors CheckTexture()
      {
        SoftMask.Errors errors = SoftMask.Errors.NoError;
        if (this._softMask.isUsingRaycastFiltering && (bool) (UnityEngine.Object) this.texture && !SoftMask.Diagnostics.IsReadable(this.texture))
          errors |= SoftMask.Errors.UnreadableTexture;
        return errors;
      }

      private static bool AreCompeting(SoftMask softMask, SoftMask other) => softMask.isMaskingEnabled && (UnityEngine.Object) softMask != (UnityEngine.Object) other && other.isMaskingEnabled && (UnityEngine.Object) softMask.canvas.rootCanvas == (UnityEngine.Object) other.canvas.rootCanvas && !SoftMask.Diagnostics.SelectChild<SoftMask>(softMask, other).canvas.overrideSorting;

      private static T SelectChild<T>(T first, T second) where T : Component => !first.transform.IsChildOf(second.transform) ? second : first;

      private static bool IsReadable(Texture2D texture)
      {
        try
        {
          texture.GetPixel(0, 0);
          return true;
        }
        catch (UnityException ex)
        {
          return false;
        }
      }

      private static bool IsSupportedImageType(Image.Type type) => type == Image.Type.Simple || type == Image.Type.Sliced || type == Image.Type.Tiled;
    }
  }
}
