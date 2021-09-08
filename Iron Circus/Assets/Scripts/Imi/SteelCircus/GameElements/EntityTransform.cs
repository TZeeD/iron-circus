// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.GameElements.EntityTransform
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SteelCircus.JitterUnity;
using SteelCircus;
using UnityEngine;

namespace Imi.SteelCircus.GameElements
{
  public class EntityTransform : MonoBehaviour, IConvertableToEntitas
  {
    public IComponent ConvertToEntitasComponent() => (IComponent) new TransformComponent()
    {
      position = this.transform.position.ToJVector(),
      rotation = this.transform.rotation.ToJQuaternion()
    };
  }
}
