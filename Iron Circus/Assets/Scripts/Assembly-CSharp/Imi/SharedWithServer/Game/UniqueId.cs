using System;
using UnityEngine;

namespace Imi.SharedWithServer.Game
{
	[Serializable]
	public struct UniqueId
	{
		public UniqueId(ushort id) : this()
		{
		}

		[SerializeField]
		private ushort id;
	}
}
