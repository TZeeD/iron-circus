using System;
using UnityEngine;

namespace Imi.SteelCircus.FX
{
	[Serializable]
	public class FakeChampionView
	{
		public ulong playerId;
		public GameObject championView;
		public Transform spawnPoint;
		public Animator championAnimator;
		public PlayerSpawnView ChampionSpawnView;
	}
}
