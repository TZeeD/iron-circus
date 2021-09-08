// Decompiled with JetBrains decompiler
// Type: Coffee.UIExtensions.UIEffectCapturedImage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Collections;
using System.Diagnostics;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace Coffee.UIExtensions
{
  [AddComponentMenu("UI/UIEffect/UIEffectCapturedImage", 200)]
  public class UIEffectCapturedImage : RawImage
  {
    public const string shaderName = "UI/Hidden/UI-EffectCapture";
    [Tooltip("Effect factor between 0(no effect) and 1(complete effect).")]
    [FormerlySerializedAs("m_ToneLevel")]
    [SerializeField]
    [Range(0.0f, 1f)]
    private float m_EffectFactor = 1f;
    [Tooltip("Color effect factor between 0(no effect) and 1(complete effect).")]
    [SerializeField]
    [Range(0.0f, 1f)]
    private float m_ColorFactor = 1f;
    [Tooltip("How far is the blurring from the graphic.")]
    [FormerlySerializedAs("m_Blur")]
    [SerializeField]
    [Range(0.0f, 1f)]
    private float m_BlurFactor = 1f;
    [Tooltip("Effect mode.")]
    [FormerlySerializedAs("m_ToneMode")]
    [SerializeField]
    private EffectMode m_EffectMode;
    [Tooltip("Color effect mode.")]
    [SerializeField]
    private ColorMode m_ColorMode;
    [Tooltip("Blur effect mode.")]
    [SerializeField]
    private BlurMode m_BlurMode = BlurMode.DetailBlur;
    [Tooltip("Color for the color effect.")]
    [SerializeField]
    private Color m_EffectColor = Color.white;
    [Tooltip("Desampling rate of the generated RenderTexture.")]
    [SerializeField]
    private UIEffectCapturedImage.DesamplingRate m_DesamplingRate = UIEffectCapturedImage.DesamplingRate.x1;
    [Tooltip("Desampling rate of reduction buffer to apply effect.")]
    [SerializeField]
    private UIEffectCapturedImage.DesamplingRate m_ReductionRate = UIEffectCapturedImage.DesamplingRate.x1;
    [Tooltip("FilterMode for capturing.")]
    [SerializeField]
    private FilterMode m_FilterMode = FilterMode.Bilinear;
    [Tooltip("Effect material.")]
    [SerializeField]
    private Material m_EffectMaterial;
    [Tooltip("Blur iterations.")]
    [FormerlySerializedAs("m_Iterations")]
    [SerializeField]
    [Range(1f, 8f)]
    private int m_BlurIterations = 3;
    [Tooltip("Fits graphic size to screen on captured.")]
    [FormerlySerializedAs("m_KeepCanvasSize")]
    [SerializeField]
    private bool m_FitToScreen = true;
    [Tooltip("Capture automatically on enable.")]
    [SerializeField]
    private bool m_CaptureOnEnable;
    [Tooltip("Capture immediately.")]
    [SerializeField]
    private bool m_ImmediateCapturing = true;
    private RenderTexture _rt;
    private RenderTargetIdentifier _rtId;
    private static int s_CopyId;
    private static int s_EffectId1;
    private static int s_EffectId2;
    private static int s_EffectFactorId;
    private static int s_ColorFactorId;
    private static CommandBuffer s_CommandBuffer;

    [Obsolete("Use effectFactor instead (UnityUpgradable) -> effectFactor")]
    public float toneLevel
    {
      get => this.m_EffectFactor;
      set => this.m_EffectFactor = Mathf.Clamp(value, 0.0f, 1f);
    }

    public float effectFactor
    {
      get => this.m_EffectFactor;
      set => this.m_EffectFactor = Mathf.Clamp(value, 0.0f, 1f);
    }

    public float colorFactor
    {
      get => this.m_ColorFactor;
      set => this.m_ColorFactor = Mathf.Clamp(value, 0.0f, 1f);
    }

    [Obsolete("Use blurFactor instead (UnityUpgradable) -> blurFactor")]
    public float blur
    {
      get => this.m_BlurFactor;
      set => this.m_BlurFactor = Mathf.Clamp(value, 0.0f, 4f);
    }

    public float blurFactor
    {
      get => this.m_BlurFactor;
      set => this.m_BlurFactor = Mathf.Clamp(value, 0.0f, 4f);
    }

    [Obsolete("Use effectMode instead (UnityUpgradable) -> effectMode")]
    public EffectMode toneMode => this.m_EffectMode;

    public EffectMode effectMode => this.m_EffectMode;

    public ColorMode colorMode => this.m_ColorMode;

    public BlurMode blurMode => this.m_BlurMode;

    public Color effectColor
    {
      get => this.m_EffectColor;
      set => this.m_EffectColor = value;
    }

    public virtual Material effectMaterial => this.m_EffectMaterial;

    public UIEffectCapturedImage.DesamplingRate desamplingRate
    {
      get => this.m_DesamplingRate;
      set => this.m_DesamplingRate = value;
    }

    public UIEffectCapturedImage.DesamplingRate reductionRate
    {
      get => this.m_ReductionRate;
      set => this.m_ReductionRate = value;
    }

    public FilterMode filterMode
    {
      get => this.m_FilterMode;
      set => this.m_FilterMode = value;
    }

    public RenderTexture capturedTexture => this._rt;

    [Obsolete("Use blurIterations instead (UnityUpgradable) -> blurIterations")]
    public int iterations
    {
      get => this.m_BlurIterations;
      set => this.m_BlurIterations = value;
    }

    public int blurIterations
    {
      get => this.m_BlurIterations;
      set => this.m_BlurIterations = value;
    }

    [Obsolete("Use fitToScreen instead (UnityUpgradable) -> fitToScreen")]
    public bool keepCanvasSize
    {
      get => this.m_FitToScreen;
      set => this.m_FitToScreen = value;
    }

    public bool fitToScreen
    {
      get => this.m_FitToScreen;
      set => this.m_FitToScreen = value;
    }

    [Obsolete]
    public RenderTexture targetTexture
    {
      get => (RenderTexture) null;
      set
      {
      }
    }

    public bool captureOnEnable
    {
      get => this.m_CaptureOnEnable;
      set => this.m_CaptureOnEnable = value;
    }

    public bool immediateCapturing
    {
      get => this.m_ImmediateCapturing;
      set => this.m_ImmediateCapturing = value;
    }

    protected override void OnEnable()
    {
      base.OnEnable();
      if (!this.m_CaptureOnEnable || !Application.isPlaying)
        return;
      this.Capture();
    }

    protected override void OnDisable()
    {
      base.OnDisable();
      if (!this.m_CaptureOnEnable || !Application.isPlaying)
        return;
      this._Release(false);
      this.texture = (Texture) null;
    }

    protected override void OnDestroy()
    {
      this.Release();
      base.OnDestroy();
    }

    protected override void OnPopulateMesh(VertexHelper vh)
    {
      if ((UnityEngine.Object) this.texture == (UnityEngine.Object) null || (double) this.color.a < 0.00392156885936856 || (double) this.canvasRenderer.GetAlpha() < 0.00392156885936856)
      {
        vh.Clear();
      }
      else
      {
        base.OnPopulateMesh(vh);
        int currentVertCount = vh.currentVertCount;
        UIVertex vertex = new UIVertex();
        Color color = this.color;
        for (int i = 0; i < currentVertCount; ++i)
        {
          vh.PopulateUIVertex(ref vertex, i);
          vertex.color = (Color32) color;
          vh.SetUIVertex(vertex, i);
        }
      }
    }

    public void GetDesamplingSize(UIEffectCapturedImage.DesamplingRate rate, out int w, out int h)
    {
      w = Screen.width;
      h = Screen.height;
      if (rate == UIEffectCapturedImage.DesamplingRate.None)
        return;
      float num = (float) w / (float) h;
      if (w < h)
      {
        h = Mathf.ClosestPowerOfTwo(h / (int) rate);
        w = Mathf.CeilToInt((float) h * num);
      }
      else
      {
        w = Mathf.ClosestPowerOfTwo(w / (int) rate);
        h = Mathf.CeilToInt((float) w / num);
      }
    }

    public void Capture()
    {
      Canvas rootCanvas = this.canvas.rootCanvas;
      if (this.m_FitToScreen)
      {
        RectTransform transform = rootCanvas.transform as RectTransform;
        Vector2 size = transform.rect.size;
        this.rectTransform.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, size.x);
        this.rectTransform.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, size.y);
        this.rectTransform.position = transform.position;
      }
      if (UIEffectCapturedImage.s_CopyId == 0)
      {
        UIEffectCapturedImage.s_CopyId = Shader.PropertyToID("_UIEffectCapturedImage_ScreenCopyId");
        UIEffectCapturedImage.s_EffectId1 = Shader.PropertyToID("_UIEffectCapturedImage_EffectId1");
        UIEffectCapturedImage.s_EffectId2 = Shader.PropertyToID("_UIEffectCapturedImage_EffectId2");
        UIEffectCapturedImage.s_EffectFactorId = Shader.PropertyToID("_EffectFactor");
        UIEffectCapturedImage.s_ColorFactorId = Shader.PropertyToID("_ColorFactor");
        UIEffectCapturedImage.s_CommandBuffer = new CommandBuffer();
      }
      int w;
      int h;
      this.GetDesamplingSize(this.m_DesamplingRate, out w, out h);
      if ((bool) (UnityEngine.Object) this._rt && (this._rt.width != w || this._rt.height != h))
        this._Release(ref this._rt);
      if ((UnityEngine.Object) this._rt == (UnityEngine.Object) null)
      {
        this._rt = RenderTexture.GetTemporary(w, h, 0, RenderTextureFormat.ARGB32, RenderTextureReadWrite.Default);
        this._rt.filterMode = this.m_FilterMode;
        this._rt.useMipMap = false;
        this._rt.wrapMode = TextureWrapMode.Clamp;
        this._rtId = new RenderTargetIdentifier((Texture) this._rt);
      }
      this.SetupCommandBuffer();
    }

    private void SetupCommandBuffer()
    {
      Material effectMaterial = this.m_EffectMaterial;
      if (UIEffectCapturedImage.s_CommandBuffer == null)
        UIEffectCapturedImage.s_CommandBuffer = new CommandBuffer();
      int w;
      int h;
      this.GetDesamplingSize(UIEffectCapturedImage.DesamplingRate.None, out w, out h);
      UIEffectCapturedImage.s_CommandBuffer.GetTemporaryRT(UIEffectCapturedImage.s_CopyId, w, h, 0, this.m_FilterMode);
      UIEffectCapturedImage.s_CommandBuffer.Blit((RenderTargetIdentifier) BuiltinRenderTextureType.BindableTexture, (RenderTargetIdentifier) UIEffectCapturedImage.s_CopyId);
      UIEffectCapturedImage.s_CommandBuffer.SetGlobalVector(UIEffectCapturedImage.s_EffectFactorId, new Vector4(this.m_EffectFactor, 0.0f));
      UIEffectCapturedImage.s_CommandBuffer.SetGlobalVector(UIEffectCapturedImage.s_ColorFactorId, new Vector4(this.m_EffectColor.r, this.m_EffectColor.g, this.m_EffectColor.b, this.m_EffectColor.a));
      this.GetDesamplingSize(this.m_ReductionRate, out w, out h);
      UIEffectCapturedImage.s_CommandBuffer.GetTemporaryRT(UIEffectCapturedImage.s_EffectId1, w, h, 0, this.m_FilterMode);
      UIEffectCapturedImage.s_CommandBuffer.Blit((RenderTargetIdentifier) UIEffectCapturedImage.s_CopyId, (RenderTargetIdentifier) UIEffectCapturedImage.s_EffectId1, effectMaterial, 0);
      UIEffectCapturedImage.s_CommandBuffer.ReleaseTemporaryRT(UIEffectCapturedImage.s_CopyId);
      if (this.m_BlurMode != BlurMode.None)
      {
        UIEffectCapturedImage.s_CommandBuffer.GetTemporaryRT(UIEffectCapturedImage.s_EffectId2, w, h, 0, this.m_FilterMode);
        for (int index = 0; index < this.m_BlurIterations; ++index)
        {
          UIEffectCapturedImage.s_CommandBuffer.SetGlobalVector(UIEffectCapturedImage.s_EffectFactorId, new Vector4(this.m_BlurFactor, 0.0f));
          UIEffectCapturedImage.s_CommandBuffer.Blit((RenderTargetIdentifier) UIEffectCapturedImage.s_EffectId1, (RenderTargetIdentifier) UIEffectCapturedImage.s_EffectId2, effectMaterial, 1);
          UIEffectCapturedImage.s_CommandBuffer.SetGlobalVector(UIEffectCapturedImage.s_EffectFactorId, new Vector4(0.0f, this.m_BlurFactor));
          UIEffectCapturedImage.s_CommandBuffer.Blit((RenderTargetIdentifier) UIEffectCapturedImage.s_EffectId2, (RenderTargetIdentifier) UIEffectCapturedImage.s_EffectId1, effectMaterial, 1);
        }
        UIEffectCapturedImage.s_CommandBuffer.ReleaseTemporaryRT(UIEffectCapturedImage.s_EffectId2);
      }
      UIEffectCapturedImage.s_CommandBuffer.Blit((RenderTargetIdentifier) UIEffectCapturedImage.s_EffectId1, this._rtId);
      UIEffectCapturedImage.s_CommandBuffer.ReleaseTemporaryRT(UIEffectCapturedImage.s_EffectId1);
      if (this.m_ImmediateCapturing)
        this.UpdateTexture();
      else
        this.canvas.rootCanvas.GetComponent<CanvasScaler>().StartCoroutine(this._CoUpdateTextureOnNextFrame());
    }

    public void Release()
    {
      this._Release(true);
      this.texture = (Texture) null;
    }

    private void _Release(bool releaseRT)
    {
      if (releaseRT)
      {
        this.texture = (Texture) null;
        this._Release(ref this._rt);
      }
      if (UIEffectCapturedImage.s_CommandBuffer == null)
        return;
      UIEffectCapturedImage.s_CommandBuffer.Clear();
      if (!releaseRT)
        return;
      UIEffectCapturedImage.s_CommandBuffer.Release();
      UIEffectCapturedImage.s_CommandBuffer = (CommandBuffer) null;
    }

    [Conditional("UNITY_EDITOR")]
    private void _SetDirty()
    {
    }

    private void _Release(ref RenderTexture obj)
    {
      if (!(bool) (UnityEngine.Object) obj)
        return;
      obj.Release();
      RenderTexture.ReleaseTemporary(obj);
      obj = (RenderTexture) null;
    }

    private IEnumerator _CoUpdateTextureOnNextFrame()
    {
      yield return (object) new WaitForEndOfFrame();
      this.UpdateTexture();
    }

    private void UpdateTexture()
    {
      Graphics.ExecuteCommandBuffer(UIEffectCapturedImage.s_CommandBuffer);
      this._Release(false);
      this.texture = (Texture) this.capturedTexture;
    }

    public enum DesamplingRate
    {
      None = 0,
      x1 = 1,
      x2 = 2,
      x4 = 4,
      x8 = 8,
    }
  }
}
