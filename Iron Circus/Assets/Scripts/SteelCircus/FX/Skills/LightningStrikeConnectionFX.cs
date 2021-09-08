// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.LightningStrikeConnectionFX
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game.Skills;
using Imi.SteelCircus.JitterUnity;
using Imi.SteelCircus.ScriptableObjects;
using UnityEngine;
using UnityEngine.Serialization;

namespace SteelCircus.FX.Skills
{
  public class LightningStrikeConnectionFX : MonoBehaviour, IVfx
  {
    public float brightness = 3f;
    public float initialBrightness = 4f;
    public float brightnessFadeDuration = 0.3f;
    private float brightnessFadeCounter;
    private Color materialColor;
    public LightningStrike.ConnectionArgs connectionArgs;
    [FormerlySerializedAs("startPos")]
    public Vector3 startOffset = Vector3.zero;
    [FormerlySerializedAs("endPos")]
    public Vector3 endOffset = Vector3.forward * 10f;
    [SerializeField]
    private LineRenderer lineRenderer;
    [SerializeField]
    private int numVertsPerUnit = 4;
    [SerializeField]
    [Range(2f, 16f)]
    private int minNumVerts = 8;
    [SerializeField]
    private float curveHeight = 2f;
    [SerializeField]
    private float maxDistortionXZ = 1f;
    [SerializeField]
    private float maxDistortionY = 1f;
    [SerializeField]
    private float distortionPow = 1f;
    private Vector3[] curvePoints = new Vector3[200];
    private int numCurvePoints = 2;
    public float freq1 = 13.67f;
    public float phase1 = 3.875f;
    public float amp1 = 0.7f;
    public float ampModFreq1 = 21f;
    public float ampModAmp1 = 1f;
    public float freq2 = 7.11f;
    public float phase2 = 8.11241f;
    public float amp2 = 0.31f;
    public float ampModFreq2 = 21f;
    public float ampModAmp2 = 1f;
    public float freq3 = 2.34532f;
    public float phase3 = 0.2352f;
    public float amp3 = 0.15f;
    public float speedScale = 1f;
    public float ampScale = 1f;

    public void SetOwner(GameEntity entity)
    {
      this.materialColor = SingletonScriptableObject<ColorsConfig>.Instance.MiddleColor(entity.playerTeam.value);
      this.lineRenderer.material.color = this.materialColor * this.initialBrightness;
    }

    public void SetArgs(object args) => this.connectionArgs = (LightningStrike.ConnectionArgs) args;

    public void SetSkillGraph(SkillGraph graph)
    {
    }

    private void Update()
    {
      this.UpdateCurvePoints();
      this.lineRenderer.positionCount = this.numCurvePoints;
      this.lineRenderer.SetPositions(this.curvePoints);
      this.brightnessFadeCounter = Mathf.Clamp01(this.brightnessFadeCounter + Time.deltaTime / this.brightnessFadeDuration);
      this.lineRenderer.sharedMaterial.color = this.materialColor * Mathf.Lerp(this.initialBrightness, this.brightness, this.brightnessFadeCounter);
    }

    private void UpdateCurvePoints()
    {
      Vector3 vector3_1 = this.connectionArgs != null ? this.transform.InverseTransformPoint(this.connectionArgs.start.Get().ToVector3() + this.startOffset) : this.transform.InverseTransformPoint(this.startOffset);
      Vector3 vector3_2 = this.connectionArgs != null ? this.transform.InverseTransformPoint(this.connectionArgs.end.Get().ToVector3() + this.endOffset) : this.transform.InverseTransformPoint(this.endOffset);
      Vector3 vector3_3 = vector3_1;
      Vector3 vector3_4;
      Vector3 lhs = vector3_4 = vector3_2 - vector3_3;
      lhs.y = 0.0f;
      float magnitude = lhs.magnitude;
      this.numCurvePoints = Mathf.Max(this.minNumVerts, Mathf.CeilToInt((float) ((double) magnitude * (double) this.numVertsPerUnit + 1.0)));
      this.numCurvePoints = Mathf.Min(this.curvePoints.Length, this.numCurvePoints);
      Vector3 vector3_5 = vector3_1;
      double num = (double) (this.numCurvePoints - 1);
      Vector3 vector3_6 = vector3_4 / (float) num;
      for (int index = 0; index < this.numCurvePoints; ++index)
      {
        float t = (float) index / (float) (this.numCurvePoints - 1);
        Vector3 vector3_7 = Vector3.up * Mathf.Sin(3.141593f * t) * this.curveHeight;
        Vector3 normalized = Vector3.Cross(lhs, Vector3.up).normalized;
        Vector3 distortion = this.GetDistortion(t, normalized, magnitude);
        this.curvePoints[index] = vector3_5 + vector3_7 + distortion;
        vector3_5 += vector3_6;
      }
    }

    private Vector3 GetDistortion(float t, Vector3 normal, float length)
    {
      float num = this.LightningDistortion(t, length) * this.maxDistortionXZ;
      Vector3 vector3_1 = new Vector3(0.0f, this.LightningDistortion(t + 71.65324f, length) * this.maxDistortionY, 0.0f);
      normal *= num;
      Vector3 vector3_2 = normal;
      return (vector3_1 + vector3_2) * Mathf.Pow(Mathf.Clamp01(Mathf.Sin(t * 3.141593f)), this.distortionPow);
    }

    private float LightningDistortion(float t, float length)
    {
      t *= length;
      t += Time.realtimeSinceStartup;
      t *= this.speedScale;
      double num1 = (double) this.ZigZag((float) ((double) t * (double) this.freq1 + (double) this.phase1 + (double) Mathf.Sin(this.ampModFreq1 * t) * (double) this.ampModAmp1) + this.ampModAmp1) * (double) this.amp1;
      float num2 = this.ZigZag((float) ((double) t * (double) this.freq2 + (double) this.phase2 + (double) Mathf.Sin(this.ampModFreq2 * t) * (double) this.ampModAmp2) + this.ampModAmp2) * this.amp2;
      float num3 = this.ZigZag(t * this.freq3 + this.phase3) * this.amp3;
      double num4 = (double) num2;
      return ((float) (num1 + num4) + num3) * this.ampScale;
    }

    private float ZigZag(float t)
    {
      t %= 1f;
      t = (double) t > 0.5 ? 1f - t : t;
      t = (float) ((double) t * 4.0 - 1.0);
      return t;
    }
  }
}
