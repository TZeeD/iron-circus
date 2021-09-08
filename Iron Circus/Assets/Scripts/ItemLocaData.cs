// Decompiled with JetBrains decompiler
// Type: ItemLocaData
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;

[Serializable]
public class ItemLocaData
{
  public ulong definitionID;
  public string itemName;
  public string locaString;
  public bool changed;
  public bool newlyAdded;
  public string oldLocaString;

  public bool IsNameEqual(ItemLocaData obj) => this.itemName == obj.itemName;

  public bool Equals(ItemLocaData obj) => this.itemName == obj.itemName && (long) this.definitionID == (long) obj.definitionID && this.locaString == obj.locaString;
}
