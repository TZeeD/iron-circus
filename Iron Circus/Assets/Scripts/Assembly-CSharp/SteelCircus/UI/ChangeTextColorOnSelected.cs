using UnityEngine;
using System.Collections.Generic;
using TMPro;

namespace SteelCircus.UI
{
	public class ChangeTextColorOnSelected : MonoBehaviour
	{
		public bool automaticallyDetermineColors;
		public List<TextMeshProUGUI> textObjects;
		public Color targetColor;
		public Color[] storedColors;
	}
}
