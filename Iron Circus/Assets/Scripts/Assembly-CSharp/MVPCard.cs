using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class MVPCard : MonoBehaviour
{
	[SerializeField]
	private GameObject cardFront;
	[SerializeField]
	private GameObject cardBack;
	[SerializeField]
	private GameObject mvpBorderRectangles;
	[SerializeField]
	private GameObject mvpIconTeamAlpha;
	[SerializeField]
	private GameObject mvpIconTeamBeta;
	[SerializeField]
	private Image champIcon;
	[SerializeField]
	private Image innerBorder;
	[SerializeField]
	private Image innerBorderBack;
	[SerializeField]
	private Image outerBorder;
	[SerializeField]
	private Image mvpColorBG;
	[SerializeField]
	private Image mvpFogEffect;
	[SerializeField]
	private GameObject votePraiseParentObject;
	[SerializeField]
	private Image votePraiseBorderObject;
	[SerializeField]
	private TextMeshProUGUI votePraiseText;
	[SerializeField]
	private Image voteButtonBackground;
	[SerializeField]
	private MvpVoteButton MvpVoteButton;
	[SerializeField]
	private Image MvpVoteIcon;
	[SerializeField]
	private Image MvpVoteIconGlow;
	[SerializeField]
	private ParticleSystem particleEffectTop;
	[SerializeField]
	private ParticleSystem particleEffectBottom;
	[SerializeField]
	private ParticleSystem particleEffectUpgrade;
	[SerializeField]
	private ParticleSystem particleEffectUpgradeSubtle;
	[SerializeField]
	private Animator mvpGlowAnimator;
	[SerializeField]
	private TextMeshProUGUI usernameTxt;
	[SerializeField]
	private TextMeshProUGUI awardNameText;
	[SerializeField]
	private TextMeshProUGUI cardScoreText;
	[SerializeField]
	private RectTransform textLayoutParent;
	public string awardNameString;
}
