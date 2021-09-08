// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.ScEntitas.Systems.DebugDrawSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.ScEntitas;
using Imi.SharedWithServer.ScEntitas.Systems;
using Imi.SteelCircus.JitterUnity;
using UnityEngine;

namespace Imi.SteelCircus.ScEntitas.Systems
{
  public class DebugDrawSystem : ExecuteGameSystem
  {
    public JBoundingBoxDebugDrawer DebugDrawer = new JBoundingBoxDebugDrawer();
    private DebugConfig debugConfig;
    private Color colorDefault = new Color(0.0f, 0.65f, 0.0f);
    private Color colorKinematic = new Color(0.0f, 0.45f, 0.0f);
    private Color colorTrigger = new Color(0.1f, 0.6f, 0.7f);
    private Color colorStatic = new Color(0.8f, 0.5f, 0.2f);

    public DebugDrawSystem(EntitasSetup entitasSetup)
      : base(entitasSetup)
    {
      this.DebugDrawer.color = Color.green;
      this.debugConfig = entitasSetup.ConfigProvider.debugConfig;
    }

    protected override void GameExecute()
    {
    }
  }
}
