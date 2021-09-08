// Decompiled with JetBrains decompiler
// Type: TypeNameSerializationBinder
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Newtonsoft.Json.Serialization;
using System;
using System.Text;

public class TypeNameSerializationBinder : ISerializationBinder
{
  public void BindToName(Type serializedType, out string assemblyName, out string typeName)
  {
    assemblyName = serializedType.Assembly.FullName;
    if (serializedType.IsGenericType)
      typeName = string.Format("{0}.{1}[{2}]", (object) serializedType.Namespace, (object) serializedType.Name, (object) this.BindGenericArgs(serializedType.GetGenericArguments()));
    else if (string.IsNullOrEmpty(serializedType.Namespace))
      typeName = string.Format("{0}", (object) serializedType.Name);
    else
      typeName = string.Format("{0}.{1}", (object) serializedType.Namespace, (object) serializedType.Name);
  }

  public Type BindToType(string assemblyName, string typeName) => Type.GetType(string.Format("{0}, {1}", (object) typeName, (object) assemblyName), true);

  private string BindGenericArgs(Type[] args)
  {
    StringBuilder stringBuilder = new StringBuilder();
    stringBuilder.Append("[");
    for (int index = 0; index < args.Length; ++index)
    {
      string typeName;
      this.BindToName(args[index], out string _, out typeName);
      stringBuilder.Append(typeName);
      if (index < args.Length - 1)
        stringBuilder.Append(", ");
    }
    stringBuilder.Append("]");
    return stringBuilder.ToString();
  }
}
