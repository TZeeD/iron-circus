using Imi.SharedWithServer.Game;
using UnityEngine;
using Imi.SteelCircus.UI.Config;

namespace Imi.SharedWithServer.Config
{
	public class ChampionConfig : GameConfigEntry
	{
		public ChampionType championType;
		public ChampionClass classType;
		public float colliderRadius;
		public int maxHealth;
		public float ballPickupRange;
		public float maxSpeed;
		public StaminaConfig stamina;
		public int uiDisplaySpeed;
		public float acceleration;
		public float deceleration;
		public float controlsThrusterContribution;
		public bool moveOnlyForward;
		public bool useTurnSpeed;
		public float turnSpeed;
		public SkillGraphConfig[] playerSkillGraphs;
		public Sprite icon;
		public Sprite dev_icon;
		public FactionConfig faction;
		public GameObject Champion3DIconPrefab;
		public float inGameModelScale;
		public SkinConfig[] skins;
		public float maxAimRotation;
		public float aimAnimRotationSpeed;
		public string[] aimRotationBones;
		public ChampionEmoteConfig emoteConfig;
		public VictoryPoseConfig victoryPoseConfig;
		public string displayName;
		[SerializeField]
		public string ballHoldHandName;
		public Vector3 ballHoldOffsetFromHand;
		public Vector3 uiAnchor;
		public string uiAnchorBoneName;
		public Vector3 uiAnchorBoneRestPos;
		public float uiAnchorBoneMinHeight;
		public float uiAnchorBoneInfluence;
		public float uiAnchorBoneSpringFrequency;
		public float turntableModelScale;
		public CameraSetting cameraFar;
		public CameraSetting cameraClose;
		public CameraSetting cameraMainMenu;
		public Vector2 shopIconTranslation;
		public float shopIconScale;
	}
}
