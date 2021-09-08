// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Rendering.FloorRenderer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.Utils.Extensions;
using UnityEngine;

namespace Imi.SteelCircus.Rendering
{
  public class FloorRenderer : MonoBehaviour
  {
    [SerializeField]
    private Camera cameraEmissive;
    [SerializeField]
    private Camera cameraNormals;
    [SerializeField]
    private Transform parentEmissive;
    [SerializeField]
    private Transform parentNormals;
    [SerializeField]
    private Canvas floorCanvas;

    private void Awake() => this.transform.localEulerAngles = Vector3.zero;

    public void Setup(Material floorMaterial, float fieldSizeX, float fieldSizeZ)
    {
      this.SetupCamera(this.cameraEmissive, (RenderTexture) floorMaterial.mainTexture, fieldSizeX, fieldSizeZ);
      this.SetupCamera(this.cameraNormals, (RenderTexture) floorMaterial.GetTexture("_BumpMap"), fieldSizeX, fieldSizeZ);
    }

    private void SetupCamera(
      Camera cam,
      RenderTexture renderTexture,
      float fieldSizeX,
      float fieldSizeZ)
    {
      cam.targetTexture = renderTexture;
      float num = (float) renderTexture.width / (float) renderTexture.height;
      if ((double) fieldSizeX / (double) fieldSizeZ > (double) num)
        cam.orthographicSize = fieldSizeX * 0.5f / num;
      else
        cam.orthographicSize = fieldSizeZ * 0.5f;
    }

    public void AddToLayer(Transform t, FloorRenderer.FloorLayer layer)
    {
      if (layer != FloorRenderer.FloorLayer.Emissive)
      {
        if (layer != FloorRenderer.FloorLayer.Normals)
          return;
        this.AddNormals(t);
      }
      else
        this.AddEmissive(t);
    }

    public void AddEmissive(Transform t)
    {
      t.ReparentAndKeepLocalSpace(this.parentEmissive);
      t.gameObject.SetLayer(Layer.FloorEmissive);
    }

    public void AddNormals(Transform t)
    {
      t.ReparentAndKeepLocalSpace(this.parentNormals);
      t.gameObject.SetLayer(Layer.FloorNormals);
    }

    public Canvas GetCanvas() => this.floorCanvas;

    public enum FloorLayer
    {
      Emissive,
      Normals,
    }
  }
}
