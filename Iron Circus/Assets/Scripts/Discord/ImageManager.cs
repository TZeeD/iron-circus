// Decompiled with JetBrains decompiler
// Type: Discord.ImageManager
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Runtime.InteropServices;
using UnityEngine;

namespace Discord
{
  public class ImageManager
  {
    private IntPtr MethodsPtr;
    private object MethodsStructure;

    private ImageManager.FFIMethods Methods
    {
      get
      {
        if (this.MethodsStructure == null)
          this.MethodsStructure = Marshal.PtrToStructure(this.MethodsPtr, typeof (ImageManager.FFIMethods));
        return (ImageManager.FFIMethods) this.MethodsStructure;
      }
    }

    internal ImageManager(IntPtr ptr, IntPtr eventsPtr, ref ImageManager.FFIEvents events)
    {
      if (eventsPtr == IntPtr.Zero)
        throw new ResultException(Result.InternalError);
      this.InitEvents(eventsPtr, ref events);
      this.MethodsPtr = ptr;
      if (this.MethodsPtr == IntPtr.Zero)
        throw new ResultException(Result.InternalError);
    }

    private void InitEvents(IntPtr eventsPtr, ref ImageManager.FFIEvents events) => Marshal.StructureToPtr<ImageManager.FFIEvents>(events, eventsPtr, false);

    public void Fetch(ImageHandle handle, bool refresh, ImageManager.FetchHandler callback)
    {
      ImageManager.FFIMethods.FetchCallback callback1 = (ImageManager.FFIMethods.FetchCallback) ((ptr, result, handleResult) =>
      {
        Utility.Release(ptr);
        callback(result, handleResult);
      });
      this.Methods.Fetch(this.MethodsPtr, handle, refresh, Utility.Retain<ImageManager.FFIMethods.FetchCallback>(callback1), callback1);
    }

    public ImageDimensions GetDimensions(ImageHandle handle)
    {
      ImageDimensions dimensions = new ImageDimensions();
      Result result = this.Methods.GetDimensions(this.MethodsPtr, handle, ref dimensions);
      if (result != Result.Ok)
        throw new ResultException(result);
      return dimensions;
    }

    public void GetData(ImageHandle handle, byte[] data)
    {
      Result result = this.Methods.GetData(this.MethodsPtr, handle, data, data.Length);
      if (result != Result.Ok)
        throw new ResultException(result);
    }

    public void Fetch(ImageHandle handle, ImageManager.FetchHandler callback) => this.Fetch(handle, false, callback);

    public byte[] GetData(ImageHandle handle)
    {
      ImageDimensions dimensions = this.GetDimensions(handle);
      byte[] data = new byte[(int) dimensions.Width * (int) dimensions.Height * 4];
      this.GetData(handle, data);
      return data;
    }

    public Texture2D GetTexture(ImageHandle handle)
    {
      ImageDimensions dimensions = this.GetDimensions(handle);
      Texture2D texture2D = new Texture2D((int) dimensions.Width, (int) dimensions.Height, TextureFormat.RGBA32, false, true);
      texture2D.LoadRawTextureData(this.GetData(handle));
      texture2D.Apply();
      return texture2D;
    }

    internal struct FFIEvents
    {
    }

    internal struct FFIMethods
    {
      internal ImageManager.FFIMethods.FetchMethod Fetch;
      internal ImageManager.FFIMethods.GetDimensionsMethod GetDimensions;
      internal ImageManager.FFIMethods.GetDataMethod GetData;

      [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
      internal delegate void FetchCallback(IntPtr ptr, Result result, ImageHandle handleResult);

      [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
      internal delegate void FetchMethod(
        IntPtr methodsPtr,
        ImageHandle handle,
        bool refresh,
        IntPtr callbackData,
        ImageManager.FFIMethods.FetchCallback callback);

      [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
      internal delegate Result GetDimensionsMethod(
        IntPtr methodsPtr,
        ImageHandle handle,
        ref ImageDimensions dimensions);

      [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
      internal delegate Result GetDataMethod(
        IntPtr methodsPtr,
        ImageHandle handle,
        byte[] data,
        int dataLen);
    }

    public delegate void FetchHandler(Result result, ImageHandle handleResult);
  }
}
