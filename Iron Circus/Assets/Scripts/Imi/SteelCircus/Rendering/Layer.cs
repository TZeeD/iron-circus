// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Rendering.Layer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

namespace Imi.SteelCircus.Rendering
{
  public enum Layer
  {
    Default = 0,
    TransparentFX = 1,
    IgnoreRaycast = 2,
    Water = 4,
    UI = 5,
    FloorEmissive = 9,
    Turntable = 10, // 0x0000000A
    DefaultWithoutReflections = 12, // 0x0000000C
    DefaultReflectionsOnly = 13, // 0x0000000D
    Audience = 15, // 0x0000000F
    FloorNormals = 16, // 0x00000010
    FloorDirt = 17, // 0x00000011
    EnvironmentWithReflections = 20, // 0x00000014
    EnvironmentWithoutReflections = 21, // 0x00000015
    EnvironmentReflectionsOnly = 22, // 0x00000016
    DontRender = 31, // 0x0000001F
  }
}
