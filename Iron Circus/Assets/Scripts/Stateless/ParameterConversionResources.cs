// Decompiled with JetBrains decompiler
// Type: Stateless.ParameterConversionResources
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
  internal class ParameterConversionResources
  {
    private static ResourceManager resourceMan;
    private static CultureInfo resourceCulture;

    internal ParameterConversionResources()
    {
    }

    [EditorBrowsable(EditorBrowsableState.Advanced)]
    internal static ResourceManager ResourceManager
    {
      get
      {
        if (ParameterConversionResources.resourceMan == null)
          ParameterConversionResources.resourceMan = new ResourceManager("Stateless.ParameterConversionResources", typeof (ParameterConversionResources).GetAssembly());
        return ParameterConversionResources.resourceMan;
      }
    }

    [EditorBrowsable(EditorBrowsableState.Advanced)]
    internal static CultureInfo Culture
    {
      get => ParameterConversionResources.resourceCulture;
      set => ParameterConversionResources.resourceCulture = value;
    }

    internal static string ArgOfTypeRequiredInPosition => ParameterConversionResources.ResourceManager.GetString(nameof (ArgOfTypeRequiredInPosition), ParameterConversionResources.resourceCulture);

    internal static string TooManyParameters => ParameterConversionResources.ResourceManager.GetString(nameof (TooManyParameters), ParameterConversionResources.resourceCulture);

    internal static string WrongArgType => ParameterConversionResources.ResourceManager.GetString(nameof (WrongArgType), ParameterConversionResources.resourceCulture);
  }
}
