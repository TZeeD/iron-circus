using System.Collections.Generic;

namespace SteelCircus.ScriptableObjects
{
	public class UIProgressionConfig : SingletonScriptableObject<UIProgressionConfig>
	{
		public List<uiStateConfig> uiStates;
	}
}
