// Decompiled with JetBrains decompiler
// Type: AnimationEventHandler
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

public class AnimationEventHandler : MonoBehaviour
{
  public void SetObjectVisibility(string args)
  {
    string str = this.GetValue(args, "name");
    bool flag = this.GetValue(args, "show").Equals("true");
    ObjectTag[] componentsInChildren = this.gameObject.GetComponentsInChildren<ObjectTag>(true);
    if (componentsInChildren == null)
      return;
    foreach (ObjectTag objectTag in componentsInChildren)
    {
      if (objectTag.Tag == str)
        objectTag.gameObject.SetActive(flag);
    }
  }

  private string GetValue(string args, string valueName)
  {
    int startIndex = args.IndexOf(valueName + "=") + valueName.Length + 1;
    int index = startIndex;
    int length = 0;
    while (args.Length >= index + 1 && args[index] != ',')
    {
      ++index;
      ++length;
    }
    return args.Substring(startIndex, length);
  }
}
