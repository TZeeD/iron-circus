// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.KennyFlame
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace SteelCircus.FX
{
  public class KennyFlame : MonoBehaviour
  {
    [SerializeField]
    private MeshRenderer[] meshes;
    [SerializeField]
    private Transform scaleTransform;
    [SerializeField]
    private AnimationCurve intensityToScale = AnimationCurve.Constant(0.0f, 3f, 1f);
    [SerializeField]
    private AnimationCurve intensityToYScale = AnimationCurve.Constant(0.0f, 3f, 1f);
    private MaterialPropertyBlock props;
    private readonly int _Intensity = Shader.PropertyToID(nameof (_Intensity));

    private void Awake()
    {
      this.props = new MaterialPropertyBlock();
      this.SetIntensity(0.0f);
    }

    public void SetIntensity(float intensity)
    {
      this.props.SetFloat(this._Intensity, intensity);
      foreach (Renderer mesh in this.meshes)
        mesh.SetPropertyBlock(this.props);
      Vector3 vector3 = Vector3.one * this.intensityToScale.Evaluate(intensity);
      vector3.y *= this.intensityToYScale.Evaluate(intensity);
      this.scaleTransform.localScale = vector3;
    }
  }
}
