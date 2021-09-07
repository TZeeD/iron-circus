using UnityEngine;

namespace Imi.SteelCircus.Controls
{
	public class InputLayoutConfig : GameConfigEntry
	{
		[SerializeField]
		private KeyCode ROTATE_X_KEY;
		[SerializeField]
		private KeyCode ROTATE_Y_KEY;
		[SerializeField]
		private KeyCode MOVE_X_KEY;
		[SerializeField]
		private KeyCode MOVE_Y_KEY;
		[SerializeField]
		private KeyCode JUMP_KEY;
		[SerializeField]
		private KeyCode BOOST_KEY;
		[SerializeField]
		private KeyCode HIT_KEY;
	}
}
