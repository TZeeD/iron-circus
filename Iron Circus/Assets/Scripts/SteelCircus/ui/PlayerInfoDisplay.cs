// Decompiled with JetBrains decompiler
// Type: SteelCircus.ui.PlayerInfoDisplay
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.Core;
using Imi.SteelCircus.GameElements;
using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.ui
{
  public class PlayerInfoDisplay : MonoBehaviour
  {
    public Text playerText;
    public Image controllerImage;
    public Sprite sprControllerOn;
    public Sprite sprControllerOff;
    [Space]
    public Player player;
    private bool initialitzed;

    private void Start() => this.gameObject.SetActive(this.initialitzed);

    public void Init(Player player)
    {
      this.gameObject.SetActive(true);
      this.player = player;
      this.playerText.color = StartupSetup.Colors.LightColor(player.PlayerTeam);
      this.initialitzed = true;
    }

    private void Update()
    {
      if (Input.GetJoystickNames().Length < 1)
        this.controllerImage.sprite = this.sprControllerOff;
      else
        this.controllerImage.sprite = Input.GetJoystickNames()[0] != "" ? this.sprControllerOn : this.sprControllerOff;
    }
  }
}
