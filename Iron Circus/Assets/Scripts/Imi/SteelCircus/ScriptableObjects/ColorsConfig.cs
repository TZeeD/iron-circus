// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.ScriptableObjects.ColorsConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Extensions;
using Imi.Game;
using Imi.SharedWithServer.Game;
using UnityEngine;

namespace Imi.SteelCircus.ScriptableObjects
{
  [CreateAssetMenu(fileName = "ColorsConfig", menuName = "SteelCircus/Configs/ColorsConfig")]
  public class ColorsConfig : SingletonScriptableObject<ColorsConfig>
  {
    [Header("Team Colors")]
    public Color team1ColorLight;
    public Color team2ColorLight;
    public Color team1ColorMiddle;
    public Color team2ColorMiddle;
    public Color team1ColorDark;
    public Color team2ColorDark;
    public Color team1ColorGoal;
    public Color team2ColorGoal;
    public Color disabledColorLight;
    public Color disabledColorMiddle;
    public Color disabledColorDark;
    [Header("Team Colors HDR")]
    [ColorUsage(true, true)]
    public Color team1ColorMiddleHdr;
    [ColorUsage(true, true)]
    public Color team2ColorMiddleHdr;
    [Header("AoE Colors")]
    public Color team1AoeColorOutlineFG;
    public Color team2AoeColorOutlineFG;
    public Color team1AoeColorOutlineBG;
    public Color team2AoeColorOutlineBG;
    public Color team1AoeColorMiddle;
    public Color team2AoeColorMiddle;
    public Color team1AoeColorDark;
    public Color team2AoeColorDark;
    public Color aoeColorDamage;
    public Color aoeColorNeutral;
    [Header("UI")]
    public Color localPlayerUIColor;
    public Color floorUIChargeColorDark;
    public Color floorUIChargeColorLight;
    public Color floorUIPrechargeColorDark;
    public Color floorUIPrechargeColorLight;
    [Space]
    public Color healhPointColor;
    public Color skillIsActiveColor;
    public Color skillIsInactiveColor;
    [Space]
    public Color stamina = new Color(0.9f, 0.9f, 0.0f, 1f);
    public Color staminaBarEmpty;
    public Color staminaEmptyBlinkColor = new Color(0.9f, 0.43f, 0.23f, 1f);
    [Header("Menu UI")]
    public Color steelColor;
    public Color credsColor;
    [Space]
    public Color selectedHueOrange;
    public Color selectedHueGray;
    public Color deselectedHueBlack;
    public Color deselectedHueGray;
    [Space]
    public Color tier0Light;
    public Color tier0Dark;
    public Color tier1Light;
    public Color tier1Dark;
    public Color tier2Light;
    public Color tier2Dark;
    public Color tier3Light;
    public Color tier3Dark;
    [Header("VFX")]
    [ColorUsage(true, true)]
    public Color characterFlashBallPickup;
    [ColorUsage(true, true)]
    public Color characterHoldBallGlow;
    public float characterHoldBallGlowIntensity = 0.5f;
    [ColorUsage(true, true)]
    public Color characterFlashDamage;
    [ColorUsage(true, true)]
    public Color characterFlashHeal;
    [ColorUsage(true, true)]
    public Color characterFlashSkillPickup;
    [ColorUsage(true, true)]
    public Color characterFlashSprintPickup;
    [Header("TrackingEvents Ui")]
    public Color TrackingEventT1Damage;
    public Color TrackingEventT1DamageText;
    public Color TrackingEventT1Other;
    public Color TrackingEventT1OtherText;

    public Color TierColorLight(ShopManager.ItemTier tier)
    {
      switch (tier)
      {
        case ShopManager.ItemTier.tier0:
          return this.tier0Light;
        case ShopManager.ItemTier.tier1:
          return this.tier1Light;
        case ShopManager.ItemTier.tier2:
          return this.tier2Light;
        case ShopManager.ItemTier.tier3:
          return this.tier3Light;
        default:
          return this.tier0Light;
      }
    }

    public Color TierColorDark(ShopManager.ItemTier tier)
    {
      switch (tier)
      {
        case ShopManager.ItemTier.tier0:
          return this.tier0Dark;
        case ShopManager.ItemTier.tier1:
          return this.tier1Dark;
        case ShopManager.ItemTier.tier2:
          return this.tier2Dark;
        case ShopManager.ItemTier.tier3:
          return this.tier3Dark;
        default:
          return this.tier0Dark;
      }
    }

    public Color LightColor(Team team) => team != Team.Alpha ? this.team2ColorLight : this.team1ColorLight;

    public Color DarkColor(Team team) => team != Team.Alpha ? this.team2ColorDark : this.team1ColorDark;

    public Color MiddleColor(Team team) => team != Team.Alpha ? this.team2ColorMiddle : this.team1ColorMiddle;

    public Color MiddleColorHdr(Team team) => team != Team.Alpha ? this.team2ColorMiddleHdr : this.team1ColorMiddleHdr;

    public Color OutlineFGAoeColor(Team team) => team != Team.Alpha ? this.team2AoeColorOutlineFG : this.team1AoeColorOutlineFG;

    public Color OutlineBGAoeColor(Team team) => team != Team.Alpha ? this.team2AoeColorOutlineBG : this.team1AoeColorOutlineBG;

    public Color DarkAoeColor(Team team) => team != Team.Alpha ? this.team2AoeColorDark : this.team1AoeColorDark;

    public Color MiddleAoeColor(Team team) => team != Team.Alpha ? this.team2AoeColorMiddle : this.team1AoeColorMiddle;

    public Color ColorForPickupType(PickupType pickupType)
    {
      switch (pickupType)
      {
        case PickupType.RefreshSkills:
          return this.characterFlashSkillPickup.WithAlpha(1f);
        case PickupType.RegainHealth:
          return this.characterFlashHeal.WithAlpha(1f);
        case PickupType.RefreshSprint:
          return this.characterFlashSprintPickup.WithAlpha(1f);
        default:
          return this.characterFlashHeal.WithAlpha(1f);
      }
    }
  }
}
