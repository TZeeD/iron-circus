// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Utilities.TypeNameKey
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using System;

namespace Newtonsoft.Json.Utilities
{
  internal readonly struct TypeNameKey : IEquatable<TypeNameKey>
  {
    internal readonly string AssemblyName;
    internal readonly string TypeName;

    public TypeNameKey(string assemblyName, string typeName)
    {
      this.AssemblyName = assemblyName;
      this.TypeName = typeName;
    }

    public override int GetHashCode()
    {
      string assemblyName = this.AssemblyName;
      int num1 = assemblyName != null ? assemblyName.GetHashCode() : 0;
      string typeName = this.TypeName;
      int num2 = typeName != null ? typeName.GetHashCode() : 0;
      return num1 ^ num2;
    }

    public override bool Equals(object obj) => obj is TypeNameKey other && this.Equals(other);

    public bool Equals(TypeNameKey other) => this.AssemblyName == other.AssemblyName && this.TypeName == other.TypeName;
  }
}
