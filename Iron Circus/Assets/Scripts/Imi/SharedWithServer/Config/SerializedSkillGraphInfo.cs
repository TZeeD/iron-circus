// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Config.SerializedSkillGraphInfo
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Config
{
  [Serializable]
  public struct SerializedSkillGraphInfo
  {
    public string name;
    public int sizeInBytes;
    public int numDirtyBytes;
    public int numSyncActions;
    public List<SerializedSyncValueInfo> serializedSyncValueInfos;
  }
}
