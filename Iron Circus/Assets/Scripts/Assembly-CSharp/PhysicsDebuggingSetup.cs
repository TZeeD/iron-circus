using UnityEngine;
using Imi.SharedWithServer.Config;
using Jitter.LinearMath;
using SharedWithServer.ScEntitas.Systems.Gameplay;

public class PhysicsDebuggingSetup : MonoBehaviour
{
	public ConfigProvider configProvider;
	public float contactPSize;
	public float ballRadius;
	public bool overlapResolve;
	public bool showCapsuleCast;
	public float herz;
	public float speed;
	public JVector velocity;
	public JVector ballPos;
	public int tick;
	public bool play;
	public bool step;
	public ObstacleCheckResult checkResult;
}
