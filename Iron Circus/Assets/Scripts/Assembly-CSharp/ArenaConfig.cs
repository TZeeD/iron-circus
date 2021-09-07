using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

public class ArenaConfig : ScriptableObject
{
	public string arenaSceneName;
	public string environmentSceneName;
	public Material skybox;
	public Material cameraSkybox;
	public Material floorNormals;
	public float cameraNearPlane;
	public float cameraFarPlane;
	public Cubemap reflectionProbe;
	public PostProcessProfile profile;
	public PostProcessProfile colorGrading;
	public GameObject IntroCamera;
	public GameObject VictoryCameras;
	public GameObject GoalCameras;
}
