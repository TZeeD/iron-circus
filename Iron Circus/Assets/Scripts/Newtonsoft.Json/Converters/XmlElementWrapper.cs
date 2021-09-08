﻿// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Converters.XmlElementWrapper
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using System.Xml;

namespace Newtonsoft.Json.Converters
{
  internal class XmlElementWrapper : XmlNodeWrapper, IXmlElement, IXmlNode
  {
    private readonly XmlElement _element;

    public XmlElementWrapper(XmlElement element)
      : base((XmlNode) element)
    {
      this._element = element;
    }

    public void SetAttributeNode(IXmlNode attribute) => this._element.SetAttributeNode((XmlAttribute) ((XmlNodeWrapper) attribute).WrappedNode);

    public string GetPrefixOfNamespace(string namespaceUri) => this._element.GetPrefixOfNamespace(namespaceUri);

    public bool IsEmpty => this._element.IsEmpty;
  }
}
