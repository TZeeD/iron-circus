// Decompiled with JetBrains decompiler
// Type: SharedWithServer.Utils.Extensions.StringExtensions
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;

namespace SharedWithServer.Utils.Extensions
{
  public static class StringExtensions
  {
    public static string ToCurrencySymbol(this string ISOCurrency) => ((IEnumerable<CultureInfo>) CultureInfo.GetCultures(CultureTypes.AllCultures)).Where<CultureInfo>((Func<CultureInfo, bool>) (c => c.LCID != (int) sbyte.MaxValue && !c.IsNeutralCulture)).Select<CultureInfo, RegionInfo>((Func<CultureInfo, RegionInfo>) (x => new RegionInfo(x.LCID))).FirstOrDefault<RegionInfo>((Func<RegionInfo, bool>) (p => p.Name.Length > 0 && p.ISOCurrencySymbol == ISOCurrency))?.ISOCurrencySymbol ?? ISOCurrency;

    public static bool IsNullOrEmpty(this string target) => string.IsNullOrEmpty(target);

    public static string GetCurrencySymbol(string code) => ((IEnumerable<CultureInfo>) CultureInfo.GetCultures(CultureTypes.AllCultures)).Where<CultureInfo>((Func<CultureInfo, bool>) (culture => culture.Name.Length > 0 && !culture.IsNeutralCulture)).Select(culture => new
    {
      culture = culture,
      region = new RegionInfo(culture.LCID)
    }).Where(_param1 => string.Equals(_param1.region.ISOCurrencySymbol, code, StringComparison.InvariantCultureIgnoreCase)).Select(_param1 => _param1.region).First<RegionInfo>().CurrencySymbol;
  }
}
