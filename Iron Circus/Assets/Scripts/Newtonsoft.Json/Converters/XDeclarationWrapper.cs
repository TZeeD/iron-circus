// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Converters.XDeclarationWrapper
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using System.Xml;
using System.Xml.Linq;

namespace Newtonsoft.Json.Converters
{
  internal class XDeclarationWrapper : XObjectWrapper, IXmlDeclaration, IXmlNode
  {
    internal XDeclaration Declaration { get; }

    public XDeclarationWrapper(XDeclaration declaration)
      : base((XObject) null)
    {
      this.Declaration = declaration;
    }

    public override XmlNodeType NodeType => XmlNodeType.XmlDeclaration;

    public string Version => this.Declaration.Version;

    public string Encoding
    {
      get => this.Declaration.Encoding;
      set => this.Declaration.Encoding = value;
    }

    public string Standalone
    {
      get => this.Declaration.Standalone;
      set => this.Declaration.Standalone = value;
    }
  }
}
