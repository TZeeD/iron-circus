using UnityEngine;
using System.Collections.Generic;
using SteelCircus.Client_Components;

namespace Imi.SteelCircus.FX
{
	public class IntroAnimationEvents : MonoBehaviour
	{
		[SerializeField]
		private bool fakeSpawnCutscene;
		public PlayerSelectedChampion[] champions;
		public List<FakeChampionView> championViews;
		public int playerCount;
		public IntroSpawnPoint[] introSpawnPoints;
	}
}
