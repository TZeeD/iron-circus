// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.UniqueId
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Newtonsoft.Json;
using System;
using System.IO;
using UnityEngine;

namespace Imi.SharedWithServer.Game
{
  [Serializable]
  public struct UniqueId : IEquatable<UniqueId>
  {
    [SerializeField]
    [JsonProperty]
    private ushort id;
    public static readonly UniqueId Zero = new UniqueId((ushort) 0);
    public static readonly UniqueId One = new UniqueId((ushort) 1);
    public static readonly UniqueId Invalid = new UniqueId(ushort.MaxValue);

    public ushort Value() => this.id;

    public UniqueId(ushort id) => this.id = id;

    public UniqueId Read(BinaryReader reader)
    {
      this.id = reader.ReadUInt16();
      return this;
    }

    public void Write(BinaryWriter writer) => writer.Write(this.id);

    public static implicit operator UniqueId(ushort value) => new UniqueId(value);

    public static bool operator <(UniqueId c1, UniqueId c2) => (int) c1.id < (int) c2.id;

    public static bool operator <=(UniqueId c1, UniqueId c2) => (int) c1.id <= (int) c2.id;

    public static bool operator >(UniqueId c1, UniqueId c2) => (int) c1.id > (int) c2.id;

    public static bool operator >=(UniqueId c1, UniqueId c2) => (int) c1.id >= (int) c2.id;

    public static bool operator ==(UniqueId c1, UniqueId c2) => c1.Equals(c2);

    public static bool operator !=(UniqueId c1, UniqueId c2) => !c1.Equals(c2);

    public static UniqueId operator ++(UniqueId c1)
    {
      ++c1.id;
      return c1;
    }

    public bool Equals(UniqueId other) => (int) this.id == (int) other.id;

    public override bool Equals(object obj) => obj != null && obj is UniqueId other && this.Equals(other);

    public override int GetHashCode() => this.id.GetHashCode();

    public static int SizeOf() => 2;

    public override string ToString() => this.id.ToString();
  }
}
