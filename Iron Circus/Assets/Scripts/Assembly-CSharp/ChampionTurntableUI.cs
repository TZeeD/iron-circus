using UnityEngine;
using Imi.SharedWithServer.Config;

public class ChampionTurntableUI : MonoBehaviour
{
	public enum CameraMode
	{
		FullBody = 0,
		Portrait = 1,
		ChampionGallery = 2,
		None = 3,
	}

	public CameraMode cameraMode;
	public Camera renderCam;
	[SerializeField]
	private CameraSetting championGalleryCameraSetting;
	[SerializeField]
	private GameObject iconPrefab;
	[SerializeField]
	private GameObject iconDisplayPlane;
	[SerializeField]
	private Vector2 sprayDisplayScale;
	public Transform championTurntablePivot;
	[SerializeField]
	private Transform[] teamMemberChampionPositions;
	[SerializeField]
	private GameObject championTurntablePrefab;
	[SerializeField]
	private Vector3 championInitialRotation;
	[SerializeField]
	private Animation lobbyFlash;
	[SerializeField]
	private GameObject galleryMenuLighting;
	public bool playGalleryEmote;
}
