// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.FX.ForcefieldMaterialFX
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections;
using UnityEngine;

namespace Imi.SteelCircus.FX
{
  public class ForcefieldMaterialFX : MonoBehaviour
  {
    private MeshRenderer forcefieldRenderer;
    public const float forcefieldFlashDuration = 0.35f;
    public const float forcefieldActivateDuration = 0.75f;
    public const float forcefieldDeactivateDuration = 0.6f;
    [SerializeField]
    private bool reactToPlayers = true;
    private const float playerProximitySlice = 0.2f;
    private const int hitInfoArraySize = 9;
    private Vector4[] hitInfos = new Vector4[9];
    private static readonly int hitInfosID = Shader.PropertyToID("_HitInfos");
    private static readonly int activationTimeID = Shader.PropertyToID("_ActivationTime");
    private Material clonedMaterial;

    private void Awake()
    {
      this.forcefieldRenderer = this.GetComponent<MeshRenderer>();
      this.clonedMaterial = Object.Instantiate<Material>(this.forcefieldRenderer.material);
      this.forcefieldRenderer.material = this.clonedMaterial;
      this.Reset();
    }

    public void Reset() => this.ClearHitInfos();

    private void ClearHitInfos()
    {
      for (int index = 0; index < 9; ++index)
        this.hitInfos[index] = new Vector4(0.0f, 0.0f, 0.0f, -1f);
    }

    private void Update()
    {
      this.clonedMaterial.SetVectorArray(ForcefieldMaterialFX.hitInfosID, this.hitInfos);
      for (int index = 0; index < 9; ++index)
      {
        Vector4 hitInfo = this.hitInfos[index];
        if ((double) hitInfo.w >= 1.0)
          hitInfo.w = -1f;
        else if ((double) hitInfo.w != -1.0)
          hitInfo.w = Mathf.Min(hitInfo.w + Time.deltaTime / 0.35f, 1f);
        this.hitInfos[index] = hitInfo;
      }
    }

    public void Activate()
    {
      this.StopAllCoroutines();
      this.StartCoroutine(this.ActivateCR());
    }

    private IEnumerator ActivateCR()
    {
      float cTime = 0.0f;
      while ((double) cTime < 1.0)
      {
        cTime = Mathf.Clamp01(cTime + Time.deltaTime / 0.75f);
        this.clonedMaterial.SetFloat(ForcefieldMaterialFX.activationTimeID, cTime);
        yield return (object) null;
      }
    }

    public void Deactivate()
    {
      this.StopAllCoroutines();
      this.StartCoroutine(this.DeactivateCR());
    }

    private IEnumerator DeactivateCR()
    {
      float cTime = 0.0f;
      while ((double) cTime < 1.0)
      {
        cTime = Mathf.Clamp01(cTime + Time.deltaTime / 0.6f);
        this.clonedMaterial.SetFloat(ForcefieldMaterialFX.activationTimeID, cTime + 1f);
        yield return (object) null;
      }
    }

    public void UpdatePlayer(Vector3 pos, int playerIndex)
    {
      if (!this.reactToPlayers)
        return;
      Vector4 hitInfo = this.hitInfos[playerIndex];
      hitInfo.x = pos.x;
      hitInfo.y = pos.y;
      hitInfo.z = pos.z;
      hitInfo.w = 0.2f;
      this.hitInfos[playerIndex] = hitInfo;
    }

    public void StartFlash(Vector3 pos)
    {
      int index = 8;
      Vector4 hitInfo = this.hitInfos[index];
      hitInfo.x = pos.x;
      hitInfo.y = pos.y;
      hitInfo.z = pos.z;
      hitInfo.w = 0.0f;
      this.hitInfos[index] = hitInfo;
    }
  }
}
