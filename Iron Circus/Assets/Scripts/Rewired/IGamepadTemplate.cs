// Decompiled with JetBrains decompiler
// Type: Rewired.IGamepadTemplate
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

namespace Rewired
{
  public interface IGamepadTemplate : IControllerTemplate
  {
    IControllerTemplateButton actionBottomRow1 { get; }

    IControllerTemplateButton a { get; }

    IControllerTemplateButton actionBottomRow2 { get; }

    IControllerTemplateButton b { get; }

    IControllerTemplateButton actionBottomRow3 { get; }

    IControllerTemplateButton c { get; }

    IControllerTemplateButton actionTopRow1 { get; }

    IControllerTemplateButton x { get; }

    IControllerTemplateButton actionTopRow2 { get; }

    IControllerTemplateButton y { get; }

    IControllerTemplateButton actionTopRow3 { get; }

    IControllerTemplateButton z { get; }

    IControllerTemplateButton leftShoulder1 { get; }

    IControllerTemplateButton leftBumper { get; }

    IControllerTemplateAxis leftShoulder2 { get; }

    IControllerTemplateAxis leftTrigger { get; }

    IControllerTemplateButton rightShoulder1 { get; }

    IControllerTemplateButton rightBumper { get; }

    IControllerTemplateAxis rightShoulder2 { get; }

    IControllerTemplateAxis rightTrigger { get; }

    IControllerTemplateButton center1 { get; }

    IControllerTemplateButton back { get; }

    IControllerTemplateButton center2 { get; }

    IControllerTemplateButton start { get; }

    IControllerTemplateButton center3 { get; }

    IControllerTemplateButton guide { get; }

    IControllerTemplateThumbStick leftStick { get; }

    IControllerTemplateThumbStick rightStick { get; }

    IControllerTemplateDPad dPad { get; }
  }
}
