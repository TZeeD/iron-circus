using UnityEngine;

namespace ClockStone
{
	public class PoolableObject : MonoBehaviour
	{
		public int maxPoolSize;
		public int preloadCount;
		public bool doNotDestroyOnLoad;
		public bool sendAwakeStartOnDestroyMessage;
		public bool sendPoolableActivateDeactivateMessages;
		public bool useReflectionInsteadOfMessages;
	}
}
