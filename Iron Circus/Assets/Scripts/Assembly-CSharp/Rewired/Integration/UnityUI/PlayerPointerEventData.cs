using UnityEngine.EventSystems;

namespace Rewired.Integration.UnityUI
{
	public class PlayerPointerEventData : PointerEventData
	{
		public PlayerPointerEventData(EventSystem eventSystem) : base(default(EventSystem))
		{
		}

	}
}
