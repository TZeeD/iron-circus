// Decompiled with JetBrains decompiler
// Type: ChampionConfigProvider
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game;
using System;
using System.Collections.Generic;
using System.Linq;

public class ChampionConfigProvider : SingletonScriptableObject<ChampionConfigProvider>
{
  public List<ChampionConfigProvider.ChampionConfigUiInfo> championConfigs;
  public int highestColumnCount;

  public ChampionConfig GetChampionConfigFor(ChampionType championType)
  {
    ChampionConfig championConfig1 = (ChampionConfig) null;
    foreach (ChampionConfigProvider.ChampionConfigUiInfo championConfig2 in this.championConfigs)
    {
      if (championConfig2.ChampionConfig.championType == championType)
        championConfig1 = championConfig2.ChampionConfig;
    }
    return !((UnityEngine.Object) championConfig1 == (UnityEngine.Object) null) ? championConfig1 : throw new Exception(string.Format("No ChampionConfig found in ConfigProvider for ChampionType: '{0}'", (object) championType));
  }

  public ChampionConfigProvider.ChampionConfigUiInfo GetChampionConfigUiInfoFor(
    ChampionType championType)
  {
    ChampionConfigProvider.ChampionConfigUiInfo championConfigUiInfo = (ChampionConfigProvider.ChampionConfigUiInfo) null;
    foreach (ChampionConfigProvider.ChampionConfigUiInfo championConfig in this.championConfigs)
    {
      if (championConfig.ChampionConfig.championType == championType)
        championConfigUiInfo = championConfig;
    }
    return championConfigUiInfo != null ? championConfigUiInfo : throw new Exception(string.Format("No ChampionConfig found in ConfigProvider for ChampionType: '{0}'", (object) championType));
  }

  public ChampionConfig GetChampionConfigFor(string championName)
  {
    foreach (ChampionConfigProvider.ChampionConfigUiInfo championConfig in this.championConfigs)
    {
      if (championConfig.ChampionConfig.championType.ToString().ToLower() == championName)
        return championConfig.ChampionConfig;
    }
    return (ChampionConfig) null;
  }

  private void OnValidate()
  {
    int[] numArray = new int[3];
    foreach (ChampionConfigProvider.ChampionConfigUiInfo championConfig in this.championConfigs)
    {
      if (championConfig.UiPosition == ChampionConfigProvider.ChampionButtonUiPosition.firstRow)
        ++numArray[0];
      if (championConfig.UiPosition == ChampionConfigProvider.ChampionButtonUiPosition.secondRow)
        ++numArray[1];
      if (championConfig.UiPosition == ChampionConfigProvider.ChampionButtonUiPosition.thirdRow)
        ++numArray[2];
    }
    this.highestColumnCount = ((IEnumerable<int>) numArray).Max();
  }

  [Serializable]
  public class ChampionConfigUiInfo
  {
    public ChampionConfig ChampionConfig;
    public bool IsActive;
    public ChampionConfigProvider.ChampionButtonUiPosition UiPosition;

    public ChampionConfigUiInfo(ChampionConfig championConfig) => this.ChampionConfig = championConfig;

    public override bool Equals(object obj) => (UnityEngine.Object) this.ChampionConfig == (UnityEngine.Object) (obj as ChampionConfigProvider.ChampionConfigUiInfo).ChampionConfig;

    public override int GetHashCode() => (int) ((ChampionConfigProvider.ChampionButtonUiPosition) ((((UnityEngine.Object) this.ChampionConfig != (UnityEngine.Object) null ? this.ChampionConfig.GetHashCode() : 0) * 397 ^ this.IsActive.GetHashCode()) * 397) ^ this.UiPosition);
  }

  public enum ChampionButtonUiPosition
  {
    dontRender,
    firstRow,
    secondRow,
    thirdRow,
  }
}
