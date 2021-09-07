using UnityEngine;
using System;

namespace SteelCircus.Core.Services
{
	public class DevLoginService
	{
		public DevLoginService(MonoBehaviour coroutineRunner, string username, Action<ulong> onLoginSuccessful, Action<string> onLoginError, Action<string> onClientVersionMismatch)
		{
		}

	}
}
