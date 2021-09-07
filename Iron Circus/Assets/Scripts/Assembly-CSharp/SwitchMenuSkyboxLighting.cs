using UnityEngine;

public class SwitchMenuSkyboxLighting : MonoBehaviour
{
	[SerializeField]
	private MainMenuLightingType type;
	[SerializeField]
	private Material customSkyBox;
	[SerializeField]
	private Cubemap customReflectionProbe;
}
