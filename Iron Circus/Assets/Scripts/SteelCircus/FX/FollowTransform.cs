// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.FollowTransform
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace SteelCircus.FX
{
  public class FollowTransform : MonoBehaviour
  {
    [SerializeField]
    protected Transform target;
    [SerializeField]
    protected Vector3 rotation;
    [SerializeField]
    protected Vector3 offset;

    public virtual Transform Target
    {
      get => this.target;
      set => this.target = value;
    }

    protected virtual void Start() => this.Update();

    protected virtual void Update()
    {
      if ((Object) this.target == (Object) null)
        return;
      this.transform.position = (this.target.localToWorldMatrix * Matrix4x4.Rotate(Quaternion.Euler(this.rotation))).MultiplyPoint(this.offset);
    }
  }
}
