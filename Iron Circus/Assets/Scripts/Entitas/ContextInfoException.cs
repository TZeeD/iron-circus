// Decompiled with JetBrains decompiler
// Type: Entitas.ContextInfoException
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

namespace Entitas
{
  public class ContextInfoException : EntitasException
  {
    public ContextInfoException(IContext context, ContextInfo contextInfo)
      : base("Invalid ContextInfo for '" + (object) context + "'!\nExpected " + (object) context.totalComponents + " componentName(s) but got " + (object) contextInfo.componentNames.Length + ":", string.Join("\n", contextInfo.componentNames))
    {
    }
  }
}
