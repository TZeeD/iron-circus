using Imi.SharedWithServer.Config;
using SharedWithServer.ScEvents;
using Imi.SharedWithServer.ScEntitas;
using Imi.SteelCircus.Core;
using Entitas;
using Imi.SteelCircus.ScEntitas.Systems;

namespace SteelCircus.Core
{
	public class NetworkedWorldClient
	{
		public NetworkedWorldClient(ConfigProvider configProvider, Contexts contexts, Events events, GameEntityFactory gameEntityFactory, ClientTick ticker, int tickRate, Systems rollbackSystems, RemoteEntityLerpSystem remoteEntityLerpSystem)
		{
		}

	}
}
