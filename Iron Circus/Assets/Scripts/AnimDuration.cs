﻿// Decompiled with JetBrains decompiler
// Type: AnimDuration
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;

[Serializable]
public struct AnimDuration
{
  public float duration;

  public static implicit operator float(AnimDuration animDuration) => animDuration.duration;
}
