// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Converters.XAttributeWrapper
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using System.Xml.Linq;

namespace Newtonsoft.Json.Converters
{
  internal class XAttributeWrapper : XObjectWrapper
  {
    private XAttribute Attribute => (XAttribute) this.WrappedNode;

    public XAttributeWrapper(XAttribute attribute)
      : base((XObject) attribute)
    {
    }

    public override string Value
    {
      get => this.Attribute.Value;
      set => this.Attribute.Value = value;
    }

    public override string LocalName => this.Attribute.Name.LocalName;

    public override string NamespaceUri => this.Attribute.Name.NamespaceName;

    public override IXmlNode ParentNode => this.Attribute.Parent == null ? (IXmlNode) null : XContainerWrapper.WrapNode((XObject) this.Attribute.Parent);
  }
}
