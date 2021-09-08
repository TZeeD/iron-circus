// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Serialization.NamingStrategy
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

namespace Newtonsoft.Json.Serialization
{
  public abstract class NamingStrategy
  {
    public bool ProcessDictionaryKeys { get; set; }

    public bool ProcessExtensionDataNames { get; set; }

    public bool OverrideSpecifiedNames { get; set; }

    public virtual string GetPropertyName(string name, bool hasSpecifiedName) => hasSpecifiedName && !this.OverrideSpecifiedNames ? name : this.ResolvePropertyName(name);

    public virtual string GetExtensionDataName(string name) => !this.ProcessExtensionDataNames ? name : this.ResolvePropertyName(name);

    public virtual string GetDictionaryKey(string key) => !this.ProcessDictionaryKeys ? key : this.ResolvePropertyName(key);

    protected abstract string ResolvePropertyName(string name);
  }
}
