// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Networking.SteelClientConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace Imi.SteelCircus.Networking
{
  [CreateAssetMenu(fileName = "SteelClientConfig", menuName = "SteelCircus/Configs/Create Steel Client Config")]
  public class SteelClientConfig : ScriptableObject
  {
    public string clientName = "Rumpfield";
    public ulong clientId;
    public string serverIp = "127.0.0.1";
    public int port = 40000;
  }
}
