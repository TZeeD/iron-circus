// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.SetOwnerObjectVisibilityState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace Imi.SharedWithServer.Game.Skills
{
  public class SetOwnerObjectVisibilityState : SkillState
  {
    public ConfigValue<string> objectTagName;
    public ConfigValue<bool> visibility;
    private bool originalVisibility;
    private GameObject gameObject;

    protected override SkillStateExecutionFlag SkillStateExecutionFlag => SkillStateExecutionFlag.TickRemoteEntities;

    public override SkillStateSyncFlag SkillStateSyncFlag => SkillStateSyncFlag.AlwaysSync;

    protected override void OnBecameActiveThisTick()
    {
      this.GetObject(this.skillGraph.GetOwner(), this.objectTagName.Get());
      if (!((Object) this.gameObject != (Object) null))
        return;
      this.originalVisibility = this.gameObject.activeSelf;
      this.gameObject.SetActive(this.visibility.Get());
    }

    protected override void OnBecameInactiveThisTick()
    {
      if (!((Object) this.gameObject != (Object) null))
        return;
      this.gameObject.SetActive(this.originalVisibility);
      this.gameObject = (GameObject) null;
      this.originalVisibility = false;
    }

    private void GetObject(GameEntity gameObjectOwner, string objectTagName)
    {
      ObjectTag[] componentsInChildren = gameObjectOwner.unityView.gameObject.GetComponentsInChildren<ObjectTag>(true);
      if (componentsInChildren == null)
        return;
      foreach (ObjectTag objectTag in componentsInChildren)
      {
        if (objectTag.Tag == objectTagName)
          this.gameObject = objectTag.gameObject;
      }
    }
  }
}
