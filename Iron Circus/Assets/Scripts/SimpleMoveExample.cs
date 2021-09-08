// Decompiled with JetBrains decompiler
// Type: SimpleMoveExample
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

public class SimpleMoveExample : MonoBehaviour
{
  private Vector3 m_previous;
  private Vector3 m_target;
  private Vector3 m_originalPosition;
  public Vector3 BoundingVolume = new Vector3(3f, 1f, 3f);
  public float Speed = 10f;

  private void Start()
  {
    this.m_originalPosition = this.transform.position;
    this.m_previous = this.transform.position;
    this.m_target = this.transform.position;
  }

  private void Update()
  {
    this.transform.position = Vector3.Slerp(this.m_previous, this.m_target, Time.deltaTime * this.Speed);
    this.m_previous = this.transform.position;
    if ((double) Vector3.Distance(this.m_target, this.transform.position) >= 0.100000001490116)
      return;
    this.m_target = this.transform.position + Random.onUnitSphere * Random.Range(0.7f, 4f);
    this.m_target.Set(Mathf.Clamp(this.m_target.x, this.m_originalPosition.x - this.BoundingVolume.x, this.m_originalPosition.x + this.BoundingVolume.x), Mathf.Clamp(this.m_target.y, this.m_originalPosition.y - this.BoundingVolume.y, this.m_originalPosition.y + this.BoundingVolume.y), Mathf.Clamp(this.m_target.z, this.m_originalPosition.z - this.BoundingVolume.z, this.m_originalPosition.z + this.BoundingVolume.z));
  }
}
