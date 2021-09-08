// Decompiled with JetBrains decompiler
// Type: Rewired.FlightPedalsTemplate
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;

namespace Rewired
{
  public sealed class FlightPedalsTemplate : 
    ControllerTemplate,
    IFlightPedalsTemplate,
    IControllerTemplate
  {
    public static readonly Guid typeGuid = new Guid("f6fe76f8-be2a-4db2-b853-9e3652075913");
    public const int elementId_leftPedal = 0;
    public const int elementId_rightPedal = 1;
    public const int elementId_slide = 2;

    IControllerTemplateAxis IFlightPedalsTemplate.leftPedal => this.GetElement<IControllerTemplateAxis>(0);

    IControllerTemplateAxis IFlightPedalsTemplate.rightPedal => this.GetElement<IControllerTemplateAxis>(1);

    IControllerTemplateAxis IFlightPedalsTemplate.slide => this.GetElement<IControllerTemplateAxis>(2);

    public FlightPedalsTemplate(object payload)
      : base(payload)
    {
    }
  }
}
