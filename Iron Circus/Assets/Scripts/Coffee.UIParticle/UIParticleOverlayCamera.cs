// Decompiled with JetBrains decompiler
// Type: Coffee.UIExtensions.UIParticleOverlayCamera
// Assembly: Coffee.UIParticle, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: E570C018-62C0-4C27-95AB-D31B1CC6DDB6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Coffee.UIParticle.dll

using System;
using UnityEngine;

namespace Coffee.UIExtensions
{
  [ExecuteInEditMode]
  public class UIParticleOverlayCamera : MonoBehaviour
  {
    private Camera m_Camera;
    private static UIParticleOverlayCamera s_Instance;

    public static UIParticleOverlayCamera instance
    {
      get
      {
        if (UIParticleOverlayCamera.s_Instance == null)
        {
          UIParticleOverlayCamera particleOverlayCamera = UnityEngine.Object.FindObjectOfType<UIParticleOverlayCamera>();
          if (particleOverlayCamera == null)
            particleOverlayCamera = new GameObject(typeof (UIParticleOverlayCamera).Name, new Type[1]
            {
              typeof (UIParticleOverlayCamera)
            }).GetComponent<UIParticleOverlayCamera>();
          UIParticleOverlayCamera.s_Instance = particleOverlayCamera;
          UIParticleOverlayCamera.s_Instance.gameObject.SetActive(true);
          UIParticleOverlayCamera.s_Instance.enabled = true;
        }
        return UIParticleOverlayCamera.s_Instance;
      }
    }

    public static Camera GetCameraForOvrelay(Canvas canvas)
    {
      UIParticleOverlayCamera instance = UIParticleOverlayCamera.instance;
      RectTransform transform1 = canvas.rootCanvas.transform as RectTransform;
      Camera cameraForOvrelay = instance.cameraForOvrelay;
      Transform transform2 = instance.transform;
      cameraForOvrelay.enabled = false;
      Vector3 localPosition = transform1.localPosition;
      cameraForOvrelay.orthographic = true;
      cameraForOvrelay.orthographicSize = Mathf.Max(localPosition.x, localPosition.y);
      cameraForOvrelay.nearClipPlane = 0.3f;
      cameraForOvrelay.farClipPlane = 1000f;
      localPosition.z -= 100f;
      Vector3 vector3 = localPosition;
      transform2.localPosition = vector3;
      return cameraForOvrelay;
    }

    private Camera cameraForOvrelay => !(bool) (UnityEngine.Object) this.m_Camera && !(bool) (UnityEngine.Object) (this.m_Camera = this.GetComponent<Camera>()) ? (this.m_Camera = this.gameObject.AddComponent<Camera>()) : this.m_Camera;

    private void Awake()
    {
      if ((UnityEngine.Object) UIParticleOverlayCamera.s_Instance == (UnityEngine.Object) null)
        UIParticleOverlayCamera.s_Instance = this.GetComponent<UIParticleOverlayCamera>();
      else if ((UnityEngine.Object) UIParticleOverlayCamera.s_Instance != (UnityEngine.Object) this)
      {
        Debug.LogWarning((object) ("Multiple " + typeof (UIParticleOverlayCamera).Name + " in scene."), (UnityEngine.Object) this.gameObject);
        this.enabled = false;
        UnityEngine.Object.Destroy((UnityEngine.Object) this.gameObject);
        return;
      }
      this.cameraForOvrelay.enabled = false;
      if (!Application.isPlaying)
        return;
      UnityEngine.Object.DontDestroyOnLoad((UnityEngine.Object) this.gameObject);
    }

    private void OnDestroy()
    {
      if (!((UnityEngine.Object) UIParticleOverlayCamera.s_Instance == (UnityEngine.Object) this))
        return;
      UIParticleOverlayCamera.s_Instance = (UIParticleOverlayCamera) null;
    }
  }
}
