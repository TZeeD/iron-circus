// Decompiled with JetBrains decompiler
// Type: SharedWithServer.Debug.CheckConfigDataUtils
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using System.IO;
using System.Security.Cryptography;
using System.Text;

namespace SharedWithServer.Debug
{
  public static class CheckConfigDataUtils
  {
    public static byte[] GetServerJsonHash(string jsonsBaseDir)
    {
      string serverJsonDir = CheckConfigDataUtils.GetServerJsonDir(jsonsBaseDir);
      Log.Debug("Calculating hash for json dir " + serverJsonDir);
      return CheckConfigDataUtils.GetFileHash(Path.Combine(new string[2]
      {
        serverJsonDir,
        "ConfigProvider.json"
      }));
    }

    private static string GetServerJsonDir(string jsonsDir)
    {
      if (jsonsDir.StartsWith(Path.DirectorySeparatorChar.ToString()))
        return jsonsDir;
      return Path.Combine(new string[2]
      {
        Directory.GetCurrentDirectory(),
        "JSON"
      });
    }

    public static byte[] GetClientJsonHash() => CheckConfigDataUtils.GetFileHash(Path.Combine(new string[2]
    {
      CheckConfigDataUtils.GetClientJsonDir(),
      "ConfigProvider.json"
    }));

    private static string GetClientJsonDir() => Path.Combine(new string[4]
    {
      Directory.GetCurrentDirectory(),
      "Assets",
      "Resources",
      "JSON"
    });

    public static byte[] GetFileHash(string filePath)
    {
      using (MD5 md5 = MD5.Create())
      {
        byte[] bytes = Encoding.ASCII.GetBytes(File.ReadAllText(filePath));
        return md5.ComputeHash(bytes);
      }
    }

    public static string Md5ToString(byte[] hashBytes)
    {
      StringBuilder stringBuilder = new StringBuilder();
      for (int index = 0; index < hashBytes.Length; ++index)
        stringBuilder.Append(hashBytes[index].ToString("X2"));
      return stringBuilder.ToString();
    }
  }
}
