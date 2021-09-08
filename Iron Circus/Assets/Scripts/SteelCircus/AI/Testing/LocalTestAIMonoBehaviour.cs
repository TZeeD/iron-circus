// Decompiled with JetBrains decompiler
// Type: SteelCircus.AI.Testing.LocalTestAIMonoBehaviour
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game.AI;
using Imi.SteelCircus.Core;
using Imi.SteelCircus.GameElements;
using Imi.SteelCircus.JitterUnity;
using Jitter.LinearMath;
using UnityEngine;

namespace SteelCircus.AI.Testing
{
  public class LocalTestAIMonoBehaviour : MonoBehaviour
  {
    private bool show;
    private LocalTestAI ai;
    [SerializeField]
    private Transform aimDirTransform;
    [SerializeField]
    private MeshRenderer aimDirRenderer;
    private Vector3 currentAimDir = Vector3.forward;
    private bool holdDebugOutput;
    private string debugOutput;
    private AICache cache;

    public bool Show
    {
      get => this.show;
      set
      {
        this.show = value;
        this.aimDirTransform.gameObject.SetActive(this.show);
      }
    }

    private void Start()
    {
      this.cache = new AICache(Contexts.sharedInstance.game, StartupSetup.configProvider);
      this.ai = new LocalTestAI(this.GetComponentInParent<Player>().GameEntity, AIDifficulty.Intermediate, AIRole.Midfield, this.cache);
      this.ai.SetVisualizer(this);
    }

    private void OnDestroy() => this.ai.ShutDown();

    private void LateUpdate() => this.aimDirTransform.rotation = Quaternion.LookRotation(this.currentAimDir);

    private void Update()
    {
      if (!Input.GetKeyDown(KeyCode.O))
        return;
      this.holdDebugOutput = !this.holdDebugOutput;
    }

    private void OnGUI()
    {
      GUIStyle style = new GUIStyle(GUI.skin.textArea);
      style.richText = true;
      if (!this.holdDebugOutput)
        this.debugOutput = this.ai.GetDebugOutput();
      GUI.TextArea(new Rect(25f, 25f, 250f, 500f), this.debugOutput, style);
      this.holdDebugOutput = GUI.Toggle(new Rect(25f, 530f, 250f, 30f), this.holdDebugOutput, "Hold (o).");
    }

    public void Clear() => this.aimDirTransform.localScale = Vector3.one * 0.01f;

    public void SetAimDir(JVector aimDir, float charge = 1f, float confidence = 1f)
    {
      this.aimDirTransform.localScale = new Vector3(0.1f, 1f, (double) charge >= 0.5 ? ((double) charge == 1.0 ? 10f : 5f) : 2.5f);
      this.currentAimDir = aimDir.ToVector3();
      this.aimDirRenderer.material.color = (double) confidence > 0.200000002980232 ? ((double) confidence > 0.5 ? ((double) confidence > 0.899999976158142 ? Color.white : Color.green) : Color.yellow) : Color.red;
    }
  }
}
