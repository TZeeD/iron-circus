// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Components.AnimationStateComponent
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using System.Collections.Generic;

namespace Imi.SharedWithServer.ScEntitas.Components
{
  [global::Game]
  public class AnimationStateComponent : ImiComponent
  {
    public Dictionary<AnimationStateType, AnimationState> animationStateData = new Dictionary<AnimationStateType, AnimationState>(16);

    public bool HasType(AnimationStateType type) => this.animationStateData.ContainsKey(type);

    public AnimationState GetState(AnimationStateType type) => this.HasType(type) ? this.animationStateData[type] : AnimationState.Invalid;

    public void AddReplaceState(AnimationStateType type, AnimationState value) => this.animationStateData[type] = value;

    public void AddReplaceState(AnimationStateType type) => this.AddReplaceState(type, AnimationState.Invalid);

    public void RemoveState(AnimationStateType type) => this.animationStateData.Remove(type);

    public void RemoveAll() => this.animationStateData.Clear();
  }
}
