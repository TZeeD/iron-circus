// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.ui.UIScreenState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using UnityEngine;
using UnityEngine.UI;

namespace Imi.SteelCircus.ui
{
  [Serializable]
  public class UIScreenState
  {
    public Button[] enterButtons;
    public AnimationClip animation;
    public Button selectOnEnter;
    public UIScreenState previousState;
    public Selectable lastSelected;
  }
}
