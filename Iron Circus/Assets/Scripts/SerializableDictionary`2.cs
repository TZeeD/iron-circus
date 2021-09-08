// Decompiled with JetBrains decompiler
// Type: SerializableDictionary`2
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using UnityEngine;

[DebuggerDisplay("Count = {Count}")]
[Serializable]
public class SerializableDictionary<TKey, TValue> : 
  IDictionary<TKey, TValue>,
  ICollection<KeyValuePair<TKey, TValue>>,
  IEnumerable<KeyValuePair<TKey, TValue>>,
  IEnumerable
{
  [SerializeField]
  [HideInInspector]
  private int[] _Buckets;
  [SerializeField]
  [HideInInspector]
  private int[] _HashCodes;
  [SerializeField]
  [HideInInspector]
  private int[] _Next;
  [SerializeField]
  [HideInInspector]
  private int _Count;
  [SerializeField]
  [HideInInspector]
  private int _Version;
  [SerializeField]
  [HideInInspector]
  private int _FreeList;
  [SerializeField]
  [HideInInspector]
  private int _FreeCount;
  [SerializeField]
  [HideInInspector]
  private TKey[] _Keys;
  [SerializeField]
  [HideInInspector]
  private TValue[] _Values;
  private readonly IEqualityComparer<TKey> _Comparer;

  public Dictionary<TKey, TValue> AsDictionary => new Dictionary<TKey, TValue>((IDictionary<TKey, TValue>) this);

  public int Count => this._Count - this._FreeCount;

  public TValue this[TKey key, TValue defaultValue]
  {
    get
    {
      int index = this.FindIndex(key);
      return index >= 0 ? this._Values[index] : defaultValue;
    }
  }

  public TValue this[TKey key]
  {
    get
    {
      int index = this.FindIndex(key);
      return index >= 0 ? this._Values[index] : throw new KeyNotFoundException(key.ToString());
    }
    set => this.Insert(key, value, false);
  }

  public SerializableDictionary()
    : this(0, (IEqualityComparer<TKey>) null)
  {
  }

  public SerializableDictionary(int capacity)
    : this(capacity, (IEqualityComparer<TKey>) null)
  {
  }

  public SerializableDictionary(IEqualityComparer<TKey> comparer)
    : this(0, comparer)
  {
  }

  public SerializableDictionary(int capacity, IEqualityComparer<TKey> comparer)
  {
    if (capacity < 0)
      throw new ArgumentOutOfRangeException(nameof (capacity));
    this.Initialize(capacity);
    this._Comparer = comparer ?? (IEqualityComparer<TKey>) EqualityComparer<TKey>.Default;
  }

  public SerializableDictionary(IDictionary<TKey, TValue> dictionary)
    : this(dictionary, (IEqualityComparer<TKey>) null)
  {
  }

  public SerializableDictionary(
    IDictionary<TKey, TValue> dictionary,
    IEqualityComparer<TKey> comparer)
    : this(dictionary != null ? dictionary.Count : 0, comparer)
  {
    if (dictionary == null)
      throw new ArgumentNullException(nameof (dictionary));
    foreach (KeyValuePair<TKey, TValue> keyValuePair in (IEnumerable<KeyValuePair<TKey, TValue>>) dictionary)
      this.Add(keyValuePair.Key, keyValuePair.Value);
  }

  public bool ContainsValue(TValue value)
  {
    if ((object) value == null)
    {
      for (int index = 0; index < this._Count; ++index)
      {
        if (this._HashCodes[index] >= 0 && (object) this._Values[index] == null)
          return true;
      }
    }
    else
    {
      EqualityComparer<TValue> equalityComparer = EqualityComparer<TValue>.Default;
      for (int index = 0; index < this._Count; ++index)
      {
        if (this._HashCodes[index] >= 0 && equalityComparer.Equals(this._Values[index], value))
          return true;
      }
    }
    return false;
  }

  public bool ContainsKey(TKey key) => this.FindIndex(key) >= 0;

  public void Clear()
  {
    if (this._Count <= 0)
      return;
    for (int index = 0; index < this._Buckets.Length; ++index)
      this._Buckets[index] = -1;
    Array.Clear((Array) this._Keys, 0, this._Count);
    Array.Clear((Array) this._Values, 0, this._Count);
    Array.Clear((Array) this._HashCodes, 0, this._Count);
    Array.Clear((Array) this._Next, 0, this._Count);
    this._FreeList = -1;
    this._Count = 0;
    this._FreeCount = 0;
    ++this._Version;
  }

  public void Add(TKey key, TValue value) => this.Insert(key, value, true);

  private void Resize(int newSize, bool forceNewHashCodes)
  {
    int[] numArray1 = new int[newSize];
    for (int index = 0; index < numArray1.Length; ++index)
      numArray1[index] = -1;
    TKey[] keyArray = new TKey[newSize];
    TValue[] objArray = new TValue[newSize];
    int[] numArray2 = new int[newSize];
    int[] numArray3 = new int[newSize];
    Array.Copy((Array) this._Values, 0, (Array) objArray, 0, this._Count);
    Array.Copy((Array) this._Keys, 0, (Array) keyArray, 0, this._Count);
    Array.Copy((Array) this._HashCodes, 0, (Array) numArray2, 0, this._Count);
    Array.Copy((Array) this._Next, 0, (Array) numArray3, 0, this._Count);
    if (forceNewHashCodes)
    {
      for (int index = 0; index < this._Count; ++index)
      {
        if (numArray2[index] != -1)
          numArray2[index] = this._Comparer.GetHashCode(keyArray[index]) & int.MaxValue;
      }
    }
    for (int index1 = 0; index1 < this._Count; ++index1)
    {
      int index2 = numArray2[index1] % newSize;
      numArray3[index1] = numArray1[index2];
      numArray1[index2] = index1;
    }
    this._Buckets = numArray1;
    this._Keys = keyArray;
    this._Values = objArray;
    this._HashCodes = numArray2;
    this._Next = numArray3;
  }

  private void Resize() => this.Resize(SerializableDictionary<TKey, TValue>.PrimeHelper.ExpandPrime(this._Count), false);

  public bool Remove(TKey key)
  {
    if ((object) key == null)
      throw new ArgumentNullException(nameof (key));
    int num = this._Comparer.GetHashCode(key) & int.MaxValue;
    int index1 = num % this._Buckets.Length;
    int index2 = -1;
    for (int bucket = this._Buckets[index1]; bucket >= 0; bucket = this._Next[bucket])
    {
      if (this._HashCodes[bucket] == num && this._Comparer.Equals(this._Keys[bucket], key))
      {
        if (index2 < 0)
          this._Buckets[index1] = this._Next[bucket];
        else
          this._Next[index2] = this._Next[bucket];
        this._HashCodes[bucket] = -1;
        this._Next[bucket] = this._FreeList;
        this._Keys[bucket] = default (TKey);
        this._Values[bucket] = default (TValue);
        this._FreeList = bucket;
        ++this._FreeCount;
        ++this._Version;
        return true;
      }
      index2 = bucket;
    }
    return false;
  }

  private void Insert(TKey key, TValue value, bool add)
  {
    if ((object) key == null)
      throw new ArgumentNullException(nameof (key));
    if (this._Buckets == null)
      this.Initialize(0);
    int num1 = this._Comparer.GetHashCode(key) & int.MaxValue;
    int index1 = num1 % this._Buckets.Length;
    int num2 = 0;
    for (int bucket = this._Buckets[index1]; bucket >= 0; bucket = this._Next[bucket])
    {
      if (this._HashCodes[bucket] == num1 && this._Comparer.Equals(this._Keys[bucket], key))
      {
        if (add)
          throw new ArgumentException("Key already exists: " + (object) key);
        this._Values[bucket] = value;
        ++this._Version;
        return;
      }
      ++num2;
    }
    int index2;
    if (this._FreeCount > 0)
    {
      index2 = this._FreeList;
      this._FreeList = this._Next[index2];
      --this._FreeCount;
    }
    else
    {
      if (this._Count == this._Keys.Length)
      {
        this.Resize();
        index1 = num1 % this._Buckets.Length;
      }
      index2 = this._Count;
      ++this._Count;
    }
    this._HashCodes[index2] = num1;
    this._Next[index2] = this._Buckets[index1];
    this._Keys[index2] = key;
    this._Values[index2] = value;
    this._Buckets[index1] = index2;
    ++this._Version;
  }

  private void Initialize(int capacity)
  {
    int prime = SerializableDictionary<TKey, TValue>.PrimeHelper.GetPrime(capacity);
    this._Buckets = new int[prime];
    for (int index = 0; index < this._Buckets.Length; ++index)
      this._Buckets[index] = -1;
    this._Keys = new TKey[prime];
    this._Values = new TValue[prime];
    this._HashCodes = new int[prime];
    this._Next = new int[prime];
    this._FreeList = -1;
  }

  private int FindIndex(TKey key)
  {
    if ((object) key == null)
      throw new ArgumentNullException(nameof (key));
    if (this._Buckets != null)
    {
      int num = this._Comparer.GetHashCode(key) & int.MaxValue;
      for (int bucket = this._Buckets[num % this._Buckets.Length]; bucket >= 0; bucket = this._Next[bucket])
      {
        if (this._HashCodes[bucket] == num && this._Comparer.Equals(this._Keys[bucket], key))
          return bucket;
      }
    }
    return -1;
  }

  public bool TryGetValue(TKey key, out TValue value)
  {
    int index = this.FindIndex(key);
    if (index >= 0)
    {
      value = this._Values[index];
      return true;
    }
    value = default (TValue);
    return false;
  }

  public ICollection<TKey> Keys => (ICollection<TKey>) ((IEnumerable<TKey>) this._Keys).Take<TKey>(this.Count).ToArray<TKey>();

  public ICollection<TValue> Values => (ICollection<TValue>) ((IEnumerable<TValue>) this._Values).Take<TValue>(this.Count).ToArray<TValue>();

  public void Add(KeyValuePair<TKey, TValue> item) => this.Add(item.Key, item.Value);

  public bool Contains(KeyValuePair<TKey, TValue> item)
  {
    int index = this.FindIndex(item.Key);
    return index >= 0 && EqualityComparer<TValue>.Default.Equals(this._Values[index], item.Value);
  }

  public void CopyTo(KeyValuePair<TKey, TValue>[] array, int index)
  {
    if (array == null)
      throw new ArgumentNullException(nameof (array));
    if (index < 0 || index > array.Length)
      throw new ArgumentOutOfRangeException(string.Format("index = {0} array.Length = {1}", (object) index, (object) array.Length));
    if (array.Length - index < this.Count)
      throw new ArgumentException(string.Format("The number of elements in the dictionary ({0}) is greater than the available space from index to the end of the destination array {1}.", (object) this.Count, (object) array.Length));
    for (int index1 = 0; index1 < this._Count; ++index1)
    {
      if (this._HashCodes[index1] >= 0)
        array[index++] = new KeyValuePair<TKey, TValue>(this._Keys[index1], this._Values[index1]);
    }
  }

  public bool IsReadOnly => false;

  public bool Remove(KeyValuePair<TKey, TValue> item) => this.Remove(item.Key);

  public SerializableDictionary<TKey, TValue>.Enumerator GetEnumerator() => new SerializableDictionary<TKey, TValue>.Enumerator(this);

  IEnumerator IEnumerable.GetEnumerator() => (IEnumerator) this.GetEnumerator();

  IEnumerator<KeyValuePair<TKey, TValue>> IEnumerable<KeyValuePair<TKey, TValue>>.GetEnumerator() => (IEnumerator<KeyValuePair<TKey, TValue>>) this.GetEnumerator();

  private static class PrimeHelper
  {
    public static readonly int[] Primes = new int[72]
    {
      3,
      7,
      11,
      17,
      23,
      29,
      37,
      47,
      59,
      71,
      89,
      107,
      131,
      163,
      197,
      239,
      293,
      353,
      431,
      521,
      631,
      761,
      919,
      1103,
      1327,
      1597,
      1931,
      2333,
      2801,
      3371,
      4049,
      4861,
      5839,
      7013,
      8419,
      10103,
      12143,
      14591,
      17519,
      21023,
      25229,
      30293,
      36353,
      43627,
      52361,
      62851,
      75431,
      90523,
      108631,
      130363,
      156437,
      187751,
      225307,
      270371,
      324449,
      389357,
      467237,
      560689,
      672827,
      807403,
      968897,
      1162687,
      1395263,
      1674319,
      2009191,
      2411033,
      2893249,
      3471899,
      4166287,
      4999559,
      5999471,
      7199369
    };

    public static bool IsPrime(int candidate)
    {
      if ((candidate & 1) == 0)
        return candidate == 2;
      int num = (int) Math.Sqrt((double) candidate);
      for (int index = 3; index <= num; index += 2)
      {
        if (candidate % index == 0)
          return false;
      }
      return true;
    }

    public static int GetPrime(int min)
    {
      if (min < 0)
        throw new ArgumentException("min < 0");
      for (int index = 0; index < SerializableDictionary<TKey, TValue>.PrimeHelper.Primes.Length; ++index)
      {
        int prime = SerializableDictionary<TKey, TValue>.PrimeHelper.Primes[index];
        if (prime >= min)
          return prime;
      }
      for (int candidate = min | 1; candidate < int.MaxValue; candidate += 2)
      {
        if (SerializableDictionary<TKey, TValue>.PrimeHelper.IsPrime(candidate) && (candidate - 1) % 101 != 0)
          return candidate;
      }
      return min;
    }

    public static int ExpandPrime(int oldSize)
    {
      int min = 2 * oldSize;
      return min > 2146435069 && 2146435069 > oldSize ? 2146435069 : SerializableDictionary<TKey, TValue>.PrimeHelper.GetPrime(min);
    }
  }

  public struct Enumerator : IEnumerator<KeyValuePair<TKey, TValue>>, IEnumerator, IDisposable
  {
    private readonly SerializableDictionary<TKey, TValue> _Dictionary;
    private int _Version;
    private int _Index;
    private KeyValuePair<TKey, TValue> _Current;

    public KeyValuePair<TKey, TValue> Current => this._Current;

    internal Enumerator(SerializableDictionary<TKey, TValue> dictionary)
    {
      this._Dictionary = dictionary;
      this._Version = dictionary._Version;
      this._Current = new KeyValuePair<TKey, TValue>();
      this._Index = 0;
    }

    public bool MoveNext()
    {
      if (this._Version != this._Dictionary._Version)
        throw new InvalidOperationException(string.Format("Enumerator version {0} != Dictionary version {1}", (object) this._Version, (object) this._Dictionary._Version));
      for (; this._Index < this._Dictionary._Count; ++this._Index)
      {
        if (this._Dictionary._HashCodes[this._Index] >= 0)
        {
          this._Current = new KeyValuePair<TKey, TValue>(this._Dictionary._Keys[this._Index], this._Dictionary._Values[this._Index]);
          ++this._Index;
          return true;
        }
      }
      this._Index = this._Dictionary._Count + 1;
      this._Current = new KeyValuePair<TKey, TValue>();
      return false;
    }

    void IEnumerator.Reset()
    {
      if (this._Version != this._Dictionary._Version)
        throw new InvalidOperationException(string.Format("Enumerator version {0} != Dictionary version {1}", (object) this._Version, (object) this._Dictionary._Version));
      this._Index = 0;
      this._Current = new KeyValuePair<TKey, TValue>();
    }

    object IEnumerator.Current => (object) this.Current;

    public void Dispose()
    {
    }
  }
}
