// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Converters.XTextWrapper
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using System.Xml.Linq;

namespace Newtonsoft.Json.Converters
{
  internal class XTextWrapper : XObjectWrapper
  {
    private XText Text => (XText) this.WrappedNode;

    public XTextWrapper(XText text)
      : base((XObject) text)
    {
    }

    public override string Value
    {
      get => this.Text.Value;
      set => this.Text.Value = value;
    }

    public override IXmlNode ParentNode => this.Text.Parent == null ? (IXmlNode) null : XContainerWrapper.WrapNode((XObject) this.Text.Parent);
  }
}
