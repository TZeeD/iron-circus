// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Converters.IXmlDocument
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

namespace Newtonsoft.Json.Converters
{
  internal interface IXmlDocument : IXmlNode
  {
    IXmlNode CreateComment(string text);

    IXmlNode CreateTextNode(string text);

    IXmlNode CreateCDataSection(string data);

    IXmlNode CreateWhitespace(string text);

    IXmlNode CreateSignificantWhitespace(string text);

    IXmlNode CreateXmlDeclaration(string version, string encoding, string standalone);

    IXmlNode CreateXmlDocumentType(
      string name,
      string publicId,
      string systemId,
      string internalSubset);

    IXmlNode CreateProcessingInstruction(string target, string data);

    IXmlElement CreateElement(string elementName);

    IXmlElement CreateElement(string qualifiedName, string namespaceUri);

    IXmlNode CreateAttribute(string name, string value);

    IXmlNode CreateAttribute(string qualifiedName, string namespaceUri, string value);

    IXmlElement DocumentElement { get; }
  }
}
