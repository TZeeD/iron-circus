using UnityEngine;

public class TiltedLayout : MonoBehaviour
{
	public enum HowToGetObjects
	{
		byChildren = 0,
		byList = 1,
	}

	public int angle;
	public int spacing;
	public GameObject[] buttons;
	public HowToGetObjects howToGetObjects;
}
