using UnityEngine;
using System.Collections.Generic;

public class StandalonePlayerLoadoutConfig : ScriptableObject
{
	public int defaultAvatar;
	public ulong[] defaultSprays;
	public List<LoadoutData> defaultItemList;
	public LoadoutData robotLoadout;
}
