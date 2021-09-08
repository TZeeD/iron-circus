// Decompiled with JetBrains decompiler
// Type: Coffee.UIExtensions.UIEffectBase
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace Coffee.UIExtensions
{
  [DisallowMultipleComponent]
  public abstract class UIEffectBase : BaseMeshEffect, IParameterTexture
  {
    protected static readonly Vector2[] splitedCharacterPosition = new Vector2[4]
    {
      Vector2.up,
      Vector2.one,
      Vector2.right,
      Vector2.zero
    };
    protected static readonly List<UIVertex> tempVerts = new List<UIVertex>();
    [HideInInspector]
    [SerializeField]
    private int m_Version;
    [SerializeField]
    protected Material m_EffectMaterial;

    public int parameterIndex { get; set; }

    public virtual ParameterTexture ptex => (ParameterTexture) null;

    public Graphic targetGraphic => this.graphic;

    public Material effectMaterial => this.m_EffectMaterial;

    public virtual void ModifyMaterial() => this.targetGraphic.material = this.isActiveAndEnabled ? this.m_EffectMaterial : (Material) null;

    protected override void OnEnable()
    {
      base.OnEnable();
      if (this.ptex != null)
        this.ptex.Register((IParameterTexture) this);
      this.ModifyMaterial();
      this.SetVerticesDirty();
      this.SetDirty();
    }

    protected override void OnDisable()
    {
      base.OnDisable();
      this.ModifyMaterial();
      this.SetVerticesDirty();
      if (this.ptex == null)
        return;
      this.ptex.Unregister((IParameterTexture) this);
    }

    protected virtual void SetDirty() => this.SetVerticesDirty();

    protected override void OnDidApplyAnimationProperties() => this.SetDirty();
  }
}
