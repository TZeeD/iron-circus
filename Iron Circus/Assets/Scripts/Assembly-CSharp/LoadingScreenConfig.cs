using UnityEngine;
using Imi.SharedWithServer.Config;

public class LoadingScreenConfig : GameConfigEntry
{
	public Color leftColor;
	public Color rightColor;
	public ChampionConfig champion;
	public Sprite loadingScreenTexture;
	public Vector3 textPosition;
}
