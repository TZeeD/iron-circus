// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.CharacterGlowFX
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace SteelCircus.FX
{
  public class CharacterGlowFX : MonoBehaviour
  {
    private List<Material> glowingMaterials;
    private Coroutine flashCR;
    private static readonly int characterGlowColorID = Shader.PropertyToID("_CharacterGlowColor");
    private static readonly int characterGlowRimAlphaID = Shader.PropertyToID("_CharacterGlowRimAlpha");
    private static readonly int characterGlowAnimationTimeID = Shader.PropertyToID("_CharacterGlowAnimationTime");
    private bool glow;
    private Color glowColor;
    private float glowAlpha;

    public void SetGlowingMaterialsList(List<Material[]> mats)
    {
      this.glowingMaterials = new List<Material>();
      foreach (Material[] mat in mats)
      {
        foreach (Material material in mat)
        {
          if (!this.glowingMaterials.Contains(material) && material.HasProperty(CharacterGlowFX.characterGlowColorID))
            this.glowingMaterials.Add(material);
        }
      }
    }

    public void SetGlow(Color color, float intensity)
    {
      this.glow = true;
      this.glowColor = color;
      this.glowAlpha = intensity;
      if (this.flashCR != null)
        return;
      this.SetMaterialProperties(this.glowColor, intensity, 0.0f);
    }

    public void ClearGlow()
    {
      this.glow = false;
      if (this.flashCR != null)
        return;
      this.SetMaterialProperties(this.glowColor, 0.0f, 0.0f);
    }

    public void Flash(Color color, float duration = 0.8f)
    {
      if (this.flashCR != null)
        this.StopCoroutine(this.flashCR);
      this.flashCR = this.StartCoroutine(this.FlashFXCR(color, duration));
    }

    private IEnumerator FlashFXCR(Color color, float duration)
    {
      float flashDuration = duration;
      float flashCounter = 0.0f;
      while ((double) flashCounter < 1.0)
      {
        flashCounter = Mathf.Clamp01(flashCounter + Time.deltaTime / flashDuration);
        this.InterpolateFlashAndGlow(color, 0.0f, flashCounter);
        yield return (object) null;
      }
      this.InterpolateFlashAndGlow(color, 0.0f, 0.0f);
      this.flashCR = (Coroutine) null;
    }

    private void InterpolateFlashAndGlow(Color color, float rimAlpha, float animationTime)
    {
      if (!this.glow)
      {
        this.SetMaterialProperties(color, rimAlpha, animationTime);
      }
      else
      {
        float t = Mathf.Pow(Mathf.Clamp01(Mathf.Sin(animationTime * 3.141593f)), 0.5f);
        color = Color.Lerp(this.glowColor, color, t);
        rimAlpha = Mathf.Lerp(this.glowAlpha, rimAlpha, t);
        this.SetMaterialProperties(color, rimAlpha, animationTime);
      }
    }

    private void SetMaterialProperties(Color color, float rimAlpha, float animationTime)
    {
      foreach (Material glowingMaterial in this.glowingMaterials)
      {
        glowingMaterial.SetColor(CharacterGlowFX.characterGlowColorID, color);
        glowingMaterial.SetFloat(CharacterGlowFX.characterGlowRimAlphaID, rimAlpha);
        glowingMaterial.SetFloat(CharacterGlowFX.characterGlowAnimationTimeID, animationTime);
      }
    }
  }
}
