// Decompiled with JetBrains decompiler
// Type: Coffee.UIExtensions.ParameterTexture
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Collections.Generic;
using UnityEngine;

namespace Coffee.UIExtensions
{
  [Serializable]
  public class ParameterTexture
  {
    private Texture2D _texture;
    private bool _needUpload;
    private int _propertyId;
    private readonly string _propertyName;
    private readonly int _channels;
    private readonly int _instanceLimit;
    private readonly byte[] _data;
    private readonly Stack<int> _stack;
    private static List<Action> updates;

    public ParameterTexture(int channels, int instanceLimit, string propertyName)
    {
      this._propertyName = propertyName;
      this._channels = ((channels - 1) / 4 + 1) * 4;
      this._instanceLimit = ((instanceLimit - 1) / 2 + 1) * 2;
      this._data = new byte[this._channels * this._instanceLimit];
      this._stack = new Stack<int>(this._instanceLimit);
      for (int index = 1; index < this._instanceLimit + 1; ++index)
        this._stack.Push(index);
    }

    public void Register(IParameterTexture target)
    {
      this.Initialize();
      if (target.parameterIndex > 0 || 0 >= this._stack.Count)
        return;
      target.parameterIndex = this._stack.Pop();
    }

    public void Unregister(IParameterTexture target)
    {
      if (0 >= target.parameterIndex)
        return;
      this._stack.Push(target.parameterIndex);
      target.parameterIndex = 0;
    }

    public void SetData(IParameterTexture target, int channelId, byte value)
    {
      int index = (target.parameterIndex - 1) * this._channels + channelId;
      if (0 >= target.parameterIndex || (int) this._data[index] == (int) value)
        return;
      this._data[index] = value;
      this._needUpload = true;
    }

    public void SetData(IParameterTexture target, int channelId, float value) => this.SetData(target, channelId, (byte) ((double) Mathf.Clamp01(value) * (double) byte.MaxValue));

    public void RegisterMaterial(Material mat)
    {
      if (this._propertyId == 0)
        this._propertyId = Shader.PropertyToID(this._propertyName);
      if (!(bool) (UnityEngine.Object) mat)
        return;
      mat.SetTexture(this._propertyId, (Texture) this._texture);
    }

    public float GetNormalizedIndex(IParameterTexture target) => ((float) target.parameterIndex - 0.5f) / (float) this._instanceLimit;

    private void Initialize()
    {
      if (ParameterTexture.updates == null)
      {
        ParameterTexture.updates = new List<Action>();
        Canvas.willRenderCanvases += (Canvas.WillRenderCanvases) (() =>
        {
          int count = ParameterTexture.updates.Count;
          for (int index = 0; index < count; ++index)
            ParameterTexture.updates[index]();
        });
      }
      if ((bool) (UnityEngine.Object) this._texture)
        return;
      this._texture = new Texture2D(this._channels / 4, this._instanceLimit, TextureFormat.RGBA32, false, QualitySettings.activeColorSpace == ColorSpace.Linear);
      this._texture.filterMode = FilterMode.Point;
      this._texture.wrapMode = TextureWrapMode.Clamp;
      ParameterTexture.updates.Add(new Action(this.UpdateParameterTexture));
      this._needUpload = true;
    }

    private void UpdateParameterTexture()
    {
      if (!this._needUpload || !(bool) (UnityEngine.Object) this._texture)
        return;
      this._needUpload = false;
      this._texture.LoadRawTextureData(this._data);
      this._texture.Apply(false, false);
    }
  }
}
