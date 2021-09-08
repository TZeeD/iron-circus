// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Components.ImiComponent
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using System.Collections.Generic;
using System.Linq;

namespace Imi.SharedWithServer.ScEntitas.Components
{
  public class ImiComponent : IComponent
  {
    private string compName;

    public override string ToString()
    {
      if (this.compName == null)
        this.compName = ((IEnumerable<string>) this.GetType().ToString().Split('.')).Last<string>().Replace("Component", "");
      return this.compName;
    }
  }
}
