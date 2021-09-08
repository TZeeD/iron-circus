// Decompiled with JetBrains decompiler
// Type: Jitter.Dynamics.Arbiter
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.LinearMath;

namespace Jitter.Dynamics
{
  public class Arbiter
  {
    public static ResourcePool<Arbiter> Pool = new ResourcePool<Arbiter>();
    internal JRigidbody body1;
    internal JRigidbody body2;
    internal ContactList contactList;

    public JRigidbody Body1 => this.body1;

    public JRigidbody Body2 => this.body2;

    public ContactList ContactList => this.contactList;

    public Arbiter(JRigidbody body1, JRigidbody body2)
    {
      this.contactList = new ContactList();
      this.body1 = body1;
      this.body2 = body2;
    }

    public Arbiter() => this.contactList = new ContactList();

    public void Invalidate() => this.contactList.Clear();

    public Contact AddContact(
      JVector point1,
      JVector point2,
      JVector normal,
      float penetration,
      ContactSettings contactSettings)
    {
      JVector result;
      JVector.Subtract(ref point1, ref this.body1.position, out result);
      lock (this.contactList)
      {
        if (this.contactList.Count == 4)
        {
          int index = this.SortCachedPoints(ref result, penetration);
          this.ReplaceContact(ref point1, ref point2, ref normal, penetration, index, contactSettings);
          return (Contact) null;
        }
        int cacheEntry = this.GetCacheEntry(ref result, contactSettings.breakThreshold);
        if (cacheEntry >= 0)
        {
          this.ReplaceContact(ref point1, ref point2, ref normal, penetration, cacheEntry, contactSettings);
          return (Contact) null;
        }
        Contact contact = Contact.Pool.GetNew();
        contact.Initialize(this.body1, this.body2, ref point1, ref point2, ref normal, penetration, true, contactSettings);
        this.contactList.Add(contact);
        return contact;
      }
    }

    private void ReplaceContact(
      ref JVector point1,
      ref JVector point2,
      ref JVector n,
      float p,
      int index,
      ContactSettings contactSettings)
    {
      this.contactList[index].Initialize(this.body1, this.body2, ref point1, ref point2, ref n, p, false, contactSettings);
    }

    private int GetCacheEntry(ref JVector realRelPos1, float contactBreakThreshold)
    {
      float num1 = contactBreakThreshold * contactBreakThreshold;
      int count = this.contactList.Count;
      int num2 = -1;
      for (int index = 0; index < count; ++index)
      {
        JVector result;
        JVector.Subtract(ref this.contactList[index].relativePos1, ref realRelPos1, out result);
        float num3 = result.LengthSquared();
        if ((double) num3 < (double) num1)
        {
          num1 = num3;
          num2 = index;
        }
      }
      return num2;
    }

    private int SortCachedPoints(ref JVector realRelPos1, float pen)
    {
      int num1 = -1;
      float num2 = pen;
      for (int index = 0; index < 4; ++index)
      {
        if ((double) this.contactList[index].penetration > (double) num2)
        {
          num1 = index;
          num2 = this.contactList[index].penetration;
        }
      }
      float x = 0.0f;
      float y = 0.0f;
      float z = 0.0f;
      float w = 0.0f;
      if (num1 != 0)
      {
        JVector result1;
        JVector.Subtract(ref realRelPos1, ref this.contactList[1].relativePos1, out result1);
        JVector result2;
        JVector.Subtract(ref this.contactList[3].relativePos1, ref this.contactList[2].relativePos1, out result2);
        JVector result3;
        JVector.Cross(ref result1, ref result2, out result3);
        x = result3.LengthSquared();
      }
      if (num1 != 1)
      {
        JVector result4;
        JVector.Subtract(ref realRelPos1, ref this.contactList[0].relativePos1, out result4);
        JVector result5;
        JVector.Subtract(ref this.contactList[3].relativePos1, ref this.contactList[2].relativePos1, out result5);
        JVector result6;
        JVector.Cross(ref result4, ref result5, out result6);
        y = result6.LengthSquared();
      }
      if (num1 != 2)
      {
        JVector result7;
        JVector.Subtract(ref realRelPos1, ref this.contactList[0].relativePos1, out result7);
        JVector result8;
        JVector.Subtract(ref this.contactList[3].relativePos1, ref this.contactList[1].relativePos1, out result8);
        JVector result9;
        JVector.Cross(ref result7, ref result8, out result9);
        z = result9.LengthSquared();
      }
      if (num1 != 3)
      {
        JVector result10;
        JVector.Subtract(ref realRelPos1, ref this.contactList[0].relativePos1, out result10);
        JVector result11;
        JVector.Subtract(ref this.contactList[2].relativePos1, ref this.contactList[1].relativePos1, out result11);
        JVector result12;
        JVector.Cross(ref result10, ref result11, out result12);
        w = result12.LengthSquared();
      }
      return Arbiter.MaxAxis(x, y, z, w);
    }

    internal static int MaxAxis(float x, float y, float z, float w)
    {
      int num1 = -1;
      float num2 = float.MinValue;
      if ((double) x > (double) num2)
      {
        num1 = 0;
        num2 = x;
      }
      if ((double) y > (double) num2)
      {
        num1 = 1;
        num2 = y;
      }
      if ((double) z > (double) num2)
      {
        num1 = 2;
        num2 = z;
      }
      if ((double) w > (double) num2)
        num1 = 3;
      return num1;
    }
  }
}
