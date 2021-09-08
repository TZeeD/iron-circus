// Decompiled with JetBrains decompiler
// Type: DiscordOld.DiscordRpc
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using AOT;
using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Text;

namespace DiscordOld
{
  public class DiscordRpc
  {
    [MonoPInvokeCallback(typeof (DiscordRpc.OnReadyInfo))]
    public static void ReadyCallback(ref DiscordRpc.DiscordUser connectedUser) => DiscordRpc.Callbacks.readyCallback(ref connectedUser);

    [MonoPInvokeCallback(typeof (DiscordRpc.OnDisconnectedInfo))]
    public static void DisconnectedCallback(int errorCode, string message) => DiscordRpc.Callbacks.disconnectedCallback(errorCode, message);

    [MonoPInvokeCallback(typeof (DiscordRpc.OnErrorInfo))]
    public static void ErrorCallback(int errorCode, string message) => DiscordRpc.Callbacks.errorCallback(errorCode, message);

    [MonoPInvokeCallback(typeof (DiscordRpc.OnJoinInfo))]
    public static void JoinCallback(string secret) => DiscordRpc.Callbacks.joinCallback(secret);

    [MonoPInvokeCallback(typeof (DiscordRpc.OnSpectateInfo))]
    public static void SpectateCallback(string secret) => DiscordRpc.Callbacks.spectateCallback(secret);

    [MonoPInvokeCallback(typeof (DiscordRpc.OnRequestInfo))]
    public static void RequestCallback(ref DiscordRpc.DiscordUser request) => DiscordRpc.Callbacks.requestCallback(ref request);

    private static DiscordRpc.EventHandlers Callbacks { get; set; }

    public static void Initialize(
      string applicationId,
      ref DiscordRpc.EventHandlers handlers,
      bool autoRegister,
      string optionalSteamId)
    {
      DiscordRpc.Callbacks = handlers;
      DiscordRpc.EventHandlers handlers1 = new DiscordRpc.EventHandlers();
      handlers1.readyCallback += new DiscordRpc.OnReadyInfo(DiscordRpc.ReadyCallback);
      handlers1.disconnectedCallback += new DiscordRpc.OnDisconnectedInfo(DiscordRpc.DisconnectedCallback);
      handlers1.errorCallback += new DiscordRpc.OnErrorInfo(DiscordRpc.ErrorCallback);
      handlers1.joinCallback += new DiscordRpc.OnJoinInfo(DiscordRpc.JoinCallback);
      handlers1.spectateCallback += new DiscordRpc.OnSpectateInfo(DiscordRpc.SpectateCallback);
      handlers1.requestCallback += new DiscordRpc.OnRequestInfo(DiscordRpc.RequestCallback);
      DiscordRpc.InitializeInternal(applicationId, ref handlers1, autoRegister, optionalSteamId);
    }

    [DllImport("discord-rpc", EntryPoint = "Discord_Initialize", CallingConvention = CallingConvention.Cdecl)]
    private static extern void InitializeInternal(
      string applicationId,
      ref DiscordRpc.EventHandlers handlers,
      bool autoRegister,
      string optionalSteamId);

    [DllImport("discord-rpc", EntryPoint = "Discord_Shutdown", CallingConvention = CallingConvention.Cdecl)]
    public static extern void Shutdown();

    [DllImport("discord-rpc", EntryPoint = "Discord_RunCallbacks", CallingConvention = CallingConvention.Cdecl)]
    public static extern void RunCallbacks();

    [DllImport("discord-rpc", EntryPoint = "Discord_UpdatePresence", CallingConvention = CallingConvention.Cdecl)]
    private static extern void UpdatePresenceNative(ref DiscordRpc.RichPresenceStruct presence);

    [DllImport("discord-rpc", EntryPoint = "Discord_ClearPresence", CallingConvention = CallingConvention.Cdecl)]
    public static extern void ClearPresence();

    [DllImport("discord-rpc", EntryPoint = "Discord_Respond", CallingConvention = CallingConvention.Cdecl)]
    public static extern void Respond(string userId, DiscordRpc.Reply reply);

    [DllImport("discord-rpc", EntryPoint = "Discord_UpdateHandlers", CallingConvention = CallingConvention.Cdecl)]
    public static extern void UpdateHandlers(ref DiscordRpc.EventHandlers handlers);

    public static void UpdatePresence(DiscordRpc.RichPresence presence)
    {
      DiscordRpc.RichPresenceStruct presence1 = presence.GetStruct();
      DiscordRpc.UpdatePresenceNative(ref presence1);
      presence.FreeMem();
    }

    public delegate void OnReadyInfo(ref DiscordRpc.DiscordUser connectedUser);

    public delegate void OnDisconnectedInfo(int errorCode, string message);

    public delegate void OnErrorInfo(int errorCode, string message);

    public delegate void OnJoinInfo(string secret);

    public delegate void OnSpectateInfo(string secret);

    public delegate void OnRequestInfo(ref DiscordRpc.DiscordUser request);

    public struct EventHandlers
    {
      public DiscordRpc.OnReadyInfo readyCallback;
      public DiscordRpc.OnDisconnectedInfo disconnectedCallback;
      public DiscordRpc.OnErrorInfo errorCallback;
      public DiscordRpc.OnJoinInfo joinCallback;
      public DiscordRpc.OnSpectateInfo spectateCallback;
      public DiscordRpc.OnRequestInfo requestCallback;
    }

    [Serializable]
    public struct RichPresenceStruct
    {
      public IntPtr state;
      public IntPtr details;
      public long startTimestamp;
      public long endTimestamp;
      public IntPtr largeImageKey;
      public IntPtr largeImageText;
      public IntPtr smallImageKey;
      public IntPtr smallImageText;
      public IntPtr partyId;
      public int partySize;
      public int partyMax;
      public IntPtr matchSecret;
      public IntPtr joinSecret;
      public IntPtr spectateSecret;
      public bool instance;
    }

    [Serializable]
    public struct DiscordUser
    {
      public string userId;
      public string username;
      public string discriminator;
      public string avatar;
    }

    public enum Reply
    {
      No,
      Yes,
      Ignore,
    }

    public class RichPresence
    {
      private DiscordRpc.RichPresenceStruct _presence;
      private readonly List<IntPtr> _buffers = new List<IntPtr>(10);
      public string state;
      public string details;
      public long startTimestamp;
      public long endTimestamp;
      public string largeImageKey;
      public string largeImageText;
      public string smallImageKey;
      public string smallImageText;
      public string partyId;
      public int partySize;
      public int partyMax;
      public string matchSecret;
      public string joinSecret;
      public string spectateSecret;
      public bool instance;

      internal DiscordRpc.RichPresenceStruct GetStruct()
      {
        if (this._buffers.Count > 0)
          this.FreeMem();
        this._presence.state = this.StrToPtr(this.state);
        this._presence.details = this.StrToPtr(this.details);
        this._presence.startTimestamp = this.startTimestamp;
        this._presence.endTimestamp = this.endTimestamp;
        this._presence.largeImageKey = this.StrToPtr(this.largeImageKey);
        this._presence.largeImageText = this.StrToPtr(this.largeImageText);
        this._presence.smallImageKey = this.StrToPtr(this.smallImageKey);
        this._presence.smallImageText = this.StrToPtr(this.smallImageText);
        this._presence.partyId = this.StrToPtr(this.partyId);
        this._presence.partySize = this.partySize;
        this._presence.partyMax = this.partyMax;
        this._presence.matchSecret = this.StrToPtr(this.matchSecret);
        this._presence.joinSecret = this.StrToPtr(this.joinSecret);
        this._presence.spectateSecret = this.StrToPtr(this.spectateSecret);
        this._presence.instance = this.instance;
        return this._presence;
      }

      private IntPtr StrToPtr(string input)
      {
        if (string.IsNullOrEmpty(input))
          return IntPtr.Zero;
        int byteCount = Encoding.UTF8.GetByteCount(input);
        IntPtr num = Marshal.AllocHGlobal(byteCount + 1);
        for (int ofs = 0; ofs < byteCount + 1; ++ofs)
          Marshal.WriteByte(num, ofs, (byte) 0);
        this._buffers.Add(num);
        Marshal.Copy(Encoding.UTF8.GetBytes(input), 0, num, byteCount);
        return num;
      }

      private static string StrToUtf8NullTerm(string toconv)
      {
        string s = toconv.Trim();
        byte[] bytes = Encoding.Default.GetBytes(s);
        if (bytes.Length != 0 && bytes[bytes.Length - 1] != (byte) 0)
          s += "\0\0";
        return Encoding.UTF8.GetString(Encoding.UTF8.GetBytes(s));
      }

      internal void FreeMem()
      {
        for (int index = this._buffers.Count - 1; index >= 0; --index)
        {
          Marshal.FreeHGlobal(this._buffers[index]);
          this._buffers.RemoveAt(index);
        }
      }
    }
  }
}
