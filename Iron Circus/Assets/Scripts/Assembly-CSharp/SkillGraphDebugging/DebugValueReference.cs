using System;
using Imi.SharedWithServer.Game.Skills;

namespace SkillGraphDebugging
{
	[Serializable]
	public struct DebugValueReference
	{
		public int idx;
		public SyncableValueType type;
	}
}
