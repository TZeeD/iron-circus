// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Rendering.Floor
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.ScriptableObjects;
using Imi.SteelCircus.ui.Floor;
using SteelCircus.Core;
using UnityEngine;

namespace Imi.SteelCircus.Rendering
{
  public class Floor : MonoBehaviour
  {
    [SerializeField]
    private FloorLitMaterialConfig floorLitMaterialConfig;
    public GameObject floorContentsPrefab;
    private Vector3 center;
    private Vector3 size;
    private Material material;
    private FloorStateManager floorContents;
    private FloorRenderer floorRenderer;

    public Vector3 Center => this.center;

    public Vector3 Size => this.size;

    public Material Material => this.material;

    public FloorStateManager FloorContents => this.floorContents;

    public FloorRenderer FloorRenderer => this.floorRenderer;

    private void Awake()
    {
      this.UpdateMaterialTransform();
      this.SetupContents();
      this.SetGlobalShaderVars();
      MatchObjectsParent.RegisterFloor(this);
    }

    private void OnDestroy()
    {
      MatchObjectsParent.UnregisterFloor();
      if (!((Object) this.floorContents != (Object) null))
        return;
      Object.Destroy((Object) this.floorContents.gameObject);
    }

    private void SetGlobalShaderVars()
    {
      this.floorLitMaterialConfig.SetGlobalShaderProps();
      Vector4 vector4 = new Vector4(this.Center.x, this.Center.z, this.Size.x, this.Size.y);
      Texture mainTexture = this.material.mainTexture;
      Vector2 mainTextureScale = this.material.mainTextureScale;
      Vector2 mainTextureOffset = this.material.mainTextureOffset;
      Shader.SetGlobalVector("_FloorDim", vector4);
      Shader.SetGlobalTexture("_FloorTex", mainTexture);
      Shader.SetGlobalVector("_FloorTex_ST", new Vector4(mainTextureScale.x, mainTextureScale.y, mainTextureOffset.x, mainTextureOffset.y));
    }

    public void SetupFields()
    {
      this.material = this.GetComponent<Renderer>().sharedMaterial;
      this.center = this.transform.position;
      this.size = this.transform.lossyScale;
    }

    public void SetupContents()
    {
      GameObject gameObject = MatchObjectsParent.Add(Object.Instantiate<GameObject>(this.floorContentsPrefab));
      this.floorContents = gameObject.GetComponent<FloorStateManager>();
      this.floorRenderer = gameObject.GetComponent<FloorRenderer>();
      this.FloorRenderer.Setup(this.material, this.size.x, this.size.y);
    }

    public void GetMaterialProperties(
      out Vector2 mainTextureScale,
      out Vector2 mainTextureOffset,
      out Vector4 uvParams)
    {
      Texture mainTexture = this.Material.mainTexture;
      float num1 = (float) mainTexture.width / (float) mainTexture.height;
      double num2 = (double) this.size.x / (double) this.size.y;
      Vector2 one = Vector2.one;
      Vector2 zero = Vector2.zero;
      double num3 = (double) num1;
      if (num2 > num3)
      {
        one.y = this.size.y * num1 / this.size.x;
        zero.y = (float) ((1.0 - (double) one.y) / 2.0);
      }
      else
      {
        one.x = this.size.x / num1 / this.size.y;
        zero.x = (float) ((1.0 - (double) one.x) / 2.0);
      }
      uvParams = new Vector4(one.x / this.size.x, one.y / this.size.y, one.x, one.y);
      mainTextureScale = one;
      mainTextureOffset = zero;
    }

    public void UpdateMaterialTransform()
    {
      this.SetupFields();
      Vector2 mainTextureScale;
      Vector2 mainTextureOffset;
      Vector4 uvParams;
      this.GetMaterialProperties(out mainTextureScale, out mainTextureOffset, out uvParams);
      this.material.mainTextureOffset = mainTextureOffset;
      this.material.mainTextureScale = mainTextureScale;
      this.material.SetVector("_UVParams", uvParams);
    }
  }
}
