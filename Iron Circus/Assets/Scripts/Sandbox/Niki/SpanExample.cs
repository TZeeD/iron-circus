// Decompiled with JetBrains decompiler
// Type: Sandbox.Niki.SpanExample
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;

namespace Sandbox.Niki
{
  public class SpanExample
  {
    private unsafe void Update()
    {
      // ISSUE: untyped stack allocation
      Span<byte> span = new Span<byte>((void*) __untypedstackalloc(new IntPtr(1024)), 1024);
      span[0] = (byte) 12;
      span[1] = (byte) 13;
      this.DoSomething("testtesttest");
    }

    private void DoSomething(string stringTest) => stringTest.AsSpan().Slice(2, 2);
  }
}
