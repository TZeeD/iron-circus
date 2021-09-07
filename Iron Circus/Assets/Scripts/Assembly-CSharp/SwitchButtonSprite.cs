using UnityEngine;
using Imi.SteelCircus.Controls;
using System.Collections.Generic;

public class SwitchButtonSprite : MonoBehaviour
{
	public DigitalInput actionType;
	public List<DigitalInput> optionalFallbackActionTypes;
	public bool hideForKBM;
}
