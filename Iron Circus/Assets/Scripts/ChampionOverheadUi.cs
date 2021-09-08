// Decompiled with JetBrains decompiler
// Type: ChampionOverheadUi
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SteelCircus.Core;
using Imi.SteelCircus.GameElements;
using Imi.SteelCircus.Utils.Extensions;
using SteelCircus.UI;
using SteelCircus.Utils.Smoothing;
using UnityEngine;
using UnityEngine.UI;

public class ChampionOverheadUi : MonoBehaviour
{
  private ChampionOverheadUi.Mode mode;
  private GameContext gameContext;
  [SerializeField]
  private Image ballOwnerNameDecoLeft;
  [SerializeField]
  private Image ballOwnerNameDecoRight;
  [Header("Overhead Display")]
  public Text overheadUsername;
  public RectTransform overheadRectTrans;
  public RectTransform nameParentRectTrans;
  [SerializeField]
  private Text tfInvalidAction;
  [SerializeField]
  private float invalidActionDuration = 0.7f;
  [SerializeField]
  private float localPlayerYDefault = 25f;
  [SerializeField]
  private float localPlayerYInvalidAction = 49f;
  [SerializeField]
  private float invalidActionSmoothing = 3f / 1000f;
  private float invalidActionCounter;
  [Header("Local Player Extras")]
  public GameObject localPlayerExtras;
  public GameObject localPlayerArrowPrefab;
  private Player player;
  private GameObject playerView;
  private ChampionConfig config;
  private bool initialized;
  private int maxHealth;
  private Transform localPlayerArrow;
  private bool localPlayerArrowEnabled = true;
  public float VictoryScreenOffsetAmount = 110f;
  private int inGameFontSize;
  private Color inGameFontColor;
  private FontStyle inGameFontStyle;
  private bool playerHasBall;
  private bool isLocalPlayer;
  [SerializeField]
  private Color ballOwnershipBlinkColor = Color.white;
  [SerializeField]
  private float ballOwnershipBlinkDuration = 0.5f;
  private float ballOwnershipBlinkCounter;
  private Transform boneTransform;
  private HarmonicMotionVector3 smoothedUiAnchorPos = new HarmonicMotionVector3();
  private SkillVar<bool> canAffordTackle;
  private SkillVar<bool> canAffordDodge;

  private void Start() => this.gameObject.SetActive(this.initialized);

  public void Init(Player player)
  {
    this.gameObject.SetActive(true);
    this.player = player;
    this.playerView = player.gameObject;
    this.config = player.Config;
    this.isLocalPlayer = player.GameEntity.isLocalEntity;
    this.ballOwnerNameDecoLeft.enabled = false;
    this.ballOwnerNameDecoRight.enabled = false;
    this.gameContext = Contexts.sharedInstance.game;
    this.overheadUsername.text = player.GameEntity.hasPlayerUsername ? player.GameEntity.playerUsername.username : "NO USERNAME";
    Color color = StartupSetup.Colors.LightColor(player.PlayerTeam);
    this.inGameFontColor = color;
    this.overheadUsername.color = color;
    this.inGameFontStyle = FontStyle.Normal;
    if ((Object) this.config != (Object) null && this.config.uiAnchorBoneName != "")
      this.boneTransform = this.playerView.transform.FindDeepChild(this.config.uiAnchorBoneName);
    this.smoothedUiAnchorPos.velocity = Vector3.zero;
    this.smoothedUiAnchorPos.targetValue = this.smoothedUiAnchorPos.currentValue = Vector3.zero;
    this.smoothedUiAnchorPos.AngularFrequency = this.config.uiAnchorBoneSpringFrequency;
    this.smoothedUiAnchorPos.recalcCoefficientsEveryStep = true;
    this.tfInvalidAction.gameObject.SetActive(false);
    this.SetupUsernameFormatForIngame(player);
    this.initialized = true;
  }

  private void ShowInvalidActionMsg(string text)
  {
    this.tfInvalidAction.text = text;
    this.invalidActionCounter = this.invalidActionDuration;
    this.tfInvalidAction.gameObject.SetActive(true);
  }

  private void HideInvalidActionMsg()
  {
    this.invalidActionCounter = 0.0f;
    this.tfInvalidAction.gameObject.SetActive(true);
  }

  public void SetupUsernameForRemote()
  {
  }

  public void SetVictoryScreenOffsetAmount(float amount) => this.VictoryScreenOffsetAmount = amount;

  public void SetupUsernameFormatForIngame(Player player)
  {
    this.mode = ChampionOverheadUi.Mode.Game;
    if (this.isLocalPlayer)
    {
      this.localPlayerExtras.SetActive(true);
      this.localPlayerExtras.GetComponentInChildren<ChampionOverheadSkillUI>().Init(player);
      this.inGameFontSize = 26;
      this.inGameFontStyle = FontStyle.Bold;
      this.nameParentRectTrans.transform.localPosition = new Vector3(0.0f, 25f, 0.0f);
      Outline component = this.overheadUsername.GetComponent<Outline>();
      component.effectDistance = Vector2.one * 1f;
      Color effectColor = component.effectColor;
      effectColor.a = 1f;
      component.effectColor = effectColor;
      if ((Object) this.localPlayerArrow == (Object) null)
      {
        this.localPlayerArrow = Object.Instantiate<GameObject>(this.localPlayerArrowPrefab).transform;
        this.localPlayerArrow.parent = player.transform;
        this.localPlayerArrow.SetToIdentity();
        if (!this.localPlayerArrowEnabled)
          this.localPlayerArrow.gameObject.SetActive(false);
      }
    }
    else
    {
      this.localPlayerExtras.SetActive(false);
      this.inGameFontSize = 23;
    }
    this.overheadUsername.fontSize = this.inGameFontSize;
    this.overheadUsername.fontStyle = this.inGameFontStyle;
    this.SetupTextColorForInGame();
  }

  private void SetupTextColorForInGame()
  {
    if (this.isLocalPlayer)
      this.inGameFontColor = StartupSetup.Colors.localPlayerUIColor;
    this.overheadUsername.color = this.inGameFontColor;
    this.ballOwnerNameDecoLeft.color = this.inGameFontColor;
    this.ballOwnerNameDecoRight.color = this.inGameFontColor;
  }

  public void SetupUsernameFormatForIngame() => this.SetupUsernameFormatForIngame(this.player);

  public void SetupUsernameFormatForVictoryScreen(GameObject newPlayerView)
  {
    this.mode = ChampionOverheadUi.Mode.VictoryScreen;
    if ((Object) newPlayerView != (Object) null)
      this.playerView = newPlayerView;
    if ((Object) this.config != (Object) null && this.config.uiAnchorBoneName != "")
      this.boneTransform = this.playerView.transform.FindDeepChild(this.config.uiAnchorBoneName);
    this.smoothedUiAnchorPos.velocity = Vector3.zero;
    this.smoothedUiAnchorPos.targetValue = this.smoothedUiAnchorPos.currentValue = Vector3.zero;
    this.smoothedUiAnchorPos.AngularFrequency = this.config.uiAnchorBoneSpringFrequency;
    this.smoothedUiAnchorPos.recalcCoefficientsEveryStep = true;
    this.localPlayerExtras.SetActive(false);
    this.overheadUsername.fontSize = 35;
    this.overheadUsername.fontStyle = this.inGameFontStyle;
    this.overheadUsername.color = StartupSetup.Colors.LightColor(this.player.PlayerTeam);
    this.playerHasBall = false;
    this.ballOwnerNameDecoLeft.enabled = false;
    this.ballOwnerNameDecoRight.enabled = false;
  }

  private void OnEnable()
  {
    if (!((Object) this.player != (Object) null) || !((Object) this.localPlayerArrow != (Object) null) || !this.localPlayerArrowEnabled)
      return;
    this.localPlayerArrow.gameObject.SetActive(true);
  }

  private void OnDisable()
  {
    this.StopAllCoroutines();
    if (!((Object) this.localPlayerArrow != (Object) null))
      return;
    this.localPlayerArrow.gameObject.SetActive(false);
  }

  public void DisablePlayerArrow()
  {
    if (!((Object) this.localPlayerArrow != (Object) null))
      return;
    this.localPlayerArrowEnabled = false;
    this.localPlayerArrow.gameObject.SetActive(false);
  }

  private void LateUpdate()
  {
    if ((Object) this.player == (Object) null)
      return;
    this.UpdateOverheadUiPosition();
    if (this.mode == ChampionOverheadUi.Mode.Game)
      this.UpdateForInGame();
    else
      this.HideInvalidActionMsg();
  }

  private void CheckForInvalidAction()
  {
    GameEntity gameEntity = this.player.GameEntity;
    if (gameEntity == null || !gameEntity.hasSkillUi || gameEntity.skillUi.skillUiStates == null)
      return;
    if (this.canAffordTackle == null || this.canAffordDodge == null)
    {
      this.canAffordTackle = gameEntity.skillGraph.GetVar<bool>("CanAffordTackle");
      this.canAffordDodge = gameEntity.skillGraph.GetVar<bool>("CanAffordDodge");
    }
    bool flag1 = false;
    bool flag2 = false;
    foreach (SkillUiStateData skillUiState in gameEntity.skillUi.skillUiStates)
    {
      switch (skillUiState.buttonType)
      {
        case Imi.SharedWithServer.ScEntitas.Components.ButtonType.Sprint:
          if ((double) skillUiState.fillAmount == 0.0 && skillUiState.isButtonDown)
          {
            flag1 = true;
            continue;
          }
          continue;
        case Imi.SharedWithServer.ScEntitas.Components.ButtonType.Tackle:
          if (skillUiState.isButtonDown && !(bool) this.canAffordTackle)
          {
            flag1 = true;
            continue;
          }
          continue;
        case Imi.SharedWithServer.ScEntitas.Components.ButtonType.PrimarySkill:
        case Imi.SharedWithServer.ScEntitas.Components.ButtonType.SecondarySkill:
          if (skillUiState.isButtonDown && (double) skillUiState.coolDownLeft > 0.0)
          {
            flag2 = true;
            continue;
          }
          continue;
        default:
          continue;
      }
    }
    if (flag2)
    {
      this.ShowInvalidActionMsg("SKILL ON COOLDOWN");
    }
    else
    {
      if (!flag1)
        return;
      this.ShowInvalidActionMsg("OUT OF STAMINA");
    }
  }

  private void UpdateForInGame()
  {
    this.CheckForInvalidAction();
    if ((double) this.ballOwnershipBlinkCounter > 0.0)
    {
      this.ballOwnershipBlinkCounter = Mathf.Max(0.0f, this.ballOwnershipBlinkCounter - Time.deltaTime);
      if ((double) this.ballOwnershipBlinkCounter <= 0.0)
        this.SetupTextColorForInGame();
    }
    float num1;
    if ((double) this.invalidActionCounter > 0.0)
    {
      num1 = this.localPlayerYInvalidAction;
      this.invalidActionCounter = Mathf.Max(0.0f, this.invalidActionCounter - Time.deltaTime);
      if ((double) this.invalidActionCounter == 0.0)
        this.tfInvalidAction.gameObject.SetActive(false);
    }
    else
      num1 = this.localPlayerYDefault;
    Vector3 localPosition = this.nameParentRectTrans.transform.localPosition;
    localPosition.y += (float) (((double) num1 - (double) localPosition.y) * (1.0 - (double) Mathf.Pow(this.invalidActionSmoothing, Time.deltaTime)));
    this.nameParentRectTrans.transform.localPosition = localPosition;
    GameEntity ballEntity = this.gameContext.ballEntity;
    if (ballEntity.hasBallOwner && ballEntity.ballOwner.IsOwner(this.player.GameEntity))
    {
      if (this.playerHasBall)
        return;
      this.playerHasBall = true;
      this.overheadUsername.fontSize = this.inGameFontSize + (this.isLocalPlayer ? 2 : 5);
      this.overheadUsername.fontStyle = FontStyle.Bold;
      this.ballOwnerNameDecoLeft.enabled = true;
      this.ballOwnerNameDecoRight.enabled = true;
      RectTransform component1 = this.overheadUsername.GetComponent<RectTransform>();
      float x1 = this.ballOwnerNameDecoLeft.GetComponent<RectTransform>().sizeDelta.x;
      Text component2 = this.overheadUsername.GetComponent<Text>();
      float num2 = component2.preferredWidth + (float) (5.0 * 2.0);
      float preferredHeight = component2.preferredHeight;
      float y = (float) ((double) component1.transform.localPosition.y - (double) component1.sizeDelta.y * 0.5 + (double) preferredHeight * 0.5);
      float x2 = component1.rect.center.x;
      this.ballOwnerNameDecoLeft.transform.localPosition = new Vector3((float) ((double) x2 - (double) num2 * 0.5 - (double) x1 / 2.0), y, 0.0f);
      this.ballOwnerNameDecoRight.transform.localPosition = new Vector3((float) ((double) x2 + (double) num2 * 0.5 + (double) x1 / 2.0), y, 0.0f);
      this.ballOwnershipBlinkCounter = this.ballOwnershipBlinkDuration;
      this.overheadUsername.color = this.ballOwnershipBlinkColor;
    }
    else
    {
      if (!this.playerHasBall)
        return;
      this.playerHasBall = false;
      this.overheadUsername.fontSize = this.inGameFontSize;
      this.overheadUsername.fontStyle = this.inGameFontStyle;
      this.ballOwnerNameDecoLeft.enabled = false;
      this.ballOwnerNameDecoRight.enabled = false;
    }
  }

  private void UpdateOverheadUiPosition()
  {
    Vector3 vector3_1 = Vector3.up * 2.1f;
    ChampionConfig config = this.config;
    Vector3 vector3_2 = Vector3.zero;
    Transform transform = this.playerView.transform;
    if ((Object) config != (Object) null)
    {
      vector3_1 = config.uiAnchor;
      if ((Object) this.boneTransform != (Object) null)
      {
        Vector3 direction = transform.InverseTransformPoint(this.boneTransform.position);
        direction.y = Mathf.Max(direction.y, config.uiAnchorBoneMinHeight);
        direction -= config.uiAnchorBoneRestPos;
        direction = transform.TransformDirection(direction);
        direction *= config.uiAnchorBoneInfluence;
        this.smoothedUiAnchorPos.targetValue = direction;
        this.smoothedUiAnchorPos.AngularFrequency = config.uiAnchorBoneSpringFrequency;
        direction = this.smoothedUiAnchorPos.Step();
        direction = transform.InverseTransformDirection(direction);
        direction += config.uiAnchorBoneRestPos;
        vector3_2 = direction;
      }
    }
    Vector3 position = vector3_1 + vector3_2;
    Vector3 worldPoint = transform.TransformPoint(position);
    if ((Object) this.localPlayerArrow != (Object) null && this.mode == ChampionOverheadUi.Mode.Game)
    {
      this.localPlayerArrow.position = worldPoint;
      worldPoint.y += 0.8f;
    }
    Vector2 localPoint;
    RectTransformUtility.ScreenPointToLocalPointInRectangle(this.overheadRectTrans.parent as RectTransform, RectTransformUtility.WorldToScreenPoint(Camera.main, worldPoint), (Camera) null, out localPoint);
    if (this.mode == ChampionOverheadUi.Mode.VictoryScreen)
      localPoint = new Vector2(localPoint.x, localPoint.y - this.VictoryScreenOffsetAmount);
    this.overheadRectTrans.localPosition = (Vector3) localPoint;
  }

  private enum Mode
  {
    Game,
    VictoryScreen,
  }
}
