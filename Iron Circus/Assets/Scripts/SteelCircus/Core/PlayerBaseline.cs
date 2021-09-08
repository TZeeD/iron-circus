// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.PlayerBaseline
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.ScEntitas.Components;

namespace SteelCircus.Core
{
  public class PlayerBaseline
  {
    public byte[] cachedByteArray = new byte[2048];
    public uint tick;
    public TransformState transform;
    public SerializedSkillGraphs skills;
    public SerializedStatusEffects status;
    public SerializedStatusEffects tmpStatus;
    public AnimationStates animation;

    public PlayerBaseline()
    {
      this.tick = 0U;
      this.transform = TransformState.Default;
      this.skills = new SerializedSkillGraphs();
      this.status = new SerializedStatusEffects();
      this.tmpStatus = new SerializedStatusEffects();
      this.animation = new AnimationStates();
    }
  }
}
