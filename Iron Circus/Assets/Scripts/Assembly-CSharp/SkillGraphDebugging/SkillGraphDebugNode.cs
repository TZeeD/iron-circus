using System;
using System.Collections.Generic;

namespace SkillGraphDebugging
{
	[Serializable]
	public struct SkillGraphDebugNode
	{
		public string displayName;
		public List<SkillGraphDebugPlug> inPlugs;
		public List<SkillGraphDebugPlug> outPlugs;
		public List<SkillGraphDebugPlug> subStates;
		public List<SkillGraphDebugVar> nodeVariables;
	}
}
