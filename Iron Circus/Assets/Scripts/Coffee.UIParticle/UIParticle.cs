// Decompiled with JetBrains decompiler
// Type: Coffee.UIExtensions.UIParticle
// Assembly: Coffee.UIParticle, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: E570C018-62C0-4C27-95AB-D31B1CC6DDB6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Coffee.UIParticle.dll

using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace Coffee.UIExtensions
{
  [ExecuteInEditMode]
  public class UIParticle : MaskableGraphic
  {
    private static readonly int s_IdMainTex = Shader.PropertyToID("_MainTex");
    private static readonly List<Vector3> s_Vertices = new List<Vector3>();
    private static readonly List<UIParticle> s_TempRelatables = new List<UIParticle>();
    private static readonly List<UIParticle> s_ActiveParticles = new List<UIParticle>();
    [Tooltip("The ParticleSystem rendered by CanvasRenderer")]
    [SerializeField]
    private ParticleSystem m_ParticleSystem;
    [Tooltip("The UIParticle to render trail effect")]
    [SerializeField]
    private UIParticle m_TrailParticle;
    [HideInInspector]
    [SerializeField]
    private bool m_IsTrail;
    [Tooltip("Particle effect scale")]
    [SerializeField]
    private float m_Scale = 1f;
    [Tooltip("Ignore parent scale")]
    [SerializeField]
    private bool m_IgnoreParent;
    [Tooltip("Animatable material properties. AnimationでParticleSystemのマテリアルプロパティを変更する場合、有効にしてください。")]
    [SerializeField]
    private UIParticle.AnimatableProperty[] m_AnimatableProperties = new UIParticle.AnimatableProperty[0];
    private static MaterialPropertyBlock s_Mpb;
    private Mesh _mesh;
    private ParticleSystemRenderer _renderer;
    private UIParticle _parent;
    private List<UIParticle> _children = new List<UIParticle>();
    private Matrix4x4 scaleaMatrix;
    private Vector3 _oldPos;
    private static ParticleSystem.Particle[] s_Particles = new ParticleSystem.Particle[4096];

    public override Texture mainTexture
    {
      get
      {
        Texture texture = (Texture) null;
        if (!this.m_IsTrail && (bool) (UnityEngine.Object) this.cachedParticleSystem)
        {
          ParticleSystem.TextureSheetAnimationModule textureSheetAnimation = this.cachedParticleSystem.textureSheetAnimation;
          if (textureSheetAnimation.enabled && textureSheetAnimation.mode == ParticleSystemAnimationMode.Sprites && 0 < textureSheetAnimation.spriteCount)
            texture = (Texture) textureSheetAnimation.GetSprite(0).texture;
        }
        if (!(bool) (UnityEngine.Object) texture && (bool) (UnityEngine.Object) this._renderer)
        {
          Material material = this.material;
          if ((bool) (UnityEngine.Object) material && material.HasProperty(UIParticle.s_IdMainTex))
            texture = material.mainTexture;
        }
        return texture ?? (Texture) Graphic.s_WhiteTexture;
      }
    }

    public override Material material
    {
      get
      {
        if (!(bool) (UnityEngine.Object) this._renderer)
          return (Material) null;
        return !this.m_IsTrail ? this._renderer.sharedMaterial : this._renderer.trailMaterial;
      }
      set
      {
        if (!(bool) (UnityEngine.Object) this._renderer)
          return;
        if (this.m_IsTrail && (UnityEngine.Object) this._renderer.trailMaterial != (UnityEngine.Object) value)
        {
          this._renderer.trailMaterial = value;
          this.SetMaterialDirty();
        }
        else
        {
          if (this.m_IsTrail || !((UnityEngine.Object) this._renderer.sharedMaterial != (UnityEngine.Object) value))
            return;
          this._renderer.sharedMaterial = value;
          this.SetMaterialDirty();
        }
      }
    }

    public float scale
    {
      get => !(bool) (UnityEngine.Object) this._parent ? this.m_Scale : this._parent.scale;
      set => this.m_Scale = value;
    }

    public bool ignoreParent
    {
      get => this.m_IgnoreParent;
      set
      {
        if (this.m_IgnoreParent == value)
          return;
        this.m_IgnoreParent = value;
        this.OnTransformParentChanged();
      }
    }

    public bool isRoot => !(bool) (UnityEngine.Object) this._parent;

    public override bool raycastTarget
    {
      get => false;
      set => base.raycastTarget = value;
    }

    public ParticleSystem cachedParticleSystem => !(bool) (UnityEngine.Object) this.m_ParticleSystem ? (this.m_ParticleSystem = this.GetComponent<ParticleSystem>()) : this.m_ParticleSystem;

    public override Material GetModifiedMaterial(Material baseMaterial) => base.GetModifiedMaterial((bool) (UnityEngine.Object) this._renderer ? (this.m_AnimatableProperties.Length != 0 ? new Material(this.material) : this._renderer.sharedMaterial) : baseMaterial);

    protected override void OnEnable()
    {
      if (UIParticle.s_ActiveParticles.Count == 0)
      {
        Canvas.willRenderCanvases += new Canvas.WillRenderCanvases(UIParticle.UpdateMeshes);
        UIParticle.s_Mpb = new MaterialPropertyBlock();
      }
      UIParticle.s_ActiveParticles.Add(this);
      this.GetComponentsInChildren<UIParticle>(false, UIParticle.s_TempRelatables);
      for (int index = UIParticle.s_TempRelatables.Count - 1; 0 <= index; --index)
        UIParticle.s_TempRelatables[index].OnTransformParentChanged();
      UIParticle.s_TempRelatables.Clear();
      this._renderer = (bool) (UnityEngine.Object) this.cachedParticleSystem ? this.cachedParticleSystem.GetComponent<ParticleSystemRenderer>() : (ParticleSystemRenderer) null;
      if ((bool) (UnityEngine.Object) this._renderer && Application.isPlaying)
        this._renderer.enabled = false;
      this._mesh = new Mesh();
      this._mesh.MarkDynamic();
      this.CheckTrail();
      if ((bool) (UnityEngine.Object) this.cachedParticleSystem)
        this._oldPos = this.cachedParticleSystem.main.scalingMode == ParticleSystemScalingMode.Local ? this.rectTransform.localPosition : this.rectTransform.position;
      base.OnEnable();
    }

    protected override void OnDisable()
    {
      UIParticle.s_ActiveParticles.Remove(this);
      if (UIParticle.s_ActiveParticles.Count == 0)
        Canvas.willRenderCanvases -= new Canvas.WillRenderCanvases(UIParticle.UpdateMeshes);
      for (int index = this._children.Count - 1; 0 <= index; --index)
        this._children[index].SetParent(this._parent);
      this._children.Clear();
      this.SetParent((UIParticle) null);
      UnityEngine.Object.DestroyImmediate((UnityEngine.Object) this._mesh);
      this._mesh = (Mesh) null;
      this.CheckTrail();
      base.OnDisable();
    }

    protected override void UpdateGeometry()
    {
    }

    protected override void OnTransformParentChanged()
    {
      UIParticle newParent = (UIParticle) null;
      if (this.isActiveAndEnabled && !this.m_IgnoreParent)
      {
        for (Transform parent = this.transform.parent; (bool) (UnityEngine.Object) parent && (!(bool) (UnityEngine.Object) newParent || !newParent.enabled); parent = parent.parent)
          newParent = parent.GetComponent<UIParticle>();
      }
      this.SetParent(newParent);
      base.OnTransformParentChanged();
    }

    protected override void OnDidApplyAnimationProperties()
    {
    }

    private static void UpdateMeshes()
    {
      for (int index = 0; index < UIParticle.s_ActiveParticles.Count; ++index)
      {
        if ((bool) (UnityEngine.Object) UIParticle.s_ActiveParticles[index])
          UIParticle.s_ActiveParticles[index].UpdateMesh();
      }
    }

    private void UpdateMesh()
    {
      try
      {
        this.CheckTrail();
        if (!(bool) (UnityEngine.Object) this.m_ParticleSystem || !(bool) (UnityEngine.Object) this.canvas)
          return;
        Vector3 localPosition = this.rectTransform.localPosition;
        if ((double) Mathf.Abs(localPosition.z) < 0.00999999977648258)
        {
          localPosition.z = 0.01f;
          this.rectTransform.localPosition = localPosition;
        }
        Canvas rootCanvas = this.canvas.rootCanvas;
        if (Application.isPlaying)
          this._renderer.enabled = false;
        ParticleSystem.MainModule main = this.m_ParticleSystem.main;
        this.scaleaMatrix = main.scalingMode == ParticleSystemScalingMode.Hierarchy ? Matrix4x4.Scale(this.scale * Vector3.one) : Matrix4x4.Scale(this.scale * rootCanvas.transform.localScale);
        Matrix4x4 matrix4x4 = new Matrix4x4();
        switch (main.simulationSpace)
        {
          case ParticleSystemSimulationSpace.Local:
            matrix4x4 = this.scaleaMatrix * Matrix4x4.Rotate(this.rectTransform.rotation).inverse * Matrix4x4.Scale(this.rectTransform.lossyScale).inverse;
            break;
          case ParticleSystemSimulationSpace.World:
            matrix4x4 = this.scaleaMatrix * this.rectTransform.worldToLocalMatrix;
            bool flag = main.scalingMode == ParticleSystemScalingMode.Local;
            Vector3 position = this.rectTransform.position;
            Vector3 vector3_1 = position - this._oldPos;
            this._oldPos = position;
            if (!Mathf.Approximately(this.scale, 0.0f) && 0.0 < (double) vector3_1.sqrMagnitude)
            {
              if (flag)
              {
                Vector3 vector3_2 = rootCanvas.transform.localScale * this.scale;
                vector3_1.x *= (float) (1.0 - 1.0 / (double) vector3_2.x);
                vector3_1.y *= (float) (1.0 - 1.0 / (double) vector3_2.y);
                vector3_1.z *= (float) (1.0 - 1.0 / (double) vector3_2.z);
              }
              else
                vector3_1 *= (float) (1.0 - 1.0 / (double) this.scale);
              int particleCount = this.m_ParticleSystem.particleCount;
              if (UIParticle.s_Particles.Length < particleCount)
                UIParticle.s_Particles = new ParticleSystem.Particle[UIParticle.s_Particles.Length * 2];
              this.m_ParticleSystem.GetParticles(UIParticle.s_Particles);
              for (int index = 0; index < particleCount; ++index)
              {
                ParticleSystem.Particle particle = UIParticle.s_Particles[index];
                particle.position += vector3_1;
                UIParticle.s_Particles[index] = particle;
              }
              this.m_ParticleSystem.SetParticles(UIParticle.s_Particles, particleCount);
              break;
            }
            break;
        }
        this._mesh.Clear();
        if (0 < this.m_ParticleSystem.particleCount)
        {
          Camera camera = rootCanvas.renderMode == RenderMode.ScreenSpaceOverlay ? UIParticleOverlayCamera.GetCameraForOvrelay(rootCanvas) : this.canvas.worldCamera ?? Camera.main;
          if (!(bool) (UnityEngine.Object) camera)
            return;
          if (this.m_IsTrail)
            this._renderer.BakeTrailsMesh(this._mesh, camera, true);
          else
            this._renderer.BakeMesh(this._mesh, camera, true);
          this._mesh.GetVertices(UIParticle.s_Vertices);
          int count = UIParticle.s_Vertices.Count;
          for (int index = 0; index < count; ++index)
            UIParticle.s_Vertices[index] = matrix4x4.MultiplyPoint3x4(UIParticle.s_Vertices[index]);
          this._mesh.SetVertices(UIParticle.s_Vertices);
          UIParticle.s_Vertices.Clear();
        }
        this.canvasRenderer.SetMesh(this._mesh);
        this.canvasRenderer.SetTexture(this.mainTexture);
        this.UpdateAnimatableMaterialProperties();
      }
      catch (Exception ex)
      {
        Debug.LogException(ex);
      }
    }

    private void CheckTrail()
    {
      if (this.isActiveAndEnabled && !this.m_IsTrail && (bool) (UnityEngine.Object) this.m_ParticleSystem && this.m_ParticleSystem.trails.enabled)
      {
        if (!(bool) (UnityEngine.Object) this.m_TrailParticle)
        {
          this.m_TrailParticle = new GameObject("[UIParticle] Trail").AddComponent<UIParticle>();
          Transform transform = this.m_TrailParticle.transform;
          transform.SetParent(this.transform);
          transform.localPosition = Vector3.zero;
          transform.localRotation = Quaternion.identity;
          transform.localScale = Vector3.one;
          this.m_TrailParticle._renderer = this.GetComponent<ParticleSystemRenderer>();
          this.m_TrailParticle.m_ParticleSystem = this.GetComponent<ParticleSystem>();
          this.m_TrailParticle.m_IsTrail = true;
        }
        this.m_TrailParticle.enabled = true;
      }
      else
      {
        if (!(bool) (UnityEngine.Object) this.m_TrailParticle)
          return;
        this.m_TrailParticle.enabled = false;
      }
    }

    private void SetParent(UIParticle newParent)
    {
      if ((UnityEngine.Object) this._parent != (UnityEngine.Object) newParent && (UnityEngine.Object) this != (UnityEngine.Object) newParent)
      {
        if ((bool) (UnityEngine.Object) this._parent && this._parent._children.Contains(this))
        {
          this._parent._children.Remove(this);
          this._parent._children.RemoveAll((Predicate<UIParticle>) (x => (UnityEngine.Object) x == (UnityEngine.Object) null));
        }
        this._parent = newParent;
      }
      if (!(bool) (UnityEngine.Object) this._parent || this._parent._children.Contains(this))
        return;
      this._parent._children.Add(this);
    }

    private void UpdateAnimatableMaterialProperties()
    {
      if (this.m_AnimatableProperties.Length == 0)
        return;
      this._renderer.GetPropertyBlock(UIParticle.s_Mpb);
      for (int index = 0; index < this.canvasRenderer.materialCount; ++index)
      {
        Material material = this.canvasRenderer.GetMaterial(index);
        foreach (UIParticle.AnimatableProperty animatableProperty in this.m_AnimatableProperties)
        {
          switch (animatableProperty.type)
          {
            case UIParticle.AnimatableProperty.ShaderPropertyType.Color:
              material.SetColor(animatableProperty.id, UIParticle.s_Mpb.GetColor(animatableProperty.id));
              break;
            case UIParticle.AnimatableProperty.ShaderPropertyType.Vector:
              material.SetVector(animatableProperty.id, UIParticle.s_Mpb.GetVector(animatableProperty.id));
              break;
            case UIParticle.AnimatableProperty.ShaderPropertyType.Float:
            case UIParticle.AnimatableProperty.ShaderPropertyType.Range:
              material.SetFloat(animatableProperty.id, UIParticle.s_Mpb.GetFloat(animatableProperty.id));
              break;
            case UIParticle.AnimatableProperty.ShaderPropertyType.Texture:
              material.SetTexture(animatableProperty.id, UIParticle.s_Mpb.GetTexture(animatableProperty.id));
              break;
          }
        }
      }
    }

    [Serializable]
    public class AnimatableProperty : ISerializationCallbackReceiver
    {
      [SerializeField]
      private string m_Name = "";
      [SerializeField]
      private UIParticle.AnimatableProperty.ShaderPropertyType m_Type = UIParticle.AnimatableProperty.ShaderPropertyType.Vector;

      public int id { get; private set; }

      public UIParticle.AnimatableProperty.ShaderPropertyType type => this.m_Type;

      public void OnBeforeSerialize()
      {
      }

      public void OnAfterDeserialize() => this.id = Shader.PropertyToID(this.m_Name);

      public enum ShaderPropertyType
      {
        Color,
        Vector,
        Float,
        Range,
        Texture,
      }
    }
  }
}
