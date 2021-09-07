using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Events;

public class UserReportingScript : MonoBehaviour
{
	public Button UserReportButton;
	public Canvas UserReportForm;
	public UnityEvent UserReportSubmitting;
	public Dropdown CategoryDropdown;
	public InputField DescriptionInput;
	public Canvas ErrorPopup;
	public bool IsHotkeyEnabled;
	public bool IsInSilentMode;
	public bool IsSelfReporting;
	public Text ProgressText;
	public bool SendEventsToAnalytics;
	public Canvas SubmittingPopup;
	public InputField SummaryInput;
	public Image ThumbnailViewer;
}
