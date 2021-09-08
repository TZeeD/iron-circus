// Decompiled with JetBrains decompiler
// Type: UserReportingScript
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Collections;
using System.Text;
using Unity.Cloud.UserReporting;
using Unity.Cloud.UserReporting.Plugin;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class UserReportingScript : MonoBehaviour
{
  [Tooltip("The user report button used to create a user report.")]
  public Button UserReportButton;
  [Tooltip("The UI for the user report form. Shown after a user report is created.")]
  public Canvas UserReportForm;
  [Tooltip("The event raised when a user report is submitting.")]
  public UnityEvent UserReportSubmitting;
  [Tooltip("The category dropdown.")]
  public Dropdown CategoryDropdown;
  [Tooltip("The description input on the user report form.")]
  public InputField DescriptionInput;
  [Tooltip("The UI shown when there's an error.")]
  public Canvas ErrorPopup;
  private bool isCreatingUserReport;
  [Tooltip("A value indicating whether the hotkey is enabled (Left Alt + Left Shift + B).")]
  public bool IsHotkeyEnabled;
  [Tooltip("A value indicating whether the user report prefab is in silent mode. Silent mode does not show the user report form.")]
  public bool IsInSilentMode;
  [Tooltip("A value indicating whether the user report client reports metrics about itself.")]
  public bool IsSelfReporting;
  private bool isShowingError;
  private bool isSubmitting;
  [Tooltip("The display text for the progress text.")]
  public UnityEngine.UI.Text ProgressText;
  [Tooltip("A value indicating whether the user report client send events to analytics.")]
  public bool SendEventsToAnalytics;
  [Tooltip("The UI shown while submitting.")]
  public Canvas SubmittingPopup;
  [Tooltip("The summary input on the user report form.")]
  public InputField SummaryInput;
  [Tooltip("The thumbnail viewer on the user report form.")]
  public Image ThumbnailViewer;
  private UnityUserReportingUpdater unityUserReportingUpdater;

  public UserReportingScript()
  {
    this.UserReportSubmitting = new UnityEvent();
    this.unityUserReportingUpdater = new UnityUserReportingUpdater();
  }

  public UserReport CurrentUserReport { get; private set; }

  public UserReportingState State
  {
    get
    {
      if (this.CurrentUserReport != null)
      {
        if (this.IsInSilentMode)
          return UserReportingState.Idle;
        return this.isSubmitting ? UserReportingState.SubmittingForm : UserReportingState.ShowingForm;
      }
      return this.isCreatingUserReport ? UserReportingState.CreatingUserReport : UserReportingState.Idle;
    }
  }

  public void CancelUserReport()
  {
    this.CurrentUserReport = (UserReport) null;
    this.ClearForm();
  }

  private IEnumerator ClearError()
  {
    yield return (object) new WaitForSeconds(10f);
    this.isShowingError = false;
  }

  private void ClearForm()
  {
    this.SummaryInput.text = (string) null;
    this.DescriptionInput.text = (string) null;
  }

  public void CreateUserReport()
  {
    if (this.isCreatingUserReport)
      return;
    this.isCreatingUserReport = true;
    UnityUserReporting.CurrentClient.TakeScreenshot(2048, 2048, (Action<UserReportScreenshot>) (s => { }));
    UnityUserReporting.CurrentClient.TakeScreenshot(512, 512, (Action<UserReportScreenshot>) (s => { }));
    UnityUserReporting.CurrentClient.CreateUserReport((Action<UserReport>) (br =>
    {
      if (string.IsNullOrEmpty(br.ProjectIdentifier))
        Debug.LogWarning((object) "The user report's project identifier is not set. Please setup cloud services using the Services tab or manually specify a project identifier when calling UnityUserReporting.Configure().");
      br.Attachments.Add(new UserReportAttachment("Sample Attachment.txt", "SampleAttachment.txt", "text/plain", Encoding.UTF8.GetBytes("This is a sample attachment.")));
      string str1 = "Unknown";
      string str2 = "0.0";
      foreach (UserReportNamedValue reportNamedValue in br.DeviceMetadata)
      {
        if (reportNamedValue.Name == "Platform")
          str1 = reportNamedValue.Value;
        if (reportNamedValue.Name == "Version")
          str2 = reportNamedValue.Value;
      }
      br.Dimensions.Add(new UserReportNamedValue("Platform.Version", string.Format("{0}.{1}", (object) str1, (object) str2)));
      this.CurrentUserReport = br;
      this.isCreatingUserReport = false;
      this.SetThumbnail(br);
      if (!this.IsInSilentMode)
        return;
      this.SubmitUserReport();
    }));
  }

  public bool IsSubmitting() => this.isSubmitting;

  private void SetThumbnail(UserReport userReport)
  {
    if (userReport == null || !((UnityEngine.Object) this.ThumbnailViewer != (UnityEngine.Object) null))
      return;
    byte[] data = Convert.FromBase64String(userReport.Thumbnail.DataBase64);
    Texture2D texture2D = new Texture2D(1, 1);
    texture2D.LoadImage(data);
    this.ThumbnailViewer.sprite = Sprite.Create(texture2D, new Rect(0.0f, 0.0f, (float) texture2D.width, (float) texture2D.height), new Vector2(0.5f, 0.5f));
    this.ThumbnailViewer.preserveAspect = true;
  }

  private void Start()
  {
    if (Application.isPlaying && (UnityEngine.Object) UnityEngine.Object.FindObjectOfType<EventSystem>() == (UnityEngine.Object) null)
    {
      GameObject gameObject = new GameObject("EventSystem");
      gameObject.AddComponent<EventSystem>();
      gameObject.AddComponent<StandaloneInputModule>();
    }
    UnityUserReporting.Configure();
  }

  public void SubmitUserReport()
  {
    if (this.isSubmitting || this.CurrentUserReport == null)
      return;
    this.isSubmitting = true;
    if ((UnityEngine.Object) this.SummaryInput != (UnityEngine.Object) null)
      this.CurrentUserReport.Summary = this.SummaryInput.text;
    if ((UnityEngine.Object) this.CategoryDropdown != (UnityEngine.Object) null)
    {
      string text = this.CategoryDropdown.options[this.CategoryDropdown.value].text;
      this.CurrentUserReport.Dimensions.Add(new UserReportNamedValue("Category", text));
      this.CurrentUserReport.Fields.Add(new UserReportNamedValue("Category", text));
    }
    if ((UnityEngine.Object) this.DescriptionInput != (UnityEngine.Object) null)
      this.CurrentUserReport.Fields.Add(new UserReportNamedValue()
      {
        Name = "Description",
        Value = this.DescriptionInput.text
      });
    this.ClearForm();
    this.RaiseUserReportSubmitting();
    UnityUserReporting.CurrentClient.SendUserReport(this.CurrentUserReport, (Action<float, float>) ((uploadProgress, downloadProgress) =>
    {
      if (!((UnityEngine.Object) this.ProgressText != (UnityEngine.Object) null))
        return;
      this.ProgressText.text = string.Format("{0:P}", (object) uploadProgress);
    }), (Action<bool, UserReport>) ((success, br2) =>
    {
      if (!success)
      {
        this.isShowingError = true;
        this.StartCoroutine(this.ClearError());
      }
      this.CurrentUserReport = (UserReport) null;
      this.isSubmitting = false;
    }));
  }

  private void Update()
  {
    if (this.IsHotkeyEnabled && Input.GetKey(KeyCode.LeftShift) && Input.GetKey(KeyCode.LeftAlt) && Input.GetKeyDown(KeyCode.B))
      this.CreateUserReport();
    UnityUserReporting.CurrentClient.IsSelfReporting = this.IsSelfReporting;
    UnityUserReporting.CurrentClient.SendEventsToAnalytics = this.SendEventsToAnalytics;
    if ((UnityEngine.Object) this.UserReportButton != (UnityEngine.Object) null)
      this.UserReportButton.interactable = this.State == UserReportingState.Idle;
    if ((UnityEngine.Object) this.UserReportForm != (UnityEngine.Object) null)
      this.UserReportForm.enabled = this.State == UserReportingState.ShowingForm;
    if ((UnityEngine.Object) this.SubmittingPopup != (UnityEngine.Object) null)
      this.SubmittingPopup.enabled = this.State == UserReportingState.SubmittingForm;
    if ((UnityEngine.Object) this.ErrorPopup != (UnityEngine.Object) null)
      this.ErrorPopup.enabled = this.isShowingError;
    this.unityUserReportingUpdater.Reset();
    this.StartCoroutine((IEnumerator) this.unityUserReportingUpdater);
  }

  protected virtual void RaiseUserReportSubmitting()
  {
    if (this.UserReportSubmitting == null)
      return;
    this.UserReportSubmitting.Invoke();
  }
}
