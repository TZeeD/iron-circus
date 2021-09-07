using Imi.SharedWithServer.Networking.Messages;

namespace Imi.Networking.Messages
{
	public class BeginBasicTrainingStepMessage : Message
	{
		public BeginBasicTrainingStepMessage() : base(default(RumpfieldMessageType))
		{
		}

		public byte step;
	}
}
