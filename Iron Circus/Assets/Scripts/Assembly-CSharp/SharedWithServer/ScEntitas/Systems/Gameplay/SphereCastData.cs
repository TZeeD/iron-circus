using System;
using Jitter.LinearMath;

namespace SharedWithServer.ScEntitas.Systems.Gameplay
{
	[Serializable]
	public struct SphereCastData
	{
		public JVector origin;
		public JVector castDir;
		public float checkDistance;
		public JVector deNormal;
		public JVector deOrigin;
		public JVector deCastDir;
		public float deCheckDistance;
		public JVector contactPosition;
		public JVector contactPoint;
		public JVector reflectedDirection;
		public JVector normal;
		public float reflectedLength;
	}
}
