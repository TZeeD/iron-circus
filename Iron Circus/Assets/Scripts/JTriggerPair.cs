// Decompiled with JetBrains decompiler
// Type: JTriggerPair
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Jitter.Dynamics;

public struct JTriggerPair
{
  public JRigidbody body1;
  public JRigidbody body2;

  public JTriggerPair(JRigidbody body1, JRigidbody body2)
  {
    this.body1 = body1;
    this.body2 = body2;
  }
}
