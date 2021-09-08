// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Utils.InspectorClient
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Networking.Messages.SerDes;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.Networking.Messages.SerDes;
using Imi.SharedWithServer.ScEntitas.Components;
using Jitter.LinearMath;
using SteelCircus.NiceIO;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Threading;

namespace Imi.SharedWithServer.Utils
{
  public class InspectorClient : IInspectorClient
  {
    private CancellationTokenSource cancelCts = new CancellationTokenSource();
    private CancellationToken cancelToken;
    private Thread thread;
    private BlockingCollection<InspectorClient.DataChunk> queue = new BlockingCollection<InspectorClient.DataChunk>();
    private volatile bool readyForTicks;
    private volatile bool isConnected;
    private bool writeLocalFile;
    public static byte[] magicToken = new byte[8]
    {
      (byte) 222,
      (byte) 173,
      (byte) 190,
      (byte) 239,
      (byte) 222,
      (byte) 173,
      (byte) 190,
      (byte) 239
    };
    public static string TickSection = "__t";
    private static int defaultSerializationBufferSize = 16384;
    private List<InspectorClient.Section> sections = new List<InspectorClient.Section>();
    private bool isServer;
    private ulong playerId;

    public void Start(bool server, ulong _playerId, IPAddress serverIp = null, bool _writeLocalFile = false)
    {
      this.isServer = server;
      this.playerId = _playerId;
      this.cancelToken = this.cancelCts.Token;
      if (serverIp == null)
        serverIp = IPAddress.Parse("127.0.0.1");
      this.writeLocalFile = _writeLocalFile;
      this.thread = new Thread(new ParameterizedThreadStart(this.ThreadFunc));
      this.thread.Name = "InspectorClient Tcp Writer";
      this.thread.Start((object) serverIp);
      this.IsStarted = true;
    }

    public void Stop()
    {
      if (this.thread == null)
        return;
      this.SendAsync(InspectorClient.DataType.Close, (byte[]) null, 0);
      this.IsStarted = false;
      this.cancelCts.Cancel();
      this.thread.Join(1000);
      this.thread = (Thread) null;
      this.cancelCts = new CancellationTokenSource();
      this.readyForTicks = false;
      this.isConnected = false;
    }

    public void OnSessionStart(string sessionId)
    {
      if (!this.readyForTicks)
        return;
      MessageBitSerializer messageBitSerializer = new MessageBitSerializer();
      messageBitSerializer.Begin(InspectorClient.defaultSerializationBufferSize);
      messageBitSerializer.String(ref sessionId);
      messageBitSerializer.Finish();
      this.SendAsync(InspectorClient.DataType.SessionStart, messageBitSerializer.GetBuffer(), messageBitSerializer.GetBytesRequired());
    }

    public bool IsStarted { get; private set; }

    public void Flush()
    {
      if (!this.readyForTicks)
        return;
      this.SendAsync(InspectorClient.DataType.Flush, (byte[]) null, 0);
    }

    public void TickBegin(int tick, float time) => this.DoSectionBegin(InspectorClient.TickSection, tick, time);

    public void TickEnd() => this.SectionEnd(InspectorClient.TickSection);

    public void OnMispredict(
      int baseline,
      int remoteTick,
      int clientTick,
      int mispredictReason,
      string debugData)
    {
      if (!this.readyForTicks)
        return;
      MessageBitSerializer messageBitSerializer = new MessageBitSerializer();
      messageBitSerializer.Begin(InspectorClient.defaultSerializationBufferSize);
      messageBitSerializer.Int(ref baseline);
      messageBitSerializer.Int(ref remoteTick);
      messageBitSerializer.Int(ref clientTick);
      mispredictReason |= int.MinValue;
      messageBitSerializer.Int(ref mispredictReason);
      messageBitSerializer.String(ref debugData);
      messageBitSerializer.Finish();
      this.SendAsync(InspectorClient.DataType.Mispredict, messageBitSerializer.GetBuffer(), messageBitSerializer.GetBytesRequired());
    }

    public void OnJumpToFuture(int currentTick, int remoteTick)
    {
      if (!this.readyForTicks)
        return;
      MessageBitSerializer messageBitSerializer = new MessageBitSerializer();
      messageBitSerializer.Begin(InspectorClient.defaultSerializationBufferSize);
      messageBitSerializer.Int(ref currentTick);
      messageBitSerializer.Int(ref remoteTick);
      messageBitSerializer.Finish();
      this.SendAsync(InspectorClient.DataType.JumpToFuture, messageBitSerializer.GetBuffer(), messageBitSerializer.GetBytesRequired());
    }

    public void SetInput(ulong playerId, JVector moveDir, int buttonType)
    {
      if (!this.readyForTicks)
        return;
      MessageBitSerializer messageBitSerializer = new MessageBitSerializer();
      messageBitSerializer.Begin(InspectorClient.defaultSerializationBufferSize);
      messageBitSerializer.ULong(ref playerId);
      messageBitSerializer.Float(ref moveDir.X);
      messageBitSerializer.Float(ref moveDir.Y);
      messageBitSerializer.Float(ref moveDir.Z);
      messageBitSerializer.Int(ref buttonType);
      messageBitSerializer.Finish();
      this.SendAsync(InspectorClient.DataType.Input, messageBitSerializer.GetBuffer(), messageBitSerializer.GetBytesRequired());
    }

    public void SetTransform(ulong playerId, JVector pos, JVector rotEuler, JVector vel)
    {
      if (!this.readyForTicks)
        return;
      MessageBitSerializer messageBitSerializer = new MessageBitSerializer();
      messageBitSerializer.Begin(InspectorClient.defaultSerializationBufferSize);
      messageBitSerializer.ULong(ref playerId);
      messageBitSerializer.Float(ref pos.X);
      messageBitSerializer.Float(ref pos.Y);
      messageBitSerializer.Float(ref pos.Z);
      messageBitSerializer.Float(ref rotEuler.X);
      messageBitSerializer.Float(ref rotEuler.Y);
      messageBitSerializer.Float(ref rotEuler.Z);
      messageBitSerializer.Float(ref vel.X);
      messageBitSerializer.Float(ref vel.Y);
      messageBitSerializer.Float(ref vel.Z);
      messageBitSerializer.Finish();
      this.SendAsync(InspectorClient.DataType.Transform, messageBitSerializer.GetBuffer(), messageBitSerializer.GetBytesRequired());
    }

    public void SetStateMachines(ulong playerId, SerializedSkillGraphs sm)
    {
      if (!this.readyForTicks || sm == null)
        return;
      MessageBitSerializer messageBitSerializer = new MessageBitSerializer();
      messageBitSerializer.Begin(InspectorClient.defaultSerializationBufferSize);
      messageBitSerializer.ULong(ref playerId);
      sm.SerializeOrDeserialize((IMessageSerDes) messageBitSerializer);
      messageBitSerializer.Finish();
      this.SendAsync(InspectorClient.DataType.Statemachines, messageBitSerializer.GetBuffer(), messageBitSerializer.GetBytesRequired());
    }

    public void SetStatusEffects(ulong playerId, SerializedStatusEffects se)
    {
      if (!this.readyForTicks || se == null)
        return;
      MessageBitSerializer messageBitSerializer = new MessageBitSerializer();
      messageBitSerializer.Begin(InspectorClient.defaultSerializationBufferSize);
      messageBitSerializer.ULong(ref playerId);
      se.SerializeOrDeserialize((IMessageSerDes) messageBitSerializer);
      messageBitSerializer.Finish();
      this.SendAsync(InspectorClient.DataType.Statuseffects, messageBitSerializer.GetBuffer(), messageBitSerializer.GetBytesRequired());
    }

    public void SetAnimationStates(ulong playerId, AnimationStates ani)
    {
      if (!this.readyForTicks || ani == null)
        return;
      MessageBitSerializer messageBitSerializer = new MessageBitSerializer();
      messageBitSerializer.Begin(InspectorClient.defaultSerializationBufferSize);
      messageBitSerializer.ULong(ref playerId);
      ani.SerializeOrDeserialize((IMessageSerDes) messageBitSerializer);
      messageBitSerializer.Finish();
      this.SendAsync(InspectorClient.DataType.Animations, messageBitSerializer.GetBuffer(), messageBitSerializer.GetBytesRequired());
    }

    public void OnInputDuplicate(ulong playerId, int lastKnownInputTick)
    {
      if (!this.readyForTicks)
        return;
      MessageBitSerializer messageBitSerializer = new MessageBitSerializer();
      messageBitSerializer.Begin(InspectorClient.defaultSerializationBufferSize);
      messageBitSerializer.ULong(ref playerId);
      messageBitSerializer.Int(ref lastKnownInputTick);
      messageBitSerializer.Finish();
      this.SendAsync(InspectorClient.DataType.InputDuplicate, messageBitSerializer.GetBuffer(), messageBitSerializer.GetBytesRequired());
    }

    public void SectionBegin(string name, int tick) => this.DoSectionBegin(name, tick, 0.0f);

    private void DoSectionBegin(string name, int tick, float time)
    {
      if (!this.readyForTicks)
      {
        if (!(name == InspectorClient.TickSection) || !this.isConnected)
          return;
        this.readyForTicks = true;
      }
      lock (this.sections)
        this.sections.Add(new InspectorClient.Section()
        {
          name = name,
          start = DateTime.Now
        });
      MessageBitSerializer messageBitSerializer = new MessageBitSerializer();
      messageBitSerializer.Begin(InspectorClient.defaultSerializationBufferSize);
      messageBitSerializer.String(ref name);
      messageBitSerializer.Int(ref tick);
      messageBitSerializer.Float(ref time);
      messageBitSerializer.Finish();
      this.SendAsync(InspectorClient.DataType.SectionBegin, messageBitSerializer.GetBuffer(), messageBitSerializer.GetBytesRequired());
      if (!(name == InspectorClient.TickSection))
        return;
      this.ReportMemory();
    }

    public void SectionEnd(string name)
    {
      if (!this.readyForTicks)
        return;
      float num = 0.0f;
      lock (this.sections)
      {
        num = (float) (DateTime.Now - this.sections[this.sections.Count - 1].start).TotalSeconds;
        this.sections.RemoveAt(this.sections.Count - 1);
      }
      MessageBitSerializer messageBitSerializer = new MessageBitSerializer();
      messageBitSerializer.Begin(InspectorClient.defaultSerializationBufferSize);
      messageBitSerializer.Float(ref num);
      messageBitSerializer.Finish();
      this.SendAsync(InspectorClient.DataType.SectionEnd, messageBitSerializer.GetBuffer(), messageBitSerializer.GetBytesRequired());
      if (this.sections.Count != 0)
        return;
      this.FlushQueue();
    }

    public void SendLog(string msg)
    {
      if (!this.readyForTicks)
        return;
      MessageBitSerializer messageBitSerializer = new MessageBitSerializer();
      messageBitSerializer.Begin(65536);
      messageBitSerializer.String(ref msg);
      messageBitSerializer.Finish();
      this.SendAsync(InspectorClient.DataType.Log, messageBitSerializer.GetBuffer(), messageBitSerializer.GetBytesRequired());
    }

    public void ReportMemory()
    {
      if (!this.readyForTicks)
        return;
      int maxGeneration = GC.MaxGeneration;
      long totalMemory = GC.GetTotalMemory(false);
      MessageBitSerializer messageBitSerializer = new MessageBitSerializer();
      messageBitSerializer.Begin(65536);
      messageBitSerializer.Int(ref maxGeneration);
      messageBitSerializer.Long(ref totalMemory);
      for (int generation = 0; generation <= maxGeneration; ++generation)
      {
        int num = GC.CollectionCount(generation);
        messageBitSerializer.Int(ref num);
      }
      messageBitSerializer.Finish();
      this.SendAsync(InspectorClient.DataType.Memory, messageBitSerializer.GetBuffer(), messageBitSerializer.GetBytesRequired());
    }

    private void FlushQueue() => this.queue.Add(new InspectorClient.DataChunk()
    {
      type = InspectorClient.DataType.InternalFlushQueue,
      data = (byte[]) null,
      size = 0
    });

    public void SendAsync(InspectorClient.DataType type, byte[] data, int dataSize)
    {
      if (!this.readyForTicks)
        return;
      this.queue.Add(new InspectorClient.DataChunk()
      {
        type = type,
        data = data,
        size = dataSize
      });
    }

    private void WriteHeader(Stream s)
    {
      if (s == null)
        return;
      byte num1 = 0;
      MessageBitSerializer s1 = new MessageBitSerializer();
      s1.Begin(InspectorClient.defaultSerializationBufferSize);
      s1.Byte(ref num1);
      s1.Bool(ref this.isServer);
      string str = this.isServer ? "Server" : "Client";
      ulong num2 = this.isServer ? 0UL : this.playerId;
      s1.ULong(ref num2);
      s1.String(ref str);
      this.WriteEndToken(s1);
      s1.Finish();
      s.Write(s1.GetBuffer(), 0, s1.GetBytesRequired());
    }

    private void WriteEndToken(MessageBitSerializer s)
    {
      for (int index = 0; index < InspectorClient.magicToken.Length; ++index)
        s.Byte(ref InspectorClient.magicToken[index]);
    }

    private Stream StartFileStream()
    {
      foreach (string path in NPath.CurrentDirectory.Files("*.iir").Select<NPath, FileInfo>((Func<NPath, FileInfo>) (filePath => new FileInfo((string) filePath))).OrderByDescending<FileInfo, DateTime>((Func<FileInfo, DateTime>) (fileInfo => fileInfo.LastWriteTime)).Skip<FileInfo>(4).Select<FileInfo, string>((Func<FileInfo, string>) (info => info.FullName)).ToArray<string>())
        System.IO.File.Delete(path);
      string path1 = "session_" + DateTime.Now.ToString("yyyy-MM-dd_HH-mm-ss") + ".iir";
      try
      {
        return (Stream) System.IO.File.Create(path1);
      }
      catch (Exception ex)
      {
        return (Stream) null;
      }
    }

    private void ThreadFunc(object ipAddress)
    {
      TcpClient tcpClient = new TcpClient();
      tcpClient.NoDelay = true;
      Stopwatch stopwatch = Stopwatch.StartNew();
      bool flag = false;
      while (!this.cancelToken.IsCancellationRequested)
      {
        try
        {
          if (stopwatch.ElapsedMilliseconds > 10000L)
            flag = true;
          tcpClient.Connect(new IPEndPoint((IPAddress) ipAddress, 40001));
        }
        catch (Exception ex)
        {
          Thread.Sleep(100);
        }
        if (tcpClient.Connected || this.writeLocalFile)
          break;
      }
      if (this.cancelToken.IsCancellationRequested | flag)
        return;
      this.isConnected = true;
      try
      {
        Stream stream1 = tcpClient.Connected ? (Stream) tcpClient.GetStream() : (Stream) null;
        Stream stream2 = this.writeLocalFile ? this.StartFileStream() : (Stream) null;
        this.WriteHeader(stream1);
        this.WriteHeader(stream2);
        byte[] buffer = new byte[65536];
        int bufferStartIndex = 0;
        byte[] newData = new byte[1 + InspectorClient.magicToken.Length];
        foreach (InspectorClient.DataChunk consuming in this.queue.GetConsumingEnumerable())
        {
          if (consuming.type == InspectorClient.DataType.InternalFlushQueue)
          {
            this.FlushBuffer(buffer, ref bufferStartIndex, stream1, stream2);
          }
          else
          {
            newData[0] = (byte) consuming.type;
            this.AddToBuffer(buffer, ref bufferStartIndex, newData, 1, stream1, stream2);
            if (consuming.size > 0)
              this.AddToBuffer(buffer, ref bufferStartIndex, consuming.data, consuming.size, stream1, stream2);
            this.AddToBuffer(buffer, ref bufferStartIndex, InspectorClient.magicToken, InspectorClient.magicToken.Length, stream1, stream2);
            if (consuming.type == InspectorClient.DataType.Close)
            {
              this.FlushBuffer(buffer, ref bufferStartIndex, stream1, stream2);
              Thread.Sleep(100);
              break;
            }
          }
        }
      }
      catch (Exception ex)
      {
      }
      this.isConnected = false;
      if (!tcpClient.Connected)
        return;
      tcpClient.Close();
    }

    private void FlushBuffer(
      byte[] buffer,
      ref int bufferStartIndex,
      Stream stream0,
      Stream stream1)
    {
      stream0?.Write(buffer, 0, bufferStartIndex);
      stream1?.Write(buffer, 0, bufferStartIndex);
      bufferStartIndex = 0;
    }

    private void AddToBuffer(
      byte[] buffer,
      ref int bufferStartIndex,
      byte[] newData,
      int newDataSize,
      Stream stream0,
      Stream stream1)
    {
      int num = buffer.Length - bufferStartIndex;
      if (newDataSize > num)
        this.FlushBuffer(buffer, ref bufferStartIndex, stream0, stream1);
      Array.Copy((Array) newData, 0, (Array) buffer, bufferStartIndex, newDataSize);
      bufferStartIndex += newDataSize;
    }

    private class DataChunk
    {
      public InspectorClient.DataType type;
      public byte[] data;
      public int size;
    }

    public enum DataType
    {
      Header,
      SectionBegin,
      SectionEnd,
      Mispredict,
      InputDuplicate,
      Input,
      Flush,
      Transform,
      InternalFlushQueue,
      Statemachines,
      Statuseffects,
      Log,
      JumpToFuture,
      Close,
      Animations,
      SessionStart,
      Memory,
    }

    private class Section
    {
      public string name;
      public DateTime start;
    }

    public enum MispredictReason
    {
      Transform = 1,
      Statemachines = 2,
      StatusEffects = 4,
      Animations = 8,
    }
  }
}
