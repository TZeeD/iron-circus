// Decompiled with JetBrains decompiler
// Type: Sabresaurus.PlayerPrefsExtensions.SimpleEncryption
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Security.Cryptography;
using System.Text;

namespace Sabresaurus.PlayerPrefsExtensions
{
  public static class SimpleEncryption
  {
    private static string key = ":{j%6j?E:t#}G10mM%9hp5S=%}2,Y26C";
    private static RijndaelManaged provider = (RijndaelManaged) null;

    private static void SetupProvider()
    {
      SimpleEncryption.provider = new RijndaelManaged();
      SimpleEncryption.provider.Key = Encoding.ASCII.GetBytes(SimpleEncryption.key);
      SimpleEncryption.provider.Mode = CipherMode.ECB;
    }

    public static string EncryptString(string sourceString)
    {
      if (SimpleEncryption.provider == null)
        SimpleEncryption.SetupProvider();
      ICryptoTransform encryptor = SimpleEncryption.provider.CreateEncryptor();
      byte[] bytes = Encoding.UTF8.GetBytes(sourceString);
      byte[] inputBuffer = bytes;
      int length = bytes.Length;
      return Convert.ToBase64String(encryptor.TransformFinalBlock(inputBuffer, 0, length));
    }

    public static string DecryptString(string sourceString)
    {
      if (SimpleEncryption.provider == null)
        SimpleEncryption.SetupProvider();
      ICryptoTransform decryptor = SimpleEncryption.provider.CreateDecryptor();
      byte[] numArray = Convert.FromBase64String(sourceString);
      byte[] inputBuffer = numArray;
      int length = numArray.Length;
      return Encoding.UTF8.GetString(decryptor.TransformFinalBlock(inputBuffer, 0, length));
    }

    public static string EncryptFloat(float value) => SimpleEncryption.EncryptString(Convert.ToBase64String(BitConverter.GetBytes(value)));

    public static string EncryptInt(int value) => SimpleEncryption.EncryptString(Convert.ToBase64String(BitConverter.GetBytes(value)));

    public static float DecryptFloat(string sourceString) => BitConverter.ToSingle(Convert.FromBase64String(SimpleEncryption.DecryptString(sourceString)), 0);

    public static int DecryptInt(string sourceString) => BitConverter.ToInt32(Convert.FromBase64String(SimpleEncryption.DecryptString(sourceString)), 0);
  }
}
