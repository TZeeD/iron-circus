using UnityEngine;
using Imi.SteelCircus.ScriptableObjects;
using Imi.SteelCircus.UI.Floor.Player;

namespace Imi.SteelCircus.UI.Floor
{
	public class PlayerFloorUI : MonoBehaviour
	{
		public ColorsConfig colorsConfig;
		public float switchChargeDisplayDuration;
		public AnimationCurve switchChargeDisplayCurve;
		public float skillDisplayScaleWhenCharging;
		public float playerDirectionArrowOffset;
		public float playerDirectionArrowHeight;
		[SerializeField]
		private GameObject regularDisplayParent;
		[SerializeField]
		private GameObject minimizedDisplayParent;
		[SerializeField]
		private GameObject scrambledDisplayParent;
		[SerializeField]
		private PlayerFloorSkillDisplay skillDisplay;
		[SerializeField]
		private PlayerFloorHealthDisplay healthDisplay;
		[SerializeField]
		private PlayerFloorOuterRingDisplay outerRingDisplay;
		[SerializeField]
		private PlayerFloorBallCatchDisplay ballCatchDisplay;
		[SerializeField]
		private PlayerFloorPingDisplay pingDisplay;
		[SerializeField]
		private SpriteRenderer playerDirectionArrow;
		[SerializeField]
		private Transform ballDirectionArrow;
		[SerializeField]
		private Transform playerDirection;
		[SerializeField]
		private Transform chargeRingParent;
		[SerializeField]
		private Renderer chargeRing;
		[SerializeField]
		private SpriteRenderer ballThrowDistanceArrow;
		[SerializeField]
		private Transform goalDirection;
		[SerializeField]
		private Renderer goalDirectionRenderer;
		[SerializeField]
		private Renderer outerCircleDark;
		[SerializeField]
		private Renderer outerCircleLight;
		[SerializeField]
		private Renderer innerCircleRegular;
		[SerializeField]
		private Renderer innerCircleMinimized;
		[SerializeField]
		private Renderer mainCircleBG;
		[SerializeField]
		private Renderer skillDisplayCircleBG;
		[SerializeField]
		private Transform[] rotatingWithPlayer;
		[SerializeField]
		private GameObject directionToOthersPrefab;
		[SerializeField]
		private Transform directionsToOthers;
		[SerializeField]
		private int MaxLineThicknessAtDistanceToOthers;
		[SerializeField]
		private int MinLineThicknessAtDistanceToOthers;
		public float debugCharge;
	}
}
