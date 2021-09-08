// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Utils.InputQuantization
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Jitter.LinearMath;
using System;

namespace Imi.SharedWithServer.Utils
{
  public static class InputQuantization
  {
    public const float Deg2Rad = 0.01745329f;
    public const float Rad2Deg = 57.29578f;

    public static int RoundToInt(float f) => (int) Math.Round((double) f);

    public static JVector RadianToVector2(float radian) => new JVector((float) Math.Cos((double) radian), 0.0f, (float) Math.Sin((double) radian));

    public static JVector DegreeToVector2(float degree) => InputQuantization.RadianToVector2(degree * ((float) Math.PI / 180f));

    public static JVector QuantizeVectorMM(this JVector v) => v;
  }
}
