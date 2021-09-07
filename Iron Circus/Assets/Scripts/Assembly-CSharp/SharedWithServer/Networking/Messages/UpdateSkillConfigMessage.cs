using Imi.SharedWithServer.Networking.Messages;

namespace SharedWithServer.Networking.Messages
{
	public class UpdateSkillConfigMessage : Message
	{
		public UpdateSkillConfigMessage() : base(default(RumpfieldMessageType))
		{
		}

		public string configName;
		public byte[] data;
	}
}
