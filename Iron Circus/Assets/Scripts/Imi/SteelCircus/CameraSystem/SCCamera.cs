// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.CameraSystem.SCCamera
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SteelCircus.Core;
using SteelCircus.Core.Services;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.PostProcessing;

namespace Imi.SteelCircus.CameraSystem
{
  [ExecuteInEditMode]
  public class SCCamera : MonoBehaviour
  {
    [SerializeField]
    private Camera cameraBG;
    [SerializeField]
    private Camera cameraArena;
    [SerializeField]
    private Camera cameraReflection;
    [SerializeField]
    private Camera cameraColorGrading;
    public float nearClip = 0.3f;
    public float farClip = 1810f;
    public float fov = 72f;
    private RenderTextureDescriptor screenRTDesc;
    private RenderTextureDescriptor blurRTDesc;
    private Camera[] cams;

    private void Start()
    {
      this.SetupCams();
      this.screenRTDesc = new RenderTextureDescriptor(-1, -1, RenderTextureFormat.ARGB32);
      this.blurRTDesc = new RenderTextureDescriptor(-2, -2, RenderTextureFormat.ARGB32);
      this.screenRTDesc.depthBufferBits = this.blurRTDesc.depthBufferBits = 0;
      this.screenRTDesc.useMipMap = this.blurRTDesc.useMipMap = false;
      this.screenRTDesc.sRGB = this.blurRTDesc.sRGB = false;
      this.screenRTDesc.bindMS = this.blurRTDesc.bindMS = false;
      this.screenRTDesc.msaaSamples = this.blurRTDesc.msaaSamples = 1;
      this.cameraArena.AddCommandBuffer(CameraEvent.BeforeForwardAlpha, this.CreateCommandBuffer());
    }

    private void SetupCams() => this.cams = new Camera[4]
    {
      this.cameraBG,
      this.cameraArena,
      this.cameraReflection,
      this.cameraColorGrading
    };

    private CommandBuffer CreateCommandBuffer()
    {
      CommandBuffer commandBuffer = new CommandBuffer();
      commandBuffer.name = "Grab screen and blur";
      int id1 = Shader.PropertyToID("_ScreenCopyTexture");
      int id2 = Shader.PropertyToID("_Temp1");
      int id3 = Shader.PropertyToID("_Temp2");
      commandBuffer.GetTemporaryRT(id1, this.screenRTDesc, FilterMode.Bilinear);
      commandBuffer.GetTemporaryRT(id2, this.blurRTDesc, FilterMode.Bilinear);
      if (ImiServices.Instance.QualityManager.CurrentRenderSettings.vfx <= QualityManager.Level.Low)
      {
        commandBuffer.Blit((RenderTargetIdentifier) BuiltinRenderTextureType.CurrentActive, (RenderTargetIdentifier) id1);
        commandBuffer.Blit((RenderTargetIdentifier) id1, (RenderTargetIdentifier) id2);
        commandBuffer.SetGlobalTexture("_GrabTexture", (RenderTargetIdentifier) id1);
        commandBuffer.SetGlobalTexture("_GrabBlurTexture", (RenderTargetIdentifier) id2);
        return commandBuffer;
      }
      Material mat = new Material(Shader.Find("Hidden/SeparableGlassBlur"));
      mat.hideFlags = HideFlags.HideAndDontSave;
      commandBuffer.Blit((RenderTargetIdentifier) BuiltinRenderTextureType.CurrentActive, (RenderTargetIdentifier) id1);
      commandBuffer.GetTemporaryRT(id3, this.blurRTDesc, FilterMode.Bilinear);
      commandBuffer.Blit((RenderTargetIdentifier) id1, (RenderTargetIdentifier) id2);
      commandBuffer.SetGlobalVector("offsets", new Vector4(2f / (float) Screen.width, 0.0f, 0.0f, 0.0f));
      commandBuffer.Blit((RenderTargetIdentifier) id2, (RenderTargetIdentifier) id3, mat);
      commandBuffer.SetGlobalVector("offsets", new Vector4(0.0f, 2f / (float) Screen.height, 0.0f, 0.0f));
      commandBuffer.Blit((RenderTargetIdentifier) id3, (RenderTargetIdentifier) id2, mat);
      commandBuffer.SetGlobalVector("offsets", new Vector4(4f / (float) Screen.width, 0.0f, 0.0f, 0.0f));
      commandBuffer.Blit((RenderTargetIdentifier) id2, (RenderTargetIdentifier) id3, mat);
      commandBuffer.SetGlobalVector("offsets", new Vector4(0.0f, 4f / (float) Screen.height, 0.0f, 0.0f));
      commandBuffer.Blit((RenderTargetIdentifier) id3, (RenderTargetIdentifier) id2, mat);
      commandBuffer.SetGlobalTexture("_GrabTexture", (RenderTargetIdentifier) id1);
      commandBuffer.SetGlobalTexture("_GrabBlurTexture", (RenderTargetIdentifier) id2);
      return commandBuffer;
    }

    private void Update()
    {
      if (this.cams == null)
        this.SetupCams();
      foreach (Camera cam in this.cams)
      {
        cam.fieldOfView = this.fov;
        cam.nearClipPlane = this.nearClip;
        cam.farClipPlane = this.farClip;
      }
    }

    public Camera GetMain() => this.cameraArena;

    public void SetSkyboxes(Material background, Material reflections)
    {
      this.cameraBG.GetComponent<Skybox>().material = background;
      this.cameraReflection.GetComponent<Skybox>().material = reflections;
    }

    public void GetPostprocessingVolumes(
      out PostProcessVolume generalPostProcessing,
      out PostProcessVolume colorGrading)
    {
      generalPostProcessing = this.cameraArena.GetComponentInChildren<PostProcessVolume>();
      colorGrading = this.cameraColorGrading.GetComponentInChildren<PostProcessVolume>();
    }
  }
}
