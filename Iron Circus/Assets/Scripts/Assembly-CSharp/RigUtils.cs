using System;
using UnityEngine;

public class RigUtils
{
	[Serializable]
	public struct Bone
	{
		public Transform transform;
		public RigUtils.Axis upAxis;
	}

	public enum Axis
	{
		Up = 0,
		Down = 1,
		Forward = 2,
		Back = 3,
		Right = 4,
		Left = 5,
	}

	public float maxAngle;
	public float rotationAmount;
	public bool preview;
	public Transform target;
	public Transform root;
	public Axis rootForward;
	public Bone[] bones;
}
