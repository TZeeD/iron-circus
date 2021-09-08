// Decompiled with JetBrains decompiler
// Type: ShopRotationData
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SteelCircus.Core.Services;
using System;
using System.Diagnostics;

[Serializable]
public class ShopRotationData
{
  public ShopItem item;
  public long countdownInMs;
  public Stopwatch countdownTimer;

  public ShopRotationData(ItemDefinition item, long countdownInMs)
  {
    this.item = ImiServices.Instance.progressManager.GetItemByDefinitionId(item.definitionId);
    this.countdownInMs = countdownInMs;
    this.countdownTimer = new Stopwatch();
    this.countdownTimer.Start();
  }
}
