// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Utils.Extensions.MonoBehaviourExtensions
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace Imi.SteelCircus.Utils.Extensions
{
  public static class MonoBehaviourExtensions
  {
    public static T GetOrAddComponent<T>(this Component child) where T : Component
    {
      T obj = child.GetComponent<T>();
      if ((Object) obj == (Object) null)
        obj = child.gameObject.AddComponent<T>();
      return obj;
    }
  }
}
