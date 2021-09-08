// Decompiled with JetBrains decompiler
// Type: AmplifyBloom.DemoFPSCounter
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.UI;

namespace AmplifyBloom
{
  public class DemoFPSCounter : MonoBehaviour
  {
    public float UpdateInterval = 0.5f;
    private Text m_fpsText;
    private float m_accum;
    private int m_frames;
    private float m_timeleft;
    private float m_fps;
    private string m_format;

    private void Start()
    {
      this.m_fpsText = this.GetComponent<Text>();
      this.m_timeleft = this.UpdateInterval;
    }

    private void Update()
    {
      this.m_timeleft -= Time.deltaTime;
      this.m_accum += Time.timeScale / Time.deltaTime;
      ++this.m_frames;
      if ((double) this.m_timeleft > 0.0)
        return;
      this.m_fps = this.m_accum / (float) this.m_frames;
      this.m_format = string.Format("{0:F2} FPS", (object) this.m_fps);
      this.m_fpsText.text = this.m_format;
      if ((double) this.m_fps < 50.0)
        this.m_fpsText.color = Color.yellow;
      else if ((double) this.m_fps < 30.0)
        this.m_fpsText.color = Color.red;
      else
        this.m_fpsText.color = Color.green;
      this.m_timeleft = this.UpdateInterval;
      this.m_accum = 0.0f;
      this.m_frames = 0;
    }
  }
}
