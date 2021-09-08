// Decompiled with JetBrains decompiler
// Type: Steamworks.CallbackIdentities
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

using System;

namespace Steamworks
{
  internal class CallbackIdentities
  {
    public static int GetCallbackIdentity(Type callbackStruct)
    {
      object[] customAttributes = callbackStruct.GetCustomAttributes(typeof (CallbackIdentityAttribute), false);
      int index = 0;
      if (index < customAttributes.Length)
        return ((CallbackIdentityAttribute) customAttributes[index]).Identity;
      throw new Exception("Callback number not found for struct " + (object) callbackStruct);
    }
  }
}
