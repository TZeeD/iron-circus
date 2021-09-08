// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.AnimateShader
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace SteelCircus.FX.Skills
{
  public class AnimateShader : MonoBehaviour
  {
    [SerializeField]
    private string propertyName = "_AnimTime";
    [SerializeField]
    private float duration = 1f;
    [SerializeField]
    private bool loop;
    [SerializeField]
    private AnimationCurve curve = AnimationCurve.Linear(0.0f, 0.0f, 1f, 1f);
    [SerializeField]
    private Renderer renderer;
    private float counter;
    private int propID;

    private void OnValidate() => this.propID = Shader.PropertyToID(this.propertyName);

    private void Start()
    {
      this.propID = Shader.PropertyToID(this.propertyName);
      this.UpdateProperty();
    }

    private void Update()
    {
      this.counter += Time.deltaTime / this.duration;
      this.UpdateProperty();
    }

    private void UpdateProperty()
    {
      float counter = this.counter;
      float num = this.curve.Evaluate(!this.loop ? Mathf.Clamp01(counter) : counter % 1f);
      if (!((Object) this.renderer != (Object) null))
        return;
      this.renderer.material.SetFloat(this.propID, num);
    }
  }
}
