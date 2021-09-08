// Decompiled with JetBrains decompiler
// Type: SpriteParticleEmitter.EmitterBaseUI
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.UI;

namespace SpriteParticleEmitter
{
  [SerializeField]
  public abstract class EmitterBaseUI : MonoBehaviour
  {
    [Header("References")]
    [Tooltip("Must be provided by other GameObject's ImageRenderer.")]
    public Image imageRenderer;
    [Tooltip("If none is provided the script will look for one in this game object.")]
    public ParticleSystem particlesSystem;
    [Header("Color Emission Options")]
    public bool UseEmissionFromColor;
    [Tooltip("Emission will take this color as only source position")]
    public Color EmitFromColor;
    [Range(0.01f, 1f)]
    [Tooltip("In conjunction with EmitFromColor. Defines how much can it deviate from red spectrum for selected color.")]
    public float RedTolerance = 0.05f;
    [Range(0.0f, 1f)]
    [Tooltip("In conjunction with EmitFromColor. Defines how much can it deviate from green spectrum for selected color.")]
    public float GreenTolerance = 0.05f;
    [Range(0.0f, 1f)]
    [Tooltip("In conjunction with EmitFromColor. Defines how much can it deviate from blue spectrum for selected color.")]
    public float BlueTolerance = 0.05f;
    [Tooltip("Should new particles override ParticleSystem's startColor and use the color in the pixel they're emitting from?")]
    public bool UsePixelSourceColor;
    [Tooltip("Must match Particle System's same option")]
    protected ParticleSystemSimulationSpace SimulationSpace;
    protected bool isPlaying;
    protected UIParticleRenderer uiParticleSystem;
    protected ParticleSystem.MainModule mainModule;

    protected virtual void Awake()
    {
      this.uiParticleSystem = this.GetComponent<UIParticleRenderer>();
      if (!(bool) (Object) this.imageRenderer)
      {
        Debug.LogWarning((object) "Image Renderer not defined, must be defined in order for the system to work");
        this.isPlaying = false;
      }
      if (!(bool) (Object) this.particlesSystem)
      {
        this.particlesSystem = this.GetComponent<ParticleSystem>();
        if (!(bool) (Object) this.particlesSystem)
        {
          Debug.LogError((object) "No particle system found. Static Sprite Emission won't work");
          return;
        }
      }
      this.mainModule = this.particlesSystem.main;
      this.mainModule.loop = false;
      this.mainModule.playOnAwake = false;
      this.particlesSystem.Stop();
      this.SimulationSpace = this.mainModule.simulationSpace;
    }

    public abstract void Play();

    public abstract void Pause();

    public abstract void Stop();

    public abstract bool IsPlaying();

    public abstract bool IsAvailableToPlay();

    public virtual event SimpleEvent OnCacheEnded;

    public virtual event SimpleEvent OnAvailableToPlay;
  }
}
