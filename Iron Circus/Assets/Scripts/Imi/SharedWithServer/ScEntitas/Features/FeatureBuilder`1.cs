// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Features.FeatureBuilder`1
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;

namespace Imi.SharedWithServer.ScEntitas.Features
{
  public abstract class FeatureBuilder<T> where T : Systems, new()
  {
    protected T feature = new T();

    public abstract T Create();

    protected void AddIfNotNull(ISystem system)
    {
      if (system == null)
        return;
      this.feature.Add(system);
    }
  }
}
