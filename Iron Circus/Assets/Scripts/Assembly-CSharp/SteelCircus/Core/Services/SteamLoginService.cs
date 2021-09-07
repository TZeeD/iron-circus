using UnityEngine;
using System;

namespace SteelCircus.Core.Services
{
	public class SteamLoginService
	{
		public SteamLoginService(MonoBehaviour coroutineRunner, Action<ulong> onLoginSuccessful, Action<string> onLoginError, Action<string> onClientVersionMismatch)
		{
		}

	}
}
