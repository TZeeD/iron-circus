// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Serialization.DefaultSerializationBinder
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using Newtonsoft.Json.Utilities;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Reflection;
using System.Runtime.Serialization;

namespace Newtonsoft.Json.Serialization
{
  public class DefaultSerializationBinder : SerializationBinder, ISerializationBinder
  {
    internal static readonly DefaultSerializationBinder Instance = new DefaultSerializationBinder();
    private readonly ThreadSafeStore<TypeNameKey, Type> _typeCache;

    public DefaultSerializationBinder() => this._typeCache = new ThreadSafeStore<TypeNameKey, Type>(new Func<TypeNameKey, Type>(this.GetTypeFromTypeNameKey));

    private Type GetTypeFromTypeNameKey(TypeNameKey typeNameKey)
    {
      string assemblyName = typeNameKey.AssemblyName;
      string typeName = typeNameKey.TypeName;
      if (assemblyName == null)
        return Type.GetType(typeName);
      Assembly assembly1 = Assembly.LoadWithPartialName(assemblyName);
      if (assembly1 == (Assembly) null)
      {
        foreach (Assembly assembly2 in AppDomain.CurrentDomain.GetAssemblies())
        {
          if (assembly2.FullName == assemblyName || assembly2.GetName().Name == assemblyName)
          {
            assembly1 = assembly2;
            break;
          }
        }
      }
      Type type = !(assembly1 == (Assembly) null) ? assembly1.GetType(typeName) : throw new JsonSerializationException("Could not load assembly '{0}'.".FormatWith((IFormatProvider) CultureInfo.InvariantCulture, (object) assemblyName));
      if (type == (Type) null)
      {
        if (typeName.IndexOf('`') >= 0)
        {
          try
          {
            type = this.GetGenericTypeFromTypeName(typeName, assembly1);
          }
          catch (Exception ex)
          {
            throw new JsonSerializationException("Could not find type '{0}' in assembly '{1}'.".FormatWith((IFormatProvider) CultureInfo.InvariantCulture, (object) typeName, (object) assembly1.FullName), ex);
          }
        }
        if (type == (Type) null)
          throw new JsonSerializationException("Could not find type '{0}' in assembly '{1}'.".FormatWith((IFormatProvider) CultureInfo.InvariantCulture, (object) typeName, (object) assembly1.FullName));
      }
      return type;
    }

    private Type GetGenericTypeFromTypeName(string typeName, Assembly assembly)
    {
      Type type1 = (Type) null;
      int length = typeName.IndexOf('[');
      if (length >= 0)
      {
        string name = typeName.Substring(0, length);
        Type type2 = assembly.GetType(name);
        if (type2 != (Type) null)
        {
          List<Type> typeList = new List<Type>();
          int num1 = 0;
          int startIndex = 0;
          int num2 = typeName.Length - 1;
          for (int index = length + 1; index < num2; ++index)
          {
            switch (typeName[index])
            {
              case '[':
                if (num1 == 0)
                  startIndex = index + 1;
                ++num1;
                break;
              case ']':
                --num1;
                if (num1 == 0)
                {
                  TypeNameKey typeNameKey = ReflectionUtils.SplitFullyQualifiedTypeName(typeName.Substring(startIndex, index - startIndex));
                  typeList.Add(this.GetTypeByName(typeNameKey));
                  break;
                }
                break;
            }
          }
          type1 = type2.MakeGenericType(typeList.ToArray());
        }
      }
      return type1;
    }

    private Type GetTypeByName(TypeNameKey typeNameKey) => this._typeCache.Get(typeNameKey);

    public override Type BindToType(string assemblyName, string typeName) => this.GetTypeByName(new TypeNameKey(assemblyName, typeName));

    public override void BindToName(
      Type serializedType,
      out string assemblyName,
      out string typeName)
    {
      assemblyName = serializedType.Assembly.FullName;
      typeName = serializedType.FullName;
    }
  }
}
