using System.IO;
using System.Text;

namespace Imi.SteelCircus.Utils
{
	public class ConsoleToDebug : TextWriter
	{
		public override Encoding Encoding
		{
			get { return default(Encoding); }
		}

	}
}
