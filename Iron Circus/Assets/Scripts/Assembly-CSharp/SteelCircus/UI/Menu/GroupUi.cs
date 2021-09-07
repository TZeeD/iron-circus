using UnityEngine;
using System;
using UnityEngine.UI;
using TMPro;

namespace SteelCircus.UI.Menu
{
	public class GroupUi : MonoBehaviour
	{
		[Serializable]
		public struct GroupUiObject
		{
			public Text username;
			public ulong userId;
			public TextMeshProUGUI userlevel;
			public GameObject groupContainer;
			public GameObject groupLeaderIcon;
			public SwitchAvatarIcon avatarObject;
		}

		public GameObject buttonPromptObject;
		[SerializeField]
		public Text ownPlayerName;
		[SerializeField]
		private TextMeshProUGUI ownPlayerLevel;
		[SerializeField]
		public GameObject ownContainer;
		[SerializeField]
		public GameObject ownGroupLeaderIcon;
		[SerializeField]
		private GameObject container;
		[SerializeField]
		private GameObject leaveBtn;
		[SerializeField]
		private GameObject inviteBtn;
		[SerializeField]
		public GroupUiObject[] groupContainers;
	}
}
