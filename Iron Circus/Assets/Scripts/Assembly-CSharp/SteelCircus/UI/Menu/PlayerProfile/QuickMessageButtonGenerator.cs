using UnityEngine;
using System.Collections.Generic;
using SteelCircus.UI;
using UnityEngine.UI;

namespace SteelCircus.UI.Menu.PlayerProfile
{
	public class QuickMessageButtonGenerator : MonoBehaviour
	{
		public GameObject quickMessageButtonPrefab;
		public GameObject buttonContainerParent;
		public QuickMessageEquipWheel buttonEquipWheel;
		public List<GameObject> allButtons;
		public ScrollThroughButtons buttonScroller;
		public Button returnToListButton;
	}
}
