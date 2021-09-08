// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.ScEntitas.Systems.ViewSystems.UnityViewTeardownSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Entitas.Unity;
using Imi.SharedWithServer.ScEntitas;
using Imi.SharedWithServer.ScEntitas.Systems;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace Imi.SteelCircus.ScEntitas.Systems.ViewSystems
{
  public class UnityViewTeardownSystem : GameSystem, ITearDownSystem, ISystem
  {
    public UnityViewTeardownSystem(EntitasSetup entitasSetup)
      : base(entitasSetup)
    {
    }

    public void TearDown()
    {
      foreach (GameEntity gameEntity in ((IEnumerable<GameEntity>) this.gameContext.GetGroup(GameMatcher.UnityView).GetEntities()).ToArray<GameEntity>())
      {
        gameEntity.unityView.gameObject.Unlink();
        Object.Destroy((Object) gameEntity.unityView.gameObject);
        gameEntity.RemoveUnityView();
      }
    }
  }
}
