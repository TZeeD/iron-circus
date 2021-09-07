using System;
using Imi.SharedWithServer.Game;
using UnityEngine;

[Serializable]
public class LoadoutData
{
	public ChampionType type;
	public int skinId;
	public int victoryPose;
	public int goalAnimation;
	public int[] sprays;
	public int[] emotes;
	public GameObject skinAsset;
	public AnimationClip victoryPoseAsset;
	public AnimationClip goalAnimationAssets;
	public GameObject[] sprayAssets;
	public AnimationClip[] emoteAssets;
}
