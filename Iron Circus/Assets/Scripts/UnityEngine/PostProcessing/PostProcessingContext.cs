// Decompiled with JetBrains decompiler
// Type: UnityEngine.PostProcessing.PostProcessingContext
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

namespace UnityEngine.PostProcessing
{
  public class PostProcessingContext
  {
    public PostProcessingProfile profile;
    public Camera camera;
    public MaterialFactory materialFactory;
    public RenderTextureFactory renderTextureFactory;

    public bool interrupted { get; private set; }

    public void Interrupt() => this.interrupted = true;

    public PostProcessingContext Reset()
    {
      this.profile = (PostProcessingProfile) null;
      this.camera = (Camera) null;
      this.materialFactory = (MaterialFactory) null;
      this.renderTextureFactory = (RenderTextureFactory) null;
      this.interrupted = false;
      return this;
    }

    public bool isGBufferAvailable => this.camera.actualRenderingPath == RenderingPath.DeferredShading;

    public bool isHdr => this.camera.allowHDR;

    public int width => this.camera.pixelWidth;

    public int height => this.camera.pixelHeight;

    public Rect viewport => this.camera.rect;
  }
}
