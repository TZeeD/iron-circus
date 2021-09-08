// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.Services.IsInMatchService
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

namespace SteelCircus.Core.Services
{
  public class IsInMatchService
  {
    private bool isPlayerInMatch;
    private string currentArena;

    public bool IsPlayerInMatch
    {
      get => this.isPlayerInMatch;
      set => this.isPlayerInMatch = value;
    }

    public string CurrentArena
    {
      get => this.currentArena;
      set => this.currentArena = value;
    }
  }
}
