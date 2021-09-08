// Decompiled with JetBrains decompiler
// Type: Entitas.ContextEntityIndexDoesAlreadyExistException
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

namespace Entitas
{
  public class ContextEntityIndexDoesAlreadyExistException : EntitasException
  {
    public ContextEntityIndexDoesAlreadyExistException(IContext context, string name)
      : base("Cannot add EntityIndex '" + name + "' to context '" + (object) context + "'!", "An EntityIndex with this name has already been added.")
    {
    }
  }
}
