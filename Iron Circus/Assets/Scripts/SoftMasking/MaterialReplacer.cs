// Decompiled with JetBrains decompiler
// Type: SoftMasking.MaterialReplacer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Reflection.Emit;
using UnityEngine;

namespace SoftMasking
{
  public static class MaterialReplacer
  {
    private static List<IMaterialReplacer> _globalReplacers;

    public static IEnumerable<IMaterialReplacer> globalReplacers
    {
      get
      {
        if (MaterialReplacer._globalReplacers == null)
          MaterialReplacer._globalReplacers = MaterialReplacer.CollectGlobalReplacers().ToList<IMaterialReplacer>();
        return (IEnumerable<IMaterialReplacer>) MaterialReplacer._globalReplacers;
      }
    }

    private static IEnumerable<IMaterialReplacer> CollectGlobalReplacers() => ((IEnumerable<Assembly>) AppDomain.CurrentDomain.GetAssemblies()).SelectMany<Assembly, System.Type>((Func<Assembly, IEnumerable<System.Type>>) (x => x.GetTypesSafe())).Where<System.Type>((Func<System.Type, bool>) (t => MaterialReplacer.IsMaterialReplacerType(t))).Select<System.Type, IMaterialReplacer>((Func<System.Type, IMaterialReplacer>) (t => MaterialReplacer.TryCreateInstance(t))).Where<IMaterialReplacer>((Func<IMaterialReplacer, bool>) (t => t != null));

    private static bool IsMaterialReplacerType(System.Type t) => !(t is TypeBuilder) && !t.IsAbstract && t.IsDefined(typeof (GlobalMaterialReplacerAttribute), false) && typeof (IMaterialReplacer).IsAssignableFrom(t);

    private static IMaterialReplacer TryCreateInstance(System.Type t)
    {
      try
      {
        return (IMaterialReplacer) Activator.CreateInstance(t);
      }
      catch (Exception ex)
      {
        Debug.LogErrorFormat("Could not create instance of {0}: {1}", (object) t.Name, (object) ex);
        return (IMaterialReplacer) null;
      }
    }

    private static IEnumerable<System.Type> GetTypesSafe(this Assembly asm)
    {
      try
      {
        return (IEnumerable<System.Type>) asm.GetTypes();
      }
      catch (ReflectionTypeLoadException ex)
      {
        return ((IEnumerable<System.Type>) ex.Types).Where<System.Type>((Func<System.Type, bool>) (t => t != (System.Type) null));
      }
    }
  }
}
