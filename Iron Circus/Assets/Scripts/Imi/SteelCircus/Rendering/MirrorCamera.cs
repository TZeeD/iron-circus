// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Rendering.MirrorCamera
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SteelCircus.Core;
using SteelCircus.Core.Services;
using UnityEngine;

namespace Imi.SteelCircus.Rendering
{
  public class MirrorCamera : MonoBehaviour
  {
    private Camera cam;
    public float clipPlaneOffset = 0.07f;
    public float resolutionScale = 1f;
    private float lastResolutionScale = -1f;
    private int lastScreenWidth;
    private int lastScreenHeight;
    private RenderTexture resultRT;
    public string rtGlobalShaderPropertyName = "_MirrorCamTex";
    public bool applyBlur = true;
    public float minBlurDepth = 0.29f;
    public float maxBlurDepth = 0.45f;
    public float maxBlur = 4f;
    private Material blurMaterial;
    private ShadowQuality prevShadowSettings;

    public RenderTexture ResultRt => this.resultRT;

    private void Awake()
    {
      this.cam = this.GetComponent<Camera>();
      this.RecreateRenderTexture();
    }

    private void OnEnable() => this.RecreateRenderTexture();

    private void OnDisable()
    {
      this.cam.targetTexture = (RenderTexture) null;
      this.resultRT.Release();
      this.resultRT = (RenderTexture) null;
    }

    private void RecreateRenderTexture()
    {
      Shader shader;
      if (ImiServices.Instance.QualityManager.CurrentRenderSettings.miscSettings > QualityManager.Level.Low)
      {
        this.cam.depthTextureMode = DepthTextureMode.Depth;
        shader = Shader.Find("Hidden/BlurPass");
      }
      else
        shader = Shader.Find("Hidden/BlurPassLowSpec");
      this.blurMaterial = new Material(shader);
      if ((Object) this.resultRT != (Object) null)
        this.resultRT.Release();
      this.resultRT = new RenderTexture(Mathf.RoundToInt((float) Screen.width * this.resolutionScale), Mathf.RoundToInt((float) Screen.height * this.resolutionScale), 16, RenderTextureFormat.ARGB32);
      this.resultRT.useMipMap = false;
      this.resultRT.Create();
      this.cam.targetTexture = this.resultRT;
      Shader.SetGlobalTexture(this.rtGlobalShaderPropertyName, (Texture) this.resultRT);
    }

    private void Update()
    {
      int width = Screen.width;
      int height = Screen.height;
      if (this.lastScreenWidth != width || this.lastScreenHeight != height || (double) this.lastResolutionScale != (double) this.resolutionScale)
        this.RecreateRenderTexture();
      this.lastResolutionScale = this.resolutionScale;
      this.lastScreenWidth = width;
      this.lastScreenHeight = height;
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
      if (!this.applyBlur)
      {
        Graphics.Blit((Texture) source, destination);
      }
      else
      {
        this.blurMaterial.SetFloat("_MinDepth", this.minBlurDepth);
        this.blurMaterial.SetFloat("_MaxDepth", this.maxBlurDepth);
        this.blurMaterial.SetVector("_Offsets", new Vector4(this.maxBlur * 2f / (float) Screen.width, 0.0f, 0.0f, 0.0f));
        Graphics.Blit((Texture) source, destination, this.blurMaterial);
        this.blurMaterial.SetVector("_Offsets", new Vector4(0.0f, this.maxBlur * 2f / (float) Screen.height, 0.0f, 0.0f));
        Graphics.Blit((Texture) destination, source, this.blurMaterial);
        this.blurMaterial.SetVector("_Offsets", new Vector4(this.maxBlur * 4f / (float) Screen.width, 0.0f, 0.0f, 0.0f));
        Graphics.Blit((Texture) source, destination, this.blurMaterial);
        this.blurMaterial.SetVector("_Offsets", new Vector4(0.0f, this.maxBlur * 4f / (float) Screen.height, 0.0f, 0.0f));
        Graphics.Blit((Texture) destination, source, this.blurMaterial);
        Graphics.Blit((Texture) source, destination);
      }
    }

    private void OnPreCull()
    {
      this.cam.ResetWorldToCameraMatrix();
      this.cam.ResetProjectionMatrix();
      this.cam.transform.localPosition = Vector3.zero;
      this.cam.transform.localRotation = Quaternion.identity;
      Vector3 zero1 = Vector3.zero;
      Vector3 vector3_1 = -Vector3.up;
      float w = -Vector3.Dot(vector3_1, zero1) - this.clipPlaneOffset;
      Vector4 plane = new Vector4(vector3_1.x, vector3_1.y, vector3_1.z, w);
      Matrix4x4 zero2 = Matrix4x4.zero;
      MirrorCamera.CalculateReflectionMatrix(ref zero2, plane);
      Vector3 position = this.cam.transform.parent.position;
      Vector3 vector3_2 = zero2.MultiplyPoint(position);
      Vector4 clipPlane = this.CameraSpacePlane(this.cam, zero1, vector3_1, 1f);
      this.cam.worldToCameraMatrix *= zero2;
      Matrix4x4 projectionMatrix = this.cam.projectionMatrix;
      MirrorCamera.CalculateObliqueMatrix(ref projectionMatrix, clipPlane);
      this.cam.projectionMatrix = projectionMatrix;
      this.cam.transform.position = vector3_2;
      Vector3 eulerAngles = this.cam.transform.parent.eulerAngles;
      this.cam.transform.eulerAngles = new Vector3(0.0f, eulerAngles.y, eulerAngles.z);
    }

    private void OnPreRender()
    {
      GL.invertCulling = true;
      this.prevShadowSettings = QualitySettings.shadows;
      QualitySettings.shadows = ShadowQuality.Disable;
    }

    private void OnPostRender()
    {
      GL.invertCulling = false;
      QualitySettings.shadows = this.prevShadowSettings;
    }

    private Vector4 CameraSpacePlane(
      Camera cam,
      Vector3 pos,
      Vector3 normal,
      float sideSign)
    {
      Vector3 point = pos + normal * this.clipPlaneOffset;
      Matrix4x4 worldToCameraMatrix = cam.worldToCameraMatrix;
      Vector3 lhs = worldToCameraMatrix.MultiplyPoint(point);
      Vector3 rhs = worldToCameraMatrix.MultiplyVector(normal).normalized * sideSign;
      return new Vector4(rhs.x, rhs.y, rhs.z, -Vector3.Dot(lhs, rhs));
    }

    private static void CalculateObliqueMatrix(ref Matrix4x4 projection, Vector4 clipPlane)
    {
      Vector4 b = projection.inverse * new Vector4(Mathf.Sign(clipPlane.x), Mathf.Sign(clipPlane.y), 1f, 1f);
      Vector4 vector4 = clipPlane * (2f / Vector4.Dot(clipPlane, b));
      projection[2] = vector4.x - projection[3];
      projection[6] = vector4.y - projection[7];
      projection[10] = vector4.z - projection[11];
      projection[14] = vector4.w - projection[15];
    }

    private static void CalculateReflectionMatrix(ref Matrix4x4 reflectionMat, Vector4 plane)
    {
      reflectionMat.m00 = (float) (1.0 - 2.0 * (double) plane[0] * (double) plane[0]);
      reflectionMat.m01 = -2f * plane[0] * plane[1];
      reflectionMat.m02 = -2f * plane[0] * plane[2];
      reflectionMat.m03 = -2f * plane[3] * plane[0];
      reflectionMat.m10 = -2f * plane[1] * plane[0];
      reflectionMat.m11 = (float) (1.0 - 2.0 * (double) plane[1] * (double) plane[1]);
      reflectionMat.m12 = -2f * plane[1] * plane[2];
      reflectionMat.m13 = -2f * plane[3] * plane[1];
      reflectionMat.m20 = -2f * plane[2] * plane[0];
      reflectionMat.m21 = -2f * plane[2] * plane[1];
      reflectionMat.m22 = (float) (1.0 - 2.0 * (double) plane[2] * (double) plane[2]);
      reflectionMat.m23 = -2f * plane[3] * plane[2];
      reflectionMat.m30 = 0.0f;
      reflectionMat.m31 = 0.0f;
      reflectionMat.m32 = 0.0f;
      reflectionMat.m33 = 1f;
    }
  }
}
