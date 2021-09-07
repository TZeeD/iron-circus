using UnityEngine;
using System.Collections.Generic;

namespace Imi.SteelCircus.GameElements
{
	public class Player : MonoBehaviour
	{
		[SerializeField]
		private GameObject stunnedEffectPrefab;
		[SerializeField]
		private GameObject gainHealthEffectPrefab;
		[SerializeField]
		private GameObject gainRechargeEffectPrefab;
		[SerializeField]
		private GameObject gainSprintEffectPrefab;
		[SerializeField]
		private GameObject dodgeEffectPrefab;
		[SerializeField]
		private GameObject viewContainer;
		[SerializeField]
		private AudioSource playerAudioSource;
		[SerializeField]
		private Material deathMat;
		[SerializeField]
		private MaterialManager materialManager;
		[SerializeField]
		private float deathDuration;
		[SerializeField]
		private List<Transform> aimBones;
	}
}
