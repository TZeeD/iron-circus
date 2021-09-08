// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.KennyFlameSettings
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using UnityEngine;
using UnityEngine.Serialization;

namespace SteelCircus.FX
{
  [CreateAssetMenu(fileName = "KennyFlameSettings", menuName = "SteelCircus/Configs/Kenny Flame Settings")]
  public class KennyFlameSettings : ScriptableObject
  {
    public KennyFlameSettings.FlameDescription[] flames;

    [Serializable]
    public class FlameDescription
    {
      public string parentBoneName;
      [FormerlySerializedAs("controller")]
      public KennyFlameAnimationCurve animationCurve;
      public Vector3 localPos = Vector3.zero;
      public Vector3 localEuler = Vector3.zero;
      public Vector3 localScale = Vector3.one;
    }
  }
}
