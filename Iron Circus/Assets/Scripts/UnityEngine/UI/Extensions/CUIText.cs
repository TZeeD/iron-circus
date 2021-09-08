// Decompiled with JetBrains decompiler
// Type: UnityEngine.UI.Extensions.CUIText
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

namespace UnityEngine.UI.Extensions
{
  [RequireComponent(typeof (RectTransform))]
  [RequireComponent(typeof (Text))]
  [AddComponentMenu("UI/Effects/Extensions/Curly UI Text")]
  public class CUIText : CUIGraphic
  {
    public override void ReportSet()
    {
      if ((Object) this.uiGraphic == (Object) null)
        this.uiGraphic = (Graphic) this.GetComponent<Text>();
      base.ReportSet();
    }
  }
}
