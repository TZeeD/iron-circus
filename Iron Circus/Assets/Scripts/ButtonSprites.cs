// Decompiled with JetBrains decompiler
// Type: ButtonSprites
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Rewired;
using UnityEngine;

public class ButtonSprites
{
  public ControllerType Type;
  public string ControllerName;
  public Sprite ConfirmSprite;
  public Sprite ProfileSprite;
  public Sprite SocialSprite;
  public Sprite CancelSprite;
  public Sprite NextSprite;
  public Sprite PreviousSprite;
  public Sprite PrimarySkillSprite;
  public Sprite SecondarySkillSprite;

  public ButtonSprites(
    ControllerType type,
    string controllerName,
    Sprite confirmSprite,
    Sprite profileSprite,
    Sprite socialSprite,
    Sprite cancelSprite,
    Sprite nextSprite,
    Sprite previousSprite,
    Sprite primarySkillSprite,
    Sprite secondarySkillSprite)
  {
    this.Type = type;
    this.ControllerName = controllerName;
    this.ConfirmSprite = confirmSprite;
    this.ProfileSprite = profileSprite;
    this.SocialSprite = socialSprite;
    this.CancelSprite = cancelSprite;
    this.NextSprite = nextSprite;
    this.PreviousSprite = previousSprite;
    this.PrimarySkillSprite = primarySkillSprite;
    this.SecondarySkillSprite = secondarySkillSprite;
  }
}
