// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.Menu.TurntableChampionContainer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Utils;
using Imi.SteelCircus.Utils.Extensions;
using UnityEngine;
using UnityEngine.Rendering;

namespace SteelCircus.UI.Menu
{
  public class TurntableChampionContainer : MonoBehaviour
  {
    [SerializeField]
    private Transform championParentNode;
    [SerializeField]
    [Layer]
    private int turntableLayer;

    public void CreateChampion(ChampionConfig config, int skinIndex)
    {
      GameObject gameObject = Object.Instantiate<GameObject>(config.skins[skinIndex].prefab, this.championParentNode);
      gameObject.transform.SetToIdentity();
      gameObject.transform.localScale = Vector3.one * config.turntableModelScale;
      gameObject.name = "ChampionContainer-" + config.displayName;
      foreach (Renderer componentsInChild in gameObject.GetComponentsInChildren<Renderer>(true))
      {
        componentsInChild.lightProbeUsage = LightProbeUsage.Off;
        componentsInChild.reflectionProbeUsage = ReflectionProbeUsage.Off;
        componentsInChild.gameObject.layer = this.turntableLayer;
      }
    }

    public void CreateChampionFromPrefab(ChampionConfig config, GameObject prefab)
    {
      GameObject gameObject = Object.Instantiate<GameObject>(prefab, this.championParentNode);
      gameObject.transform.SetToIdentity();
      gameObject.transform.localScale = Vector3.one * config.turntableModelScale;
      gameObject.name = "ChampionContainer-" + config.displayName;
      foreach (Renderer componentsInChild in gameObject.GetComponentsInChildren<Renderer>(true))
      {
        componentsInChild.lightProbeUsage = LightProbeUsage.Off;
        componentsInChild.reflectionProbeUsage = ReflectionProbeUsage.Off;
        componentsInChild.gameObject.layer = this.turntableLayer;
      }
    }
  }
}
