// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Audio.AudioButtonStart
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.EventSystems;

namespace Imi.SteelCircus.Audio
{
  public class AudioButtonStart : MonoBehaviour, ISelectHandler, IEventSystemHandler, ISubmitHandler
  {
    public string select = "MenuSelect2";
    public string submit = "MenuConfirm";
    private bool ignoreFirstTime = true;

    public void OnSelect(BaseEventData eventData)
    {
      if (this.ignoreFirstTime)
        this.ignoreFirstTime = false;
      else
        AudioManager.Instance.PlaySfx2D(this.select);
    }

    public void OnSubmit(BaseEventData eventData) => AudioManager.Instance.PlaySfx2D(this.submit);
  }
}
