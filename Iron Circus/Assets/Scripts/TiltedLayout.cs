// Decompiled with JetBrains decompiler
// Type: TiltedLayout
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Collections;
using UnityEngine;

public class TiltedLayout : MonoBehaviour
{
  public int angle;
  public int spacing;
  public GameObject[] buttons;
  public TiltedLayout.HowToGetObjects howToGetObjects;

  public void TranslateElements()
  {
    float num1 = 0.0f;
    switch (this.howToGetObjects)
    {
      case TiltedLayout.HowToGetObjects.byChildren:
        IEnumerator enumerator = this.transform.GetEnumerator();
        try
        {
          while (enumerator.MoveNext())
          {
            Transform current = (Transform) enumerator.Current;
            if (current.gameObject.activeInHierarchy)
            {
              float num2 = Mathf.Tan((float) (90 - this.angle) * ((float) Math.PI / 180f));
              float num3 = num1 / num2;
              current.GetComponent<RectTransform>().anchoredPosition = new Vector2(num3 * -1f, num1 * -1f);
              num1 = num1 + current.GetComponent<RectTransform>().sizeDelta.y + (float) this.spacing;
            }
          }
          break;
        }
        finally
        {
          if (enumerator is IDisposable disposable3)
            disposable3.Dispose();
        }
      case TiltedLayout.HowToGetObjects.byList:
        foreach (GameObject button in this.buttons)
        {
          if (button.activeInHierarchy)
          {
            float num4 = Mathf.Tan((float) (90 - this.angle) * ((float) Math.PI / 180f));
            float num5 = num1 / num4;
            button.GetComponent<RectTransform>().anchoredPosition = new Vector2(num5 * -1f, num1 * -1f);
            num1 = num1 + button.GetComponent<RectTransform>().sizeDelta.y + (float) this.spacing;
          }
        }
        break;
    }
  }

  public enum HowToGetObjects
  {
    byChildren,
    byList,
  }
}
