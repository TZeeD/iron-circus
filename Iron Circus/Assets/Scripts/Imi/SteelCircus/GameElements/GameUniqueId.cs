// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.GameElements.GameUniqueId
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.SharedWithServer.Game;
using Imi.Utils.Common;
using server.ScEntitas.Components;
using SteelCircus;
using UnityEngine;

namespace Imi.SteelCircus.GameElements
{
  public class GameUniqueId : MonoBehaviour, IConvertableToEntitas
  {
    [SerializeField]
    [Readonly]
    private int uniqueId;

    public int GetId() => this.uniqueId;

    public IComponent ConvertToEntitasComponent() => (IComponent) new UniqueIdComponent()
    {
      id = new UniqueId((ushort) this.uniqueId)
    };
  }
}
