// Decompiled with JetBrains decompiler
// Type: T1TrackingEventObject
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SteelCircus.Core.Services;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class T1TrackingEventObject : MonoBehaviour
{
  public Color TrackingEventT1Color;
  public Color TrackingEventT1TextColor;
  [SerializeField]
  private TextMeshProUGUI eventTxt;
  [SerializeField]
  private Image glowBackDrop;

  public void SetupEventUi(string eventText, Color color, Color textColor)
  {
    this.eventTxt.text = ImiServices.Instance.LocaService.GetLocalizedValue(eventText);
    this.eventTxt.fontSharedMaterial.SetColor(ShaderUtilities.ID_GlowColor, textColor);
    this.glowBackDrop.color = color;
  }

  public void SetupEventUiNew(string eventText)
  {
    this.eventTxt.text = ImiServices.Instance.LocaService.GetLocalizedValue(eventText);
    this.glowBackDrop.color = this.TrackingEventT1Color;
    this.eventTxt.fontSharedMaterial.SetColor(ShaderUtilities.ID_GlowColor, this.TrackingEventT1TextColor);
  }
}
