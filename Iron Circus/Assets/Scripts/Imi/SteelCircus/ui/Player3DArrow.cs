// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.UI.Player3DArrow
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace Imi.SteelCircus.UI
{
  public class Player3DArrow : MonoBehaviour
  {
    public Transform rotationParent;
    public float rotationDegPerSecond = 360f;
    private float rotationCounter;

    private void Update()
    {
      this.rotationCounter += this.rotationDegPerSecond * Time.deltaTime;
      this.rotationCounter %= 360f;
      this.rotationParent.eulerAngles = new Vector3(0.0f, this.rotationCounter, 0.0f);
    }
  }
}
