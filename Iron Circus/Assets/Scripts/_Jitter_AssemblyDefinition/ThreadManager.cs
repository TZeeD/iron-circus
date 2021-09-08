// Decompiled with JetBrains decompiler
// Type: Jitter.ThreadManager
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using System;
using System.Collections.Generic;
using System.Threading;

namespace Jitter
{
  public class ThreadManager
  {
    public const int ThreadsPerProcessor = 1;
    private ManualResetEvent waitHandleA;
    private ManualResetEvent waitHandleB;
    private ManualResetEvent currentWaitHandle;
    private volatile List<Action<object>> tasks = new List<Action<object>>();
    private volatile List<object> parameters = new List<object>();
    private Thread[] threads;
    private int currentTaskIndex;
    private int waitingThreadCount;
    internal int threadCount;
    private static ThreadManager instance;

    public int ThreadCount
    {
      private set => this.threadCount = value;
      get => this.threadCount;
    }

    public static ThreadManager Instance
    {
      get
      {
        if (ThreadManager.instance == null)
        {
          ThreadManager.instance = new ThreadManager();
          ThreadManager.instance.Initialize();
        }
        return ThreadManager.instance;
      }
    }

    private ThreadManager()
    {
    }

    private void Initialize()
    {
      this.threadCount = Environment.ProcessorCount;
      this.threads = new Thread[this.threadCount];
      this.waitHandleA = new ManualResetEvent(false);
      this.waitHandleB = new ManualResetEvent(false);
      this.currentWaitHandle = this.waitHandleA;
      AutoResetEvent initWaitHandle = new AutoResetEvent(false);
      for (int index = 1; index < this.threads.Length; ++index)
      {
        this.threads[index] = ThreadManager.NewThread((ThreadStart) (() =>
        {
          initWaitHandle.Set();
          this.ThreadProc();
        }));
        this.threads[index].Start();
        initWaitHandle.WaitOne();
      }
    }

    public void Execute()
    {
      this.currentTaskIndex = 0;
      this.waitingThreadCount = 0;
      this.currentWaitHandle.Set();
      this.PumpTasks();
      while (this.waitingThreadCount < this.threads.Length - 1)
        ThreadManager.ThreadSleep(0);
      this.currentWaitHandle.Reset();
      this.currentWaitHandle = this.currentWaitHandle == this.waitHandleA ? this.waitHandleB : this.waitHandleA;
      this.tasks.Clear();
      this.parameters.Clear();
    }

    public void AddTask(Action<object> task, object param)
    {
      this.tasks.Add(task);
      this.parameters.Add(param);
    }

    private void ThreadProc()
    {
      while (true)
      {
        Interlocked.Increment(ref this.waitingThreadCount);
        this.waitHandleA.WaitOne();
        this.PumpTasks();
        Interlocked.Increment(ref this.waitingThreadCount);
        this.waitHandleB.WaitOne();
        this.PumpTasks();
      }
    }

    private void PumpTasks()
    {
      int count = this.tasks.Count;
      while (this.currentTaskIndex < count)
      {
        int currentTaskIndex = this.currentTaskIndex;
        if (currentTaskIndex == Interlocked.CompareExchange(ref this.currentTaskIndex, currentTaskIndex + 1, currentTaskIndex) && currentTaskIndex < count)
          this.tasks[currentTaskIndex](this.parameters[currentTaskIndex]);
      }
    }

    private static void ThreadSleep(int dueTime) => Thread.Sleep(dueTime);

    private static Thread NewThread(ThreadStart action) => new Thread(action)
    {
      IsBackground = true
    };
  }
}
