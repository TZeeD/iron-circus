using System;
using UnityEngine;

[Serializable]
public class CameraPose
{
	public CameraPose(Vector3 positionOffset, Quaternion rotationOffset, float fov, bool hasRotation)
	{
	}

	public SerializableVector3 positionOffset;
	public SerializableQuaternion rotationOffset;
	public float fov;
	public bool hasRotation;
	public string fileName;
}
