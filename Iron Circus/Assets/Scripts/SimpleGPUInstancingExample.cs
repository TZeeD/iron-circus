// Decompiled with JetBrains decompiler
// Type: SimpleGPUInstancingExample
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

public class SimpleGPUInstancingExample : MonoBehaviour
{
  public Transform Prefab;
  public Material InstancedMaterial;

  private void Awake()
  {
    this.InstancedMaterial.enableInstancing = true;
    float max = 4f;
    for (int index = 0; index < 1000; ++index)
    {
      Transform transform = Object.Instantiate<Transform>(this.Prefab, new Vector3(Random.Range(-max, max), max + Random.Range(-max, max), Random.Range(-max, max)), Quaternion.identity);
      MaterialPropertyBlock properties = new MaterialPropertyBlock();
      Color color = new Color(Random.Range(0.0f, 1f), Random.Range(0.0f, 1f), Random.Range(0.0f, 1f));
      properties.SetColor("_Color", color);
      transform.GetComponent<MeshRenderer>().SetPropertyBlock(properties);
    }
  }
}
