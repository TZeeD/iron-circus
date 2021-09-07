using UnityEngine;
using Imi.Game;

public class GoalShotFX : MonoBehaviour
{
	public float lifeTime;
	public float flashAndGlowDuration;
	[SerializeField]
	private GameObject fxParent;
	[SerializeField]
	private MeshRenderer flashRenderer;
	[SerializeField]
	private MeshRenderer glowRenderer;
	public int numConfettiParticles;
	[SerializeField]
	private ParticleSystem[] confettiParticles;
	public int numGoalParticles;
	[SerializeField]
	private ParticleSystem goalParticles;
	public Team team;
}
