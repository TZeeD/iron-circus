// Decompiled with JetBrains decompiler
// Type: Imi.Game.History.BallHistoryObject
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Utils.Extensions;
using Jitter.LinearMath;

namespace Imi.Game.History
{
  public class BallHistoryObject : IHistoryObject
  {
    public JVector ballImpulse;

    public TransformState TransformState { get; set; }

    public BallHistoryObject()
    {
      this.TransformState = new TransformState();
      this.ballImpulse = new JVector();
    }

    public BallHistoryObject(TransformState transformState, JVector ballImpulse) => this.TransformState = transformState;

    public static void ToEntity(GameEntity entity, BallHistoryObject t)
    {
      entity.SetTransformState(t.TransformState);
      entity.ReplaceBallImpulse(t.ballImpulse);
    }

    public void CopyFrom(GameEntity entity, IHistoryObject copyFromReference)
    {
      this.TransformState = entity.ToTransformState();
      this.ballImpulse = entity.hasBallImpulse ? entity.ballImpulse.value : JVector.Zero;
    }
  }
}
