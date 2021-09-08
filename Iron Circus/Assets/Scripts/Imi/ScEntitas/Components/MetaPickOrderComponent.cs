// Decompiled with JetBrains decompiler
// Type: Imi.ScEntitas.Components.MetaPickOrderComponent
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas.CodeGeneration.Attributes;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas.Components;

namespace Imi.ScEntitas.Components
{
  [Meta]
  [Unique]
  public class MetaPickOrderComponent : ImiComponent
  {
    public int currentPickerIndex;
    public int[,] playerPickTimings;
    public UniqueId[] alphaPickOrder;
    public UniqueId[] betaPickOrder;
  }
}
