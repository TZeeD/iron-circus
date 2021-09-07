using UnityEngine;

namespace SteelCircus.ScriptableObjects
{
	public class MainMenuLightingConfig : ScriptableObject
	{
		public Material MainMenuSkybox;
		public Cubemap MainMenuReflectionProbe;
		public Material LobbySkybox;
		public Cubemap LobbyReflectionProbe;
		public Material GallerySkybox;
		public Cubemap GalleryReflectionProbe;
	}
}
