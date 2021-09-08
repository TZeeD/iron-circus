// Decompiled with JetBrains decompiler
// Type: DebugRazerEffectPreview
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using UnityEngine;

public class DebugRazerEffectPreview : MonoBehaviour
{
  public void OnGUI()
  {
    GUILayout.FlexibleSpace();
    GUILayout.BeginHorizontal(GUILayout.Width((float) Screen.width));
    GUILayout.FlexibleSpace();
    if (this.ShowHeader(1))
    {
      GUILayout.BeginVertical(GUILayout.Height((float) Screen.height));
      GUILayout.FlexibleSpace();
    }
    if (GUILayout.Button("Default", GUILayout.Height(40f)))
      RazerChromaHelper.ExecuteRazerAnimationForTeam(Team.None);
    if (GUILayout.Button("Alpha", GUILayout.Height(40f)))
      RazerChromaHelper.ExecuteRazerAnimationForTeam(Team.Alpha);
    if (GUILayout.Button("Beta", GUILayout.Height(40f)))
      RazerChromaHelper.ExecuteRazerAnimationForTeam(Team.Beta);
    for (int index = 1; index < 11; ++index)
    {
      if (GUILayout.Button(this.GetEffectName(index), GUILayout.Height(40f)))
        RazerChromaHelper.ExecuteRazerAnimation(index);
    }
    if (this.ShowFooter(10))
    {
      GUILayout.FlexibleSpace();
      GUILayout.EndVertical();
    }
    GUILayout.FlexibleSpace();
    GUILayout.EndHorizontal();
    GUILayout.FlexibleSpace();
  }

  private string GetEffectName(int index) => string.Format("Effect{0}", (object) index);

  private bool ShowHeader(int index) => index == 1;

  private bool ShowFooter(int index) => index == 10;
}
