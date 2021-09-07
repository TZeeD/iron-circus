using ClockStone;
using UnityEngine;

public class AudioController : SingletonMonoBehaviour<AudioController>
{
	public GameObject AudioObjectPrefab;
	public bool Persistent;
	public bool UnloadAudioClipsOnDestroy;
	public bool UsePooledAudioObjects;
	public bool PlayWithZeroVolume;
	public bool EqualPowerCrossfade;
	public float musicCrossFadeTime;
	public float ambienceSoundCrossFadeTime;
	public bool specifyCrossFadeInAndOutSeperately;
	[SerializeField]
	private float _musicCrossFadeTime_In;
	[SerializeField]
	private float _musicCrossFadeTime_Out;
	[SerializeField]
	private float _ambienceSoundCrossFadeTime_In;
	[SerializeField]
	private float _ambienceSoundCrossFadeTime_Out;
	public AudioCategory[] AudioCategories;
	public Playlist[] musicPlaylists;
	public string[] musicPlaylist;
	public bool loopPlaylist;
	public bool shufflePlaylist;
	public bool crossfadePlaylist;
	public float delayBetweenPlaylistTracks;
	[SerializeField]
	private bool _isAdditionalAudioController;
	[SerializeField]
	private bool _audioDisabled;
	[SerializeField]
	private float _volume;
	public AudioController_CurrentInspectorSelection _currentInspectorSelection;
}
