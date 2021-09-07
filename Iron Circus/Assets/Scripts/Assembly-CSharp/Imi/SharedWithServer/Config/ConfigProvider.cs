using Imi.SteelCircus.ScriptableObjects;

namespace Imi.SharedWithServer.Config
{
	public class ConfigProvider : GameConfigEntry
	{
		public string outputPath;
		public string serverJsonDir;
		public ColorsConfig colorsConfig;
		public LocalPlayerVisualSmoothingConfig visualSmoothingConfig;
		public FactionConfig factionConfig;
		public BallConfig ballConfig;
		public BumperConfig bumperConfig;
		public DebugConfig debugConfig;
		public MatchConfig matchConfig;
		public PhysicsEngineConfig physicsEngineConfig;
		public ChampionConfigProvider ChampionConfigProvider;
		public ChampionConfig bagpipes;
		public ChampionConfig servitor;
		public ChampionConfig li;
		public ChampionConfig mali;
		public ChampionConfig hildegard;
		public ChampionConfig acrid;
		public ChampionConfig galena;
		public ChampionConfig kenny;
		public ChampionConfig robot;
	}
}
