// Decompiled with JetBrains decompiler
// Type: Imi.Utils.JitterBuffer`1
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Networking.reliable;

namespace Imi.Utils
{
  public class JitterBuffer<T> where T : class, new()
  {
    private SequenceBuffer32<T> buffer;

    public JitterBuffer(int size) => this.buffer = new SequenceBuffer32<T>(size);

    public bool AddOnTick(int tick, T obj)
    {
      int index = this.buffer.Insert((uint) tick);
      if (index < 0)
      {
        Log.Error(string.Format("JitterBuffer could not insert for tick {0}.", (object) tick));
        return false;
      }
      this.buffer.Entries[index] = obj;
      return true;
    }

    public T GetEntry(int tick)
    {
      int index = this.buffer.Find((uint) tick);
      return index == -1 ? default (T) : this.buffer.Entries[index];
    }
  }
}
