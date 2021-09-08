// Decompiled with JetBrains decompiler
// Type: RazerAnimation
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;

public class RazerAnimation
{
  public int Headset;
  public int Mouse;
  public int Mousepad;
  public int Keyboard;
  public int ChromaLink;
  public IntPtr HeadsetIntPtr;
  public IntPtr MouseIntPtr;
  public IntPtr MousepadIntPtr;
  public IntPtr KeyboardIntPtr;
  public IntPtr ChromaLinkIntPtr;

  public RazerAnimation(int headset, int mouse, int mousepad, int keyboard, int chromaLink)
  {
    this.Headset = headset;
    this.Mouse = mouse;
    this.Mousepad = mousepad;
    this.Keyboard = keyboard;
    this.ChromaLink = chromaLink;
  }

  public RazerAnimation(int[] handles, IntPtr[] intPtrs)
  {
    this.Headset = handles[0];
    this.Mouse = handles[1];
    this.Mousepad = handles[2];
    this.Keyboard = handles[3];
    this.ChromaLink = handles[4];
    this.HeadsetIntPtr = intPtrs[0];
    this.MouseIntPtr = intPtrs[1];
    this.MousepadIntPtr = intPtrs[2];
    this.KeyboardIntPtr = intPtrs[3];
    this.ChromaLinkIntPtr = intPtrs[4];
  }
}
