using UnityEngine;
using Imi.SteelCircus.FX;
using System.Collections.Generic;
using SteelCircus.Client_Components;

public class VictoryAnimationEvents : MonoBehaviour
{
	[SerializeField]
	private bool fakeSpawnCutscene;
	[SerializeField]
	private Animator victoryAlphaAnimator;
	[SerializeField]
	private Animator victoryBetaAnimator;
	[SerializeField]
	private Animator drawAnimator;
	public PlayerSelectedChampion[] champions;
	public List<FakeChampionView> championViews;
	public int playerCount;
	public VictorySpawnPoint[] victorySpawnPoints;
}
