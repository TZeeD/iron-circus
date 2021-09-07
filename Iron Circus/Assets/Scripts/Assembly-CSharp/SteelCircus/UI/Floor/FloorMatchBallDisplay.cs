using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI.Floor
{
	public class FloorMatchBallDisplay : MonoBehaviour
	{
		[SerializeField]
		private RawImage circleBG;
		[SerializeField]
		private Transform textParent;
		[SerializeField]
		private RawImage circleFG;
		[SerializeField]
		private float buildUpDuration;
		[SerializeField]
		private AnimationCurve circleBuildUpCurve;
		[SerializeField]
		private AnimationCurve textBuildUpCurve;
		[SerializeField]
		private AnimationCurve fgBuildUpCurve;
		[SerializeField]
		private AnimationCurve fgAlphaCurve;
		[SerializeField]
		private AnimationCurve textRotationCurve;
		[SerializeField]
		private float textRotationSpeed;
		[SerializeField]
		private Color bgColorAlpha;
		[SerializeField]
		private Color fgColorAlpha;
		[SerializeField]
		private Color textColorAlpha;
		[SerializeField]
		private Color bgColorBeta;
		[SerializeField]
		private Color fgColorBeta;
		[SerializeField]
		private Color textColorBeta;
		[SerializeField]
		private Color bgColorTie;
		[SerializeField]
		private Color fgColorTie;
		[SerializeField]
		private Color textColorTie;
	}
}
