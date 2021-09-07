namespace Imi.SharedWithServer.Networking.Netcode.Core
{
	public enum NetcodeClientState
	{
		ConnectTokenExpired = -6,
		InvalidConnectToken = -5,
		ConnectionTimedOut = -4,
		ChallengeResponseTimedOut = -3,
		ConnectionRequestTimedOut = -2,
		ConnectionDenied = -1,
		Disconnected = 0,
		SendingConnectionRequest = 1,
		SendingChallengeResponse = 2,
		Connected = 3,
	}
}
