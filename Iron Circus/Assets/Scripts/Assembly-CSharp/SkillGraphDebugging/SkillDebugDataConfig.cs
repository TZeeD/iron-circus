using System.Collections.Generic;

namespace SkillGraphDebugging
{
	public class SkillDebugDataConfig : GameConfigEntry
	{
		public List<SkillGraphDebugVar> variableValueRefs;
		public List<SkillGraphDebugNode> nodes;
		public int debugStateSize;
		public List<SkillGraphDebugState> debugStates;
	}
}
