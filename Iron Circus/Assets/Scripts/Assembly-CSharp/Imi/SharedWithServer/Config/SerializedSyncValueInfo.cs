using System;
using Imi.SharedWithServer.Game.Skills;

namespace Imi.SharedWithServer.Config
{
	[Serializable]
	public struct SerializedSyncValueInfo
	{
		public string name;
		public SyncableValueType type;
		public int size;
		public int index;
	}
}
