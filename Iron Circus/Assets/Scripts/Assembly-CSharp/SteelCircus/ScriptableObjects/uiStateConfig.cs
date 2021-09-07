using System;
using SteelCircus.Core.Services;

namespace SteelCircus.ScriptableObjects
{
	[Serializable]
	public class uiStateConfig
	{
		public string stateName;
		public UIProgressionState uiState;
		public UIProgressionButtonState playButtonState;
		public UIProgressionButtonState quickMatchButtonState;
		public UIProgressionButtonState trainingsGroundButtonState;
		public UIProgressionButtonState botMatchButtonState;
		public UIProgressionButtonState rankedMatchButtonState;
		public UIProgressionButtonState customMatchButtonState;
		public UIProgressionButtonState freeTrainingButtonState;
	}
}
