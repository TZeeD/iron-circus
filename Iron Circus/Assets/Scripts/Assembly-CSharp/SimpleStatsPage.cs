using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class SimpleStatsPage : MonoBehaviour
{
	public RecentMatchObject[] recentMatchesEntries;
	public StatsPageEntry matchCount;
	public StatsPageEntry drawCount;
	public StatsPageEntry winRatio;
	public StatsPageEntry mvpCount;
	public StatsPageEntry[] FrequentRewardObjects;
	public Image xpBarFill;
	public TextMeshProUGUI levelTextObject;
	public TextMeshProUGUI playerNameObject;
	public GameObject loadingObject;
	public CanvasGroup statPageParent;
}
