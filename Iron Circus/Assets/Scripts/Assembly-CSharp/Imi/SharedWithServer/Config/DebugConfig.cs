using UnityEngine;

namespace Imi.SharedWithServer.Config
{
	public class DebugConfig : GameConfigEntry
	{
		public int numLocalPlayers;
		public bool skipCutscenes;
		public bool useClientPrediction;
		public bool useSnapshotInterpolation;
		public bool debugDrawObjects;
		public bool disableVisualSmoothing;
		public bool useNewVisualSmoothing;
		public bool showServerProxies;
		public bool updateSkillsNetworked;
		public bool overrideRemoteLerpSettings;
		public float remoteLerpOffsetInSeconds;
		public float remoteLerpWeightBlendDurationInSeconds;
		public Color debugDrawColor;
	}
}
