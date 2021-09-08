// Decompiled with JetBrains decompiler
// Type: Entitas.UnsafeAERC
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

namespace Entitas
{
  public sealed class UnsafeAERC : IAERC
  {
    private int _retainCount;

    public int retainCount => this._retainCount;

    public void Retain(object owner) => ++this._retainCount;

    public void Release(object owner) => --this._retainCount;
  }
}
