using System;
using UnityEngine;

namespace Imi.SharedWithServer.Config
{
	[Serializable]
	public class CameraSetting
	{
		public Vector3 position;
		public Vector3 rotation;
		public float fov;
	}
}
