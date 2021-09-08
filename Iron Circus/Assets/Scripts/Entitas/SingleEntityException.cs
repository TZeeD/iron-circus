// Decompiled with JetBrains decompiler
// Type: Entitas.SingleEntityException
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

namespace Entitas
{
  public class SingleEntityException : EntitasException
  {
    public SingleEntityException(int count)
      : base("Expected exactly one entity in collection but found " + (object) count + "!", "Use collection.SingleEntity() only when you are sure that there is exactly one entity.")
    {
    }
  }
}
