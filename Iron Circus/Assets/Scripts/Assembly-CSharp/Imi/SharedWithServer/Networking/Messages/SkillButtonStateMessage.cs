namespace Imi.SharedWithServer.Networking.Messages
{
	public class SkillButtonStateMessage : Message
	{
		public SkillButtonStateMessage() : base(default(RumpfieldMessageType))
		{
		}

		public int index;
		public bool isDown;
	}
}
