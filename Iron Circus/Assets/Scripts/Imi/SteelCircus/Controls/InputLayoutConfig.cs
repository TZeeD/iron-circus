// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Controls.InputLayoutConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace Imi.SteelCircus.Controls
{
  public class InputLayoutConfig : GameConfigEntry
  {
    [SerializeField]
    private KeyCode ROTATE_X_KEY;
    [SerializeField]
    private KeyCode ROTATE_Y_KEY;
    [SerializeField]
    private KeyCode MOVE_X_KEY;
    [SerializeField]
    private KeyCode MOVE_Y_KEY;
    [SerializeField]
    private KeyCode JUMP_KEY;
    [SerializeField]
    private KeyCode BOOST_KEY;
    [SerializeField]
    private KeyCode HIT_KEY;

    public KeyCode Rotate_X_Key => this.ROTATE_X_KEY;

    public KeyCode Rotate_Y_Key => this.ROTATE_Y_KEY;

    public KeyCode Move_X_Key => this.MOVE_X_KEY;

    public KeyCode Move_Y_Key => this.MOVE_Y_KEY;

    public KeyCode Jump_Key => this.JUMP_KEY;

    public KeyCode Boost_Key => this.BOOST_KEY;

    public KeyCode Hit_Key => this.HIT_KEY;
  }
}
