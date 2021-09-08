// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Utilities.EnumInfo
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

namespace Newtonsoft.Json.Utilities
{
  internal class EnumInfo
  {
    public readonly bool IsFlags;
    public readonly ulong[] Values;
    public readonly string[] Names;
    public readonly string[] ResolvedNames;

    public EnumInfo(bool isFlags, ulong[] values, string[] names, string[] resolvedNames)
    {
      this.IsFlags = isFlags;
      this.Values = values;
      this.Names = names;
      this.ResolvedNames = resolvedNames;
    }
  }
}
