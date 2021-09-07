using System;
using UnityEngine;

[Serializable]
public class SerializableDictionary<TKey, TValue>
{
	[SerializeField]
	private int[] _Buckets;
	[SerializeField]
	private int[] _HashCodes;
	[SerializeField]
	private int[] _Next;
	[SerializeField]
	private int _Count;
	[SerializeField]
	private int _Version;
	[SerializeField]
	private int _FreeList;
	[SerializeField]
	private int _FreeCount;
	[SerializeField]
	private TKey[] _Keys;
	[SerializeField]
	private TValue[] _Values;
}
