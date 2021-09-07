using System;
using UnityEngine.Rendering.PostProcessing;

[Serializable]
public class UserLUT : PostProcessEffectSettings
{
	public TextureParameter lut;
	public FloatParameter blend;
	public BoolParameter useBackgroundLut;
	public TextureParameter backgroundLut;
	public FloatParameter backgroundBlendStart;
	public FloatParameter backgroundBlendRange;
}
