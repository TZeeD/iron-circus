// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Bson.BsonEmpty
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

namespace Newtonsoft.Json.Bson
{
  internal class BsonEmpty : BsonToken
  {
    public static readonly BsonToken Null = (BsonToken) new BsonEmpty(BsonType.Null);
    public static readonly BsonToken Undefined = (BsonToken) new BsonEmpty(BsonType.Undefined);

    private BsonEmpty(BsonType type) => this.Type = type;

    public override BsonType Type { get; }
  }
}
