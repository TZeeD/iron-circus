using System;
using System.Collections.Generic;

namespace SkillGraphDebugging
{
	[Serializable]
	public struct SkillGraphDebugPlug
	{
		public string displayName;
		public List<PlugAddress> targets;
	}
}
