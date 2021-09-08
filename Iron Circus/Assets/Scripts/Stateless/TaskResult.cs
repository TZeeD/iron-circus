// Decompiled with JetBrains decompiler
// Type: Stateless.TaskResult
// Assembly: Stateless, Version=4.0.0.0, Culture=neutral, PublicKeyToken=93038f0927583c9a
// MVID: D5FEF726-C279-4B52-9490-86A1B7282D93
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Stateless.dll

using System.Threading.Tasks;

namespace Stateless
{
  internal static class TaskResult
  {
    internal static readonly Task Done = (Task) TaskResult.FromResult<int>(1);

    private static Task<T> FromResult<T>(T value)
    {
      TaskCompletionSource<T> completionSource = new TaskCompletionSource<T>();
      completionSource.SetResult(value);
      return completionSource.Task;
    }
  }
}
