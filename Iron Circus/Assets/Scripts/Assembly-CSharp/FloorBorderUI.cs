using UnityEngine;

public class FloorBorderUI : MonoBehaviour
{
	[SerializeField]
	private Renderer borderMesh;
	[SerializeField]
	private Color outerColor;
	[SerializeField]
	private Color innerColor;
	[SerializeField]
	private Color outerColorOvertime;
	[SerializeField]
	private Color innerColorOvertime;
	[SerializeField]
	private Color outerColorWhenExpanded;
	[SerializeField]
	private Color innerColorWhenExpanded;
	[SerializeField]
	private AnimationCurve expansionColorLerp;
	[SerializeField]
	private float textSpeed;
	[SerializeField]
	private float bgSpeed;
	[SerializeField]
	private Texture2D lastMinuteTexture;
	[SerializeField]
	private Texture2D lastSecondsTexture;
	[SerializeField]
	private Texture2D overtimeGoldenGoalTexture;
	[SerializeField]
	private float showLastSecondsMessageAtTime;
	[SerializeField]
	private float expansionDuration;
	[SerializeField]
	private AnimationCurve expansionCurve;
	[SerializeField]
	private float stayDurationLastMinute;
	[SerializeField]
	private float stayDurationLastSeconds;
	[SerializeField]
	private float closeDuration;
}
