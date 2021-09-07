using System;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Config
{
	[Serializable]
	public struct SerializedSkillGraphInfo
	{
		public string name;
		public int sizeInBytes;
		public int numDirtyBytes;
		public int numSyncActions;
		public List<SerializedSyncValueInfo> serializedSyncValueInfos;
	}
}
