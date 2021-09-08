// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.UI.Floor.Player.PlayerFloorOuterRingDisplay
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SteelCircus.ScriptableObjects;
using UnityEngine;

namespace Imi.SteelCircus.UI.Floor.Player
{
  public class PlayerFloorOuterRingDisplay : MonoBehaviour
  {
    public float paddingAngle = 5f;
    private Material ringMaterial;
    private Color mainColor;
    [SerializeField]
    private Color glowColor;
    [SerializeField]
    private float animFrequency = 2f;
    [SerializeField]
    private float animMinRadius = 0.7f;
    private float animCounter;
    private static int _Color2 = Shader.PropertyToID(nameof (_Color2));
    private static int _C2Radius = Shader.PropertyToID(nameof (_C2Radius));

    public void Setup(ColorsConfig colorsConfig, Team team)
    {
      this.mainColor = colorsConfig.MiddleColor(team);
      this.ringMaterial.color = this.mainColor;
    }

    public void MaxHPChangedHandler(PlayerFloorHealthDisplay healthDisplay)
    {
      double maxHp = (double) healthDisplay.MaxHP;
      float pointAngleSpread = healthDisplay.healthPointAngleSpread;
      float num = (float) (360.0 - ((double) pointAngleSpread / 2.0 + (double) this.paddingAngle));
      this.ringMaterial.SetFloat("_MinAngle", (float) (maxHp - 0.5) * pointAngleSpread + this.paddingAngle);
      this.ringMaterial.SetFloat("_MaxAngle", num);
    }

    private void Awake() => this.ringMaterial = this.GetComponent<Renderer>().material;

    private void Update()
    {
      this.animCounter += Time.deltaTime * this.animFrequency;
      float f = Mathf.Clamp01(this.animCounter % 1f);
      this.ringMaterial.SetColor(PlayerFloorOuterRingDisplay._Color2, Color.Lerp(this.glowColor, this.mainColor, Mathf.Pow(f, 2f)));
      this.ringMaterial.SetFloat(PlayerFloorOuterRingDisplay._C2Radius, Mathf.Lerp(0.0f, this.animMinRadius, Mathf.Pow(f, 0.5f)));
    }

    private void OnEnable() => this.animCounter = 0.0f;
  }
}
