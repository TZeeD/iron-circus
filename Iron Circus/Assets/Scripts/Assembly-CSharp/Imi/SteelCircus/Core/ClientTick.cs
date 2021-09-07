using Imi.SteelCircus.Networking;

namespace Imi.SteelCircus.Core
{
	public class ClientTick
	{
		public delegate void OnTickDelegate(int tick,float timeSinceStart);

		public ClientTick(ClockSync clockSync, ISystemHelper systemHelper, ClientTick.OnTickDelegate onTick, bool useDebugLog)
		{
		}

	}
}
