// Decompiled with JetBrains decompiler
// Type: Discord.ImageHandle
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

namespace Discord
{
  public struct ImageHandle
  {
    public ImageType Type;
    public long Id;
    public uint Size;

    public static ImageHandle User(long id) => ImageHandle.User(id, 128U);

    public static ImageHandle User(long id, uint size) => new ImageHandle()
    {
      Type = ImageType.User,
      Id = id,
      Size = size
    };
  }
}
