// Decompiled with JetBrains decompiler
// Type: SteelCircus.GameElements.DeactivateableForcefield
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Entitas.Unity;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SteelCircus.FX;
using Imi.SteelCircus.GameElements;
using Imi.SteelCircus.GameElements.Skills;
using System.Collections;
using System.Linq;
using UnityEngine;

namespace SteelCircus.GameElements
{
  [RequireComponent(typeof (GamePhysicsCollider), typeof (GameUniqueId))]
  public class DeactivateableForcefield : MonoBehaviour, IConvertableToEntitas
  {
    public bool deactivateDuringPoint = true;
    private ForcefieldMaterialFX[] forcefields;

    public void Awake()
    {
      this.forcefields = this.GetComponentsInChildren<ForcefieldMaterialFX>(true);
      int id = this.GetComponent<GameUniqueId>().GetId();
      GameContext game = Contexts.sharedInstance.game;
      GameEntity gameEntity = game.GetEntitiesWithUniqueId(new UniqueId((ushort) id)).FirstOrDefault<GameEntity>();
      this.gameObject.Link((IEntity) gameEntity, (IContext) game);
      gameEntity.AddUnityView(this.gameObject);
      if (!this.deactivateDuringPoint)
        return;
      this.gameObject.SetActive(false);
    }

    private void OnDestroy()
    {
      if (!((Object) this.gameObject.GetEntityLink() != (Object) null) || this.gameObject.GetEntityLink().entity == null)
        return;
      this.gameObject.Unlink();
    }

    public IComponent ConvertToEntitasComponent() => (IComponent) new ForcefieldComponent()
    {
      deactivateDuringPoint = this.deactivateDuringPoint
    };

    public void Activate()
    {
      this.StopAllCoroutines();
      this.gameObject.SetActive(true);
      foreach (ForcefieldMaterialFX forcefield in this.forcefields)
        forcefield.Activate();
    }

    public void Deactivate()
    {
      this.StopAllCoroutines();
      this.StartCoroutine(this.DeactivateCR());
    }

    private IEnumerator DeactivateCR()
    {
      DeactivateableForcefield deactivateableForcefield = this;
      foreach (ForcefieldMaterialFX forcefield in deactivateableForcefield.forcefields)
        forcefield.Deactivate();
      yield return (object) new WaitForSeconds(0.6f);
      deactivateableForcefield.gameObject.SetActive(false);
    }
  }
}
