// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Controls.ButtonSpriteSet
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections.Generic;
using UnityEngine;

namespace Imi.SteelCircus.Controls
{
  public class ButtonSpriteSet
  {
    private Dictionary<DigitalInput, ButtonSprite> buttonSprites;

    public Sprite GetButtonSprite(DigitalInput button)
    {
      if (this.buttonSprites == null)
        this.buttonSprites = new Dictionary<DigitalInput, ButtonSprite>();
      if (this.buttonSprites.ContainsKey(button))
        return this.buttonSprites[button].Sprite;
      Debug.LogWarning((object) ("No glyph specified for button " + (object) button));
      return (Sprite) null;
    }

    public string GetButtonSpritePath(DigitalInput button) => this.buttonSprites == null || !this.buttonSprites.ContainsKey(button) ? "" : this.buttonSprites[button].LoadPath;

    public void SetButtonSprite(DigitalInput button, Sprite sprite, string loadPath)
    {
      if (this.buttonSprites == null)
        this.buttonSprites = new Dictionary<DigitalInput, ButtonSprite>();
      if (!this.buttonSprites.ContainsKey(button))
        this.buttonSprites.Add(button, new ButtonSprite(button, sprite, loadPath));
      else
        this.buttonSprites[button] = new ButtonSprite(button, sprite, loadPath);
    }

    public void SetButtonSprite(ButtonSprite buttonSprite) => this.SetButtonSprite(buttonSprite.Button, buttonSprite.Sprite, buttonSprite.LoadPath);
  }
}
