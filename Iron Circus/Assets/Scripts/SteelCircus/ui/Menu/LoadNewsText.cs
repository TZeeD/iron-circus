// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.Menu.LoadNewsText
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.UI.Network;
using Newtonsoft.Json.Linq;
using SteelCircus.Core.Services;
using System;
using System.Collections;
using TMPro;
using UnityEngine;

namespace SteelCircus.UI.Menu
{
  public class LoadNewsText : MonoBehaviour
  {
    [SerializeField]
    private TextMeshProUGUI mainMenuNewsText;
    [SerializeField]
    private TextMeshProUGUI mainMenuNewsHeader;
    [SerializeField]
    private GameObject loadingIcon;

    private void Start() => SingletonManager<MetaServiceHelpers>.Instance.StartCoroutine(this.GetNewsAfterLogin());

    public void OnGetMainMenuNewsText(JObject obj)
    {
      if (obj == null || obj["error"] != null || obj["msg"] != null)
      {
        string text = "<size=90%>The game is still in active development which means you will encounter bugs, instabilities, and possible gameplay changes in the future. We love feedback and are excited to hear your thoughts!</size>";
        this.loadingIcon.SetActive(false);
        this.mainMenuNewsText.gameObject.SetActive(true);
        this.SetMainMenuNewsText("WELCOME!", text);
      }
      else
      {
        this.loadingIcon.SetActive(false);
        this.mainMenuNewsText.gameObject.SetActive(true);
        string[] strArray = obj["newsText"].ToString().Split(new string[1]
        {
          "</style>"
        }, StringSplitOptions.None);
        this.SetMainMenuNewsText(strArray[0].Replace("<style=\"Title\">", ""), strArray[1].Replace("\\n", "\n"));
      }
    }

    public void SetMainMenuNewsText(string headerText, string text)
    {
      this.mainMenuNewsHeader.text = headerText;
      this.mainMenuNewsText.text = text;
    }

    public IEnumerator GetNewsAfterLogin()
    {
      LoadNewsText loadNewsText = this;
      yield return (object) new WaitUntil((Func<bool>) (() => ImiServices.Instance.LoginService.IsLoginOk()));
      SingletonManager<MetaServiceHelpers>.Instance.StartCoroutine(MetaServiceHelpers.GetMainMenuNewsText(new Action<JObject>(loadNewsText.OnGetMainMenuNewsText)));
      loadNewsText.loadingIcon.SetActive(true);
      loadNewsText.mainMenuNewsText.gameObject.SetActive(false);
    }
  }
}
