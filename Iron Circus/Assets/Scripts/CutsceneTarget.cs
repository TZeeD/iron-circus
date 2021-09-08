// Decompiled with JetBrains decompiler
// Type: CutsceneTarget
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using SharedWithServer.ScEvents;
using SteelCircus.ScEvents;
using UnityEngine;
using UnityEngine.Serialization;

public class CutsceneTarget : MonoBehaviour
{
  [SerializeField]
  [FormerlySerializedAs("name")]
  private string animationEventName;
  [SerializeField]
  private Imi.SharedWithServer.Game.MatchState cleanupAfterMatchstate;
  private Animation anim;

  private void Start()
  {
    this.anim = this.GetComponent<Animation>();
    Events.Global.OnEventCutscene += new Events.EventCutscene(this.OnCutsceneEventReceived);
    Events.Global.OnEventCutsceneCleanup += new Events.EventCutsceneCleanup(this.OnCutsceneCleanupEventReceived);
  }

  private void OnCutsceneCleanupEventReceived(Imi.SharedWithServer.Game.MatchState matchState)
  {
    if (this.cleanupAfterMatchstate != matchState)
      return;
    string msg = "Cleanup CutsceneObject: " + this.gameObject.name + "\nDeactivating " + (object) this.transform.childCount + " gameObjects.\n";
    for (int index = 0; index < this.transform.childCount; ++index)
    {
      this.transform.GetChild(index).gameObject.SetActive(false);
      msg = msg + "Setting gameObject " + this.transform.GetChild(index).gameObject.name + " inactive.\n";
    }
    Log.Debug(msg);
  }

  private void OnCutsceneEventReceived(CutsceneEventType type, string affectedObject)
  {
    if (!(this.animationEventName == affectedObject))
      return;
    switch (type)
    {
      case CutsceneEventType.Enable:
        for (int index = 0; index < this.transform.childCount; ++index)
          this.transform.GetChild(index).gameObject.SetActive(true);
        break;
      case CutsceneEventType.Disable:
        this.gameObject.SetActive(false);
        break;
      case CutsceneEventType.PlayAnimation:
        this.anim.Play();
        break;
      default:
        Log.Warning("CutsceneEvent with Invalid Type was received.");
        break;
    }
  }

  private void OnDestroy()
  {
    Events.Global.OnEventCutscene -= new Events.EventCutscene(this.OnCutsceneEventReceived);
    Events.Global.OnEventCutsceneCleanup -= new Events.EventCutsceneCleanup(this.OnCutsceneCleanupEventReceived);
  }
}
