// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.Services.UnitySystemConsoleRedirector
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.IO;
using System.Text;

namespace SteelCircus.Core.Services
{
  public static class UnitySystemConsoleRedirector
  {
    public static void Redirect() => Console.SetOut((TextWriter) new UnitySystemConsoleRedirector.UnityTextWriter());

    private class UnityTextWriter : TextWriter
    {
      private StringBuilder buffer = new StringBuilder();

      public override void Flush() => this.buffer.Length = 0;

      public override void Write(string value)
      {
        this.buffer.Append(value);
        if (value == null)
          return;
        int length = value.Length;
        if (length <= 0 || value[length - 1] != '\n')
          return;
        this.Flush();
      }

      public override void Write(char value)
      {
        this.buffer.Append(value);
        if (value != '\n')
          return;
        this.Flush();
      }

      public override void Write(char[] value, int index, int count) => this.Write(new string(value, index, count));

      public override Encoding Encoding => Encoding.Default;
    }
  }
}
