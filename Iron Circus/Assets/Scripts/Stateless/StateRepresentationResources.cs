// Decompiled with JetBrains decompiler
// Type: Stateless.StateRepresentationResources
// Assembly: Stateless, Version=4.0.0.0, Culture=neutral, PublicKeyToken=93038f0927583c9a
// MVID: D5FEF726-C279-4B52-9490-86A1B7282D93
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Stateless.dll

using System.CodeDom.Compiler;
using System.ComponentModel;
using System.Diagnostics;
using System.Globalization;
using System.Resources;
using System.Runtime.CompilerServices;

namespace Stateless
{
  [GeneratedCode("System.Resources.Tools.StronglyTypedResourceBuilder", "4.0.0.0")]
  [DebuggerNonUserCode]
  [CompilerGenerated]
  internal class StateRepresentationResources
  {
    private static ResourceManager resourceMan;
    private static CultureInfo resourceCulture;

    internal StateRepresentationResources()
    {
    }

    [EditorBrowsable(EditorBrowsableState.Advanced)]
    internal static ResourceManager ResourceManager
    {
      get
      {
        if (StateRepresentationResources.resourceMan == null)
          StateRepresentationResources.resourceMan = new ResourceManager("Stateless.StateRepresentationResources", typeof (StateRepresentationResources).GetAssembly());
        return StateRepresentationResources.resourceMan;
      }
    }

    [EditorBrowsable(EditorBrowsableState.Advanced)]
    internal static CultureInfo Culture
    {
      get => StateRepresentationResources.resourceCulture;
      set => StateRepresentationResources.resourceCulture = value;
    }

    internal static string MultipleTransitionsPermitted => StateRepresentationResources.ResourceManager.GetString(nameof (MultipleTransitionsPermitted), StateRepresentationResources.resourceCulture);
  }
}
