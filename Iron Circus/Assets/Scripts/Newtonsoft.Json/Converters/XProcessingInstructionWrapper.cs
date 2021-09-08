// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Converters.XProcessingInstructionWrapper
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using System.Xml.Linq;

namespace Newtonsoft.Json.Converters
{
  internal class XProcessingInstructionWrapper : XObjectWrapper
  {
    private XProcessingInstruction ProcessingInstruction => (XProcessingInstruction) this.WrappedNode;

    public XProcessingInstructionWrapper(XProcessingInstruction processingInstruction)
      : base((XObject) processingInstruction)
    {
    }

    public override string LocalName => this.ProcessingInstruction.Target;

    public override string Value
    {
      get => this.ProcessingInstruction.Data;
      set => this.ProcessingInstruction.Data = value;
    }
  }
}
