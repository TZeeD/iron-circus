// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.TwitchViewerCountUpdater
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SteelCircus.Core.Services;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI
{
  public class TwitchViewerCountUpdater : MonoBehaviour
  {
    [SerializeField]
    private GameObject viewerCountParentObject;
    [SerializeField]
    private TextMeshProUGUI viewerCountText;
    public ulong playerId;
    [SerializeField]
    private GameObject layoutElement;

    public void Initialize(ulong playerId)
    {
      this.playerId = playerId;
      this.OnUpdateTwitchViewerCount(playerId, ImiServices.Instance.TwitchService.GetStoredTwitchViewerCount(playerId));
      ImiServices.Instance.TwitchService.OnTwitchViewerCountUpdateEvent += new TwitchService.OnTwitchViewerCountUpdateEventHandler(this.OnUpdateTwitchViewerCount);
    }

    public void OnUpdateTwitchViewerCount(ulong playerId, int viewerCount)
    {
      if ((long) playerId != (long) this.playerId)
        return;
      this.EnableViewerCountInfo(viewerCount > 0);
      this.viewerCountText.text = viewerCount.ToString();
    }

    private void EnableViewerCountInfo(bool enable)
    {
      this.viewerCountParentObject.SetActive(enable);
      LayoutRebuilder.ForceRebuildLayoutImmediate(this.layoutElement.GetComponent<RectTransform>());
    }

    private void OnDestroy() => ImiServices.Instance.TwitchService.OnTwitchViewerCountUpdateEvent -= new TwitchService.OnTwitchViewerCountUpdateEventHandler(this.OnUpdateTwitchViewerCount);
  }
}
