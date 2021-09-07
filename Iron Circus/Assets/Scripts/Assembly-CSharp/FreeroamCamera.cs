using UnityEngine;

public class FreeroamCamera : MonoBehaviour
{
	public float MoveSpeed;
	public float LookSpeed;
	public bool IsFollowingPlayer;
	public bool IsCameraMovementLocked;
	public bool IsCameraRotationLocked;
	public bool IsControllingPlayer;
	public bool IsSpectatorCamera;
	public bool LookAtPlayer;
	public bool LookAtPlayerFace;
	public FreeroamCameraManager Manager;
	public string ActiveCharacter;
	public string ActiveCameraPose;
}
