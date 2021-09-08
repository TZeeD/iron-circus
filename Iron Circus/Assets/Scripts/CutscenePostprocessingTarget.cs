// Decompiled with JetBrains decompiler
// Type: CutscenePostprocessingTarget
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using SharedWithServer.ScEvents;
using SteelCircus.ScEvents;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;
using UnityEngine.Serialization;

public class CutscenePostprocessingTarget : MonoBehaviour
{
  [SerializeField]
  [FormerlySerializedAs("name")]
  private string animationEventName;
  [SerializeField]
  private PostProcessProfile profileOverrides;
  private PostProcessVolume postProcessVolume;

  private void Awake()
  {
    Events.Global.OnEventCutscene += new Events.EventCutscene(this.OnCutsceneEventReceived);
    this.postProcessVolume = this.GetComponentInChildren<PostProcessVolume>();
  }

  private void OnCutsceneEventReceived(CutsceneEventType type, string affectedObject)
  {
    if (type != CutsceneEventType.Postprocessing || !(this.animationEventName == affectedObject))
      return;
    if ((Object) this.postProcessVolume != (Object) null && (Object) this.profileOverrides != (Object) null)
      this.postProcessVolume.profile = this.profileOverrides;
    else
      Log.Error("CutscenePostprocessingTarget had no volume or override set.");
  }

  private void OnDestroy() => Events.Global.OnEventCutscene += new Events.EventCutscene(this.OnCutsceneEventReceived);
}
