// Decompiled with JetBrains decompiler
// Type: DigitalRuby.LightningBolt.LightningBoltScript
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Collections.Generic;
using UnityEngine;

namespace DigitalRuby.LightningBolt
{
  [RequireComponent(typeof (LineRenderer))]
  public class LightningBoltScript : MonoBehaviour
  {
    [Tooltip("The game object where the lightning will emit from. If null, StartPosition is used.")]
    public GameObject StartObject;
    [Tooltip("The start position where the lightning will emit from. This is in world space if StartObject is null, otherwise this is offset from StartObject position.")]
    public Vector3 StartPosition;
    [Tooltip("The game object where the lightning will end at. If null, EndPosition is used.")]
    public GameObject EndObject;
    [Tooltip("The end position where the lightning will end at. This is in world space if EndObject is null, otherwise this is offset from EndObject position.")]
    public Vector3 EndPosition;
    [Range(0.0f, 8f)]
    [Tooltip("How manu generations? Higher numbers create more line segments.")]
    public int Generations = 6;
    [Range(0.01f, 1f)]
    [Tooltip("How long each bolt should last before creating a new bolt. In ManualMode, the bolt will simply disappear after this amount of seconds.")]
    public float Duration = 0.05f;
    private float timer;
    [Range(0.0f, 1f)]
    [Tooltip("How chaotic should the lightning be? (0-1)")]
    public float ChaosFactor = 0.15f;
    [Tooltip("In manual mode, the trigger method must be called to create a bolt")]
    public bool ManualMode;
    [Range(1f, 64f)]
    [Tooltip("The number of rows in the texture. Used for animation.")]
    public int Rows = 1;
    [Range(1f, 64f)]
    [Tooltip("The number of columns in the texture. Used for animation.")]
    public int Columns = 1;
    [Tooltip("The animation mode for the lightning")]
    public LightningBoltAnimationMode AnimationMode = LightningBoltAnimationMode.PingPong;
    [HideInInspector]
    [NonSerialized]
    public System.Random RandomGenerator = new System.Random();
    private LineRenderer lineRenderer;
    private List<KeyValuePair<Vector3, Vector3>> segments = new List<KeyValuePair<Vector3, Vector3>>();
    private int startIndex;
    private Vector2 size;
    private Vector2[] offsets;
    private int animationOffsetIndex;
    private int animationPingPongDirection = 1;
    private bool orthographic;

    private void GetPerpendicularVector(ref Vector3 directionNormalized, out Vector3 side)
    {
      if (directionNormalized == Vector3.zero)
      {
        side = Vector3.right;
      }
      else
      {
        float x1 = directionNormalized.x;
        float y1 = directionNormalized.y;
        float z1 = directionNormalized.z;
        double num1 = (double) Mathf.Abs(x1);
        float num2 = Mathf.Abs(y1);
        float num3 = Mathf.Abs(z1);
        double num4 = (double) num2;
        float y2;
        float z2;
        float x2;
        if (num1 >= num4 && (double) num2 >= (double) num3)
        {
          y2 = 1f;
          z2 = 1f;
          x2 = (float) -((double) y1 * (double) y2 + (double) z1 * (double) z2) / x1;
        }
        else if ((double) num2 >= (double) num3)
        {
          x2 = 1f;
          z2 = 1f;
          y2 = (float) -((double) x1 * (double) x2 + (double) z1 * (double) z2) / y1;
        }
        else
        {
          x2 = 1f;
          y2 = 1f;
          z2 = (float) -((double) x1 * (double) x2 + (double) y1 * (double) y2) / z1;
        }
        side = new Vector3(x2, y2, z2).normalized;
      }
    }

    private void GenerateLightningBolt(
      Vector3 start,
      Vector3 end,
      int generation,
      int totalGenerations,
      float offsetAmount)
    {
      if (generation < 0 || generation > 8)
        return;
      if (this.orthographic)
        start.z = end.z = Mathf.Min(start.z, end.z);
      this.segments.Add(new KeyValuePair<Vector3, Vector3>(start, end));
      if (generation == 0)
        return;
      if ((double) offsetAmount <= 0.0)
        offsetAmount = (end - start).magnitude * this.ChaosFactor;
      while (generation-- > 0)
      {
        int startIndex = this.startIndex;
        this.startIndex = this.segments.Count;
        for (int index = startIndex; index < this.startIndex; ++index)
        {
          KeyValuePair<Vector3, Vector3> segment = this.segments[index];
          start = segment.Key;
          segment = this.segments[index];
          end = segment.Value;
          Vector3 vector3 = (start + end) * 0.5f;
          Vector3 result;
          this.RandomVector(ref start, ref end, offsetAmount, out result);
          Vector3 key = vector3 + result;
          this.segments.Add(new KeyValuePair<Vector3, Vector3>(start, key));
          this.segments.Add(new KeyValuePair<Vector3, Vector3>(key, end));
        }
        offsetAmount *= 0.5f;
      }
    }

    public void RandomVector(
      ref Vector3 start,
      ref Vector3 end,
      float offsetAmount,
      out Vector3 result)
    {
      if (this.orthographic)
      {
        Vector3 normalized = (end - start).normalized;
        Vector3 vector3 = new Vector3(-normalized.y, normalized.x, normalized.z);
        float num = (float) (this.RandomGenerator.NextDouble() * (double) offsetAmount * 2.0) - offsetAmount;
        result = vector3 * num;
      }
      else
      {
        Vector3 normalized = (end - start).normalized;
        Vector3 side;
        this.GetPerpendicularVector(ref normalized, out side);
        float num = ((float) this.RandomGenerator.NextDouble() + 0.1f) * offsetAmount;
        float angle = (float) this.RandomGenerator.NextDouble() * 360f;
        result = Quaternion.AngleAxis(angle, normalized) * side * num;
      }
    }

    private void SelectOffsetFromAnimationMode()
    {
      if (this.AnimationMode == LightningBoltAnimationMode.None)
      {
        this.lineRenderer.material.mainTextureOffset = this.offsets[0];
      }
      else
      {
        int index;
        if (this.AnimationMode == LightningBoltAnimationMode.PingPong)
        {
          index = this.animationOffsetIndex;
          this.animationOffsetIndex += this.animationPingPongDirection;
          if (this.animationOffsetIndex >= this.offsets.Length)
          {
            this.animationOffsetIndex = this.offsets.Length - 2;
            this.animationPingPongDirection = -1;
          }
          else if (this.animationOffsetIndex < 0)
          {
            this.animationOffsetIndex = 1;
            this.animationPingPongDirection = 1;
          }
        }
        else if (this.AnimationMode == LightningBoltAnimationMode.Loop)
        {
          index = this.animationOffsetIndex++;
          if (this.animationOffsetIndex >= this.offsets.Length)
            this.animationOffsetIndex = 0;
        }
        else
          index = this.RandomGenerator.Next(0, this.offsets.Length);
        if (index >= 0 && index < this.offsets.Length)
          this.lineRenderer.material.mainTextureOffset = this.offsets[index];
        else
          this.lineRenderer.material.mainTextureOffset = this.offsets[0];
      }
    }

    private void UpdateLineRenderer()
    {
      int num1 = this.segments.Count - this.startIndex + 1;
      this.lineRenderer.positionCount = num1;
      if (num1 < 1)
        return;
      int num2 = 0;
      LineRenderer lineRenderer1 = this.lineRenderer;
      int index1 = num2;
      int num3 = index1 + 1;
      KeyValuePair<Vector3, Vector3> segment = this.segments[this.startIndex];
      Vector3 key = segment.Key;
      lineRenderer1.SetPosition(index1, key);
      for (int startIndex = this.startIndex; startIndex < this.segments.Count; ++startIndex)
      {
        LineRenderer lineRenderer2 = this.lineRenderer;
        int index2 = num3++;
        segment = this.segments[startIndex];
        Vector3 position = segment.Value;
        lineRenderer2.SetPosition(index2, position);
      }
      this.segments.Clear();
      this.SelectOffsetFromAnimationMode();
    }

    private void Start()
    {
      this.orthographic = (UnityEngine.Object) Camera.main != (UnityEngine.Object) null && Camera.main.orthographic;
      this.lineRenderer = this.GetComponent<LineRenderer>();
      this.lineRenderer.positionCount = 0;
      this.UpdateFromMaterialChange();
    }

    private void Update()
    {
      this.orthographic = (UnityEngine.Object) Camera.main != (UnityEngine.Object) null && Camera.main.orthographic;
      if ((double) this.timer <= 0.0)
      {
        if (this.ManualMode)
        {
          this.timer = this.Duration;
          this.lineRenderer.positionCount = 0;
        }
        else
          this.Trigger();
      }
      this.timer -= Time.deltaTime;
    }

    public void Trigger()
    {
      this.timer = this.Duration + Mathf.Min(0.0f, this.timer);
      Vector3 start = !((UnityEngine.Object) this.StartObject == (UnityEngine.Object) null) ? this.StartObject.transform.position + this.StartPosition : this.StartPosition;
      Vector3 end = !((UnityEngine.Object) this.EndObject == (UnityEngine.Object) null) ? this.EndObject.transform.position + this.EndPosition : this.EndPosition;
      this.startIndex = 0;
      this.GenerateLightningBolt(start, end, this.Generations, this.Generations, 0.0f);
      this.UpdateLineRenderer();
    }

    public void UpdateFromMaterialChange()
    {
      this.size = new Vector2(1f / (float) this.Columns, 1f / (float) this.Rows);
      this.lineRenderer.material.mainTextureScale = this.size;
      this.offsets = new Vector2[this.Rows * this.Columns];
      for (int index1 = 0; index1 < this.Rows; ++index1)
      {
        for (int index2 = 0; index2 < this.Columns; ++index2)
          this.offsets[index2 + index1 * this.Columns] = new Vector2((float) index2 / (float) this.Columns, (float) index1 / (float) this.Rows);
      }
    }
  }
}
