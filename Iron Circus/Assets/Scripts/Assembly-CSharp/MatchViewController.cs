using Imi.SteelCircus.UI;
using UnityEngine;
using SteelCircus.UI;
using SteelCircus.UI.MatchFlow;

public class MatchViewController : SingletonManager<MatchViewController>
{
	[SerializeField]
	private MatchUi matchUI;
	[SerializeField]
	private PlayerUiController playerUiController;
	[SerializeField]
	private MVPScreen mvpUi;
	[SerializeField]
	private XPUi xpUi;
	[SerializeField]
	private MatchEndScreen endScreen;
}
