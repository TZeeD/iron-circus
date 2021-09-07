using UnityEngine;
using UnityEngine.UI;
using TMPro;

namespace SteelCircus.Tutorial
{
	public class TutorialTextBox : MonoBehaviour
	{
		[SerializeField]
		private GameObject root;
		[SerializeField]
		private Transform boxParent;
		[SerializeField]
		private Image boxBG;
		[SerializeField]
		private Image boxGlow;
		[SerializeField]
		private Image boxOutline;
		[SerializeField]
		private Image illustration;
		[SerializeField]
		private GameObject illustrationSpacer;
		[SerializeField]
		private Image buttonIcon;
		[SerializeField]
		private GameObject buttonSpacer;
		[SerializeField]
		private TMP_Text headline;
		[SerializeField]
		private TMP_Text mainText;
		[SerializeField]
		private RectTransform mainTextPanel;
		[SerializeField]
		private GameObject contents;
		[SerializeField]
		private GameObject contentsPlaceholder;
		[SerializeField]
		private Color infoBGColor;
		[SerializeField]
		private Color errorBGColor;
		[SerializeField]
		private Color infoOutlineColor;
		[SerializeField]
		private Color errorOutlineColor;
		[SerializeField]
		private float stateAnimationDurationPer100Px;
		[SerializeField]
		private AnimationCurve showWidthCurve;
		[SerializeField]
		private AnimationCurve hideWidthCurve;
		[SerializeField]
		private AnimationCurve showGlowCurve;
		[SerializeField]
		private AnimationCurve hideGlowCurve;
		public Sprite tmpDebugTex;
		[SerializeField]
		private Sprite bigBoxBGTex;
		[SerializeField]
		private Sprite bigBoxGlowTex;
		[SerializeField]
		private Sprite bigBoxOutlineTex;
		[SerializeField]
		private Sprite smallBoxBGTex;
		[SerializeField]
		private Sprite smallBoxGlowTex;
		[SerializeField]
		private Sprite smallBoxOutlineTex;
		[SerializeField]
		private float errorPulseMaxScale;
		[SerializeField]
		private float errorPulseFrequency;
		[SerializeField]
		private AnimationCurve errorPulseCurve;
		[SerializeField]
		private float buttonPulseMaxScale;
		[SerializeField]
		private float buttonPulseMinScale;
		[SerializeField]
		private float buttonPulseFrequency;
		[SerializeField]
		private AnimationCurve buttonPulseCurve;
	}
}
