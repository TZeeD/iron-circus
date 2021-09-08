// Decompiled with JetBrains decompiler
// Type: Stateless.StateMachineResources
// Assembly: Stateless, Version=4.0.0.0, Culture=neutral, PublicKeyToken=93038f0927583c9a
// MVID: D5FEF726-C279-4B52-9490-86A1B7282D93
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Stateless.dll

using System.ComponentModel;
using System.Diagnostics;
using System.Globalization;
using System.Resources;
using System.Runtime.CompilerServices;

namespace Stateless
{
  [DebuggerNonUserCode]
  [CompilerGenerated]
  public class StateMachineResources
  {
    private static ResourceManager resourceMan;
    private static CultureInfo resourceCulture;

    internal StateMachineResources()
    {
    }

    [EditorBrowsable(EditorBrowsableState.Advanced)]
    public static ResourceManager ResourceManager
    {
      get
      {
        if (StateMachineResources.resourceMan == null)
          StateMachineResources.resourceMan = new ResourceManager("Stateless.StateMachineResources", typeof (StateMachineResources).GetAssembly());
        return StateMachineResources.resourceMan;
      }
    }

    [EditorBrowsable(EditorBrowsableState.Advanced)]
    public static CultureInfo Culture
    {
      get => StateMachineResources.resourceCulture;
      set => StateMachineResources.resourceCulture = value;
    }

    public static string CannotReconfigureParameters => StateMachineResources.ResourceManager.GetString(nameof (CannotReconfigureParameters), StateMachineResources.resourceCulture);

    public static string NoTransitionsPermitted => StateMachineResources.ResourceManager.GetString(nameof (NoTransitionsPermitted), StateMachineResources.resourceCulture);

    public static string NoTransitionsUnmetGuardConditions => StateMachineResources.ResourceManager.GetString(nameof (NoTransitionsUnmetGuardConditions), StateMachineResources.resourceCulture);
  }
}
