// Decompiled with JetBrains decompiler
// Type: CutsceneBase
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using SharedWithServer.ScEvents;
using SteelCircus.ScEvents;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

public abstract class CutsceneBase : MonoBehaviour
{
  [SerializeField]
  private Imi.SharedWithServer.Game.MatchState cutsceneType;
  protected Events events;
  protected PostProcessVolume postProcessVolume;
  protected PostProcessProfile OriginalProfile;
  [SerializeField]
  protected PostProcessProfile CutsceneProfile;

  protected virtual void OnEnable()
  {
    this.events = Events.Global;
    this.postProcessVolume = this.gameObject.GetComponentInChildren<PostProcessVolume>();
    if (!((Object) this.CutsceneProfile != (Object) null))
      return;
    this.postProcessVolume.profile = this.CutsceneProfile;
  }

  protected void OnDisable()
  {
    if (!Contexts.sharedInstance.game.hasMatchState || Contexts.sharedInstance.game.matchState.value == Imi.SharedWithServer.Game.MatchState.WaitingForPlayers)
      return;
    Log.Debug(string.Format("Cleaning up Cutscene: {0}. {1} at {2}", (object) this.cutsceneType, (object) this.gameObject.name, (object) Contexts.sharedInstance.game.matchState.value));
    this.events.FireEventCutsceneCleanup(this.cutsceneType);
  }

  public void DisableObject(string name) => this.events.FireEventCutscene(CutsceneEventType.Disable, name);

  public void EnableObject(string name) => this.events.FireEventCutscene(CutsceneEventType.Enable, name);

  public void StartAnimation(string name) => this.events.FireEventCutscene(CutsceneEventType.PlayAnimation, name);

  public void ChangePostprocessing(string name) => this.events.FireEventCutscene(CutsceneEventType.Postprocessing, name);
}
