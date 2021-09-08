// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Utils.Console.Console
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections.Generic;
using UnityEngine;

namespace Imi.SteelCircus.Utils.Console
{
  internal class Console : MonoBehaviour
  {
    public KeyCode toggleKey = KeyCode.BackQuote;
    public bool shakeToOpen = true;
    public float shakeAcceleration = 3f;
    public bool restrictLogCount;
    public int maxLogs = 1000;
    private readonly List<Imi.SteelCircus.Utils.Console.Console.Log> logs = new List<Imi.SteelCircus.Utils.Console.Console.Log>();
    private Vector2 scrollPosition;
    private bool visible;
    private bool collapse;
    private static readonly Dictionary<LogType, Color> logTypeColors = new Dictionary<LogType, Color>()
    {
      {
        LogType.Assert,
        Color.white
      },
      {
        LogType.Error,
        Color.red
      },
      {
        LogType.Exception,
        Color.red
      },
      {
        LogType.Log,
        Color.white
      },
      {
        LogType.Warning,
        Color.yellow
      }
    };
    private const string WindowTitle = "Console";
    private const int Margin = 20;
    private static readonly GUIContent clearLabel = new GUIContent("Clear", "Clear the contents of the console.");
    private static readonly GUIContent collapseLabel = new GUIContent("Collapse", "Hide repeated messages.");
    private readonly Rect titleBarRect = new Rect(0.0f, 0.0f, 10000f, 20f);
    private Rect windowRect = new Rect(20f, 20f, (float) (Screen.width - 40), (float) (Screen.height - 40));

    private void OnEnable() => Application.logMessageReceived += new Application.LogCallback(this.HandleLog);

    private void OnDisable() => Application.logMessageReceived -= new Application.LogCallback(this.HandleLog);

    private void Update()
    {
      if (Input.GetKeyDown(this.toggleKey))
        this.visible = !this.visible;
      if (!this.shakeToOpen || (double) Input.acceleration.sqrMagnitude <= (double) this.shakeAcceleration)
        return;
      this.visible = true;
    }

    private void OnGUI()
    {
      if (!this.visible)
        return;
      this.windowRect = GUILayout.Window(123456, this.windowRect, new GUI.WindowFunction(this.DrawConsoleWindow), nameof (Console));
    }

    private void DrawConsoleWindow(int windowId)
    {
      this.DrawLogsList();
      this.DrawToolbar();
      GUI.DragWindow(this.titleBarRect);
    }

    private void DrawLogsList()
    {
      this.scrollPosition = GUILayout.BeginScrollView(this.scrollPosition);
      GUILayout.BeginVertical();
      for (int index = 0; index < this.logs.Count; ++index)
      {
        Imi.SteelCircus.Utils.Console.Console.Log log = this.logs[index];
        if (this.collapse && index > 0)
        {
          string message = this.logs[index - 1].message;
          if (log.message == message)
            continue;
        }
        GUI.contentColor = Imi.SteelCircus.Utils.Console.Console.logTypeColors[log.type];
        GUILayout.Label(log.message);
      }
      GUILayout.EndVertical();
      Rect lastRect1 = GUILayoutUtility.GetLastRect();
      GUILayout.EndScrollView();
      Rect lastRect2 = GUILayoutUtility.GetLastRect();
      if (Event.current.type == EventType.Repaint && this.IsScrolledToBottom(lastRect1, lastRect2))
        this.ScrollToBottom();
      GUI.contentColor = Color.white;
    }

    private void DrawToolbar()
    {
      GUILayout.BeginHorizontal();
      if (GUILayout.Button(Imi.SteelCircus.Utils.Console.Console.clearLabel))
        this.logs.Clear();
      this.collapse = GUILayout.Toggle((this.collapse ? 1 : 0) != 0, Imi.SteelCircus.Utils.Console.Console.collapseLabel, GUILayout.ExpandWidth(false));
      GUILayout.EndHorizontal();
    }

    private void HandleLog(string message, string stackTrace, LogType type)
    {
      this.logs.Add(new Imi.SteelCircus.Utils.Console.Console.Log()
      {
        message = message,
        stackTrace = stackTrace,
        type = type
      });
      this.TrimExcessLogs();
    }

    private bool IsScrolledToBottom(Rect innerScrollRect, Rect outerScrollRect)
    {
      float height = innerScrollRect.height;
      float num = outerScrollRect.height - (float) GUI.skin.box.padding.vertical;
      return (double) num > (double) height || Mathf.Approximately(height, this.scrollPosition.y + num);
    }

    private void ScrollToBottom() => this.scrollPosition = new Vector2(0.0f, (float) int.MaxValue);

    private void TrimExcessLogs()
    {
      if (!this.restrictLogCount)
        return;
      int count = Mathf.Max(this.logs.Count - this.maxLogs, 0);
      if (count == 0)
        return;
      this.logs.RemoveRange(0, count);
    }

    private struct Log
    {
      public string message;
      public string stackTrace;
      public LogType type;
    }
  }
}
