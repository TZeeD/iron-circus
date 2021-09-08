// Decompiled with JetBrains decompiler
// Type: Stateless.Reflection.DynamicTransitionInfo
// Assembly: Stateless, Version=4.0.0.0, Culture=neutral, PublicKeyToken=93038f0927583c9a
// MVID: D5FEF726-C279-4B52-9490-86A1B7282D93
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Stateless.dll

using System.Collections.Generic;

namespace Stateless.Reflection
{
  public class DynamicTransitionInfo : TransitionInfo
  {
    internal InvocationInfo DestinationStateSelectorDescription { get; private set; }

    internal DynamicStateInfos PossibleDestinationStates { get; private set; }

    internal static DynamicTransitionInfo Create<TTrigger>(
      TTrigger trigger,
      IEnumerable<InvocationInfo> guards,
      InvocationInfo selector,
      DynamicStateInfos possibleStates)
    {
      DynamicTransitionInfo dynamicTransitionInfo = new DynamicTransitionInfo();
      dynamicTransitionInfo.Trigger = new TriggerInfo((object) trigger);
      dynamicTransitionInfo.GuardConditionsMethodDescriptions = guards ?? (IEnumerable<InvocationInfo>) new List<InvocationInfo>();
      dynamicTransitionInfo.DestinationStateSelectorDescription = selector;
      dynamicTransitionInfo.PossibleDestinationStates = possibleStates;
      return dynamicTransitionInfo;
    }

    private DynamicTransitionInfo()
    {
    }
  }
}
