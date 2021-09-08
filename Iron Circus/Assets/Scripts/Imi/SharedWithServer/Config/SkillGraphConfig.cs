// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Config.SkillGraphConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.ScEntitas;
using Imi.Utils.Common;
using Jitter.LinearMath;
using Newtonsoft.Json;
using SharedWithServer.ScEvents;
using SteelCircus.GameElements;
using System;
using System.Collections.Generic;
using System.Reflection;

namespace Imi.SharedWithServer.Config
{
  public abstract class SkillGraphConfig : GameConfigEntry
  {
    [Readonly]
    [JsonIgnore]
    public SerializedSkillGraphInfo serializationInfo;

    public SkillGraph CreateStateMachine(
      ulong ownerId,
      int instanceIdx,
      GameContext gameContext,
      GameEntityFactory entityFactory,
      Events events,
      bool isClient)
    {
      using (new ConfigValueChangeAllowed())
      {
        SkillGraph skillGraph = new SkillGraph(ownerId, instanceIdx, gameContext, entityFactory, events, isClient, this);
        this.SetupSkillGraph(skillGraph);
        this.serializationInfo = skillGraph.Parse();
        this.serializationInfo.name = this.name;
        return skillGraph;
      }
    }

    public byte[] ToByteArray()
    {
      Type type = this.GetType();
      List<byte> byteList = new List<byte>();
      foreach (FieldInfo field in type.GetFields(BindingFlags.Instance | BindingFlags.Public))
      {
        object obj = field.GetValue((object) this);
        byte[] numArray = new byte[0];
        if (field.FieldType.IsPrimitive)
        {
          switch (obj)
          {
            case float num7:
              numArray = BitConverter.GetBytes(num7);
              break;
            case int num8:
              numArray = BitConverter.GetBytes(num8);
              break;
            case bool flag3:
              numArray = BitConverter.GetBytes(flag3);
              break;
          }
        }
        else
        {
          switch (obj)
          {
            case Imi.SharedWithServer.ScEntitas.Components.ButtonType _:
              numArray = BitConverter.GetBytes((int) obj);
              break;
            case JVector jvector3:
              numArray = new byte[12];
              BitConverter.GetBytes(jvector3.X).CopyTo((Array) numArray, 0);
              BitConverter.GetBytes(jvector3.Y).CopyTo((Array) numArray, 4);
              BitConverter.GetBytes(jvector3.Z).CopyTo((Array) numArray, 8);
              break;
            case AreaOfEffect areaOfEffect3:
              numArray = areaOfEffect3.ToBytes();
              break;
            case Curve _:
              numArray = ((Curve) obj).ToBytes();
              break;
          }
        }
        byteList.AddRange((IEnumerable<byte>) numArray);
      }
      return byteList.ToArray();
    }

    public void FromByteArray(byte[] values)
    {
      FieldInfo[] fields = this.GetType().GetFields(BindingFlags.Instance | BindingFlags.Public);
      int num = 0;
      foreach (FieldInfo fieldInfo in fields)
      {
        object obj = fieldInfo.GetValue((object) this);
        if (fieldInfo.FieldType.IsPrimitive)
        {
          switch (obj)
          {
            case float _:
              fieldInfo.SetValue((object) this, (object) BitConverter.ToSingle(values, num));
              num += 4;
              continue;
            case int _:
              fieldInfo.SetValue((object) this, (object) BitConverter.ToInt32(values, num));
              num += 4;
              continue;
            case bool _:
              fieldInfo.SetValue((object) this, (object) BitConverter.ToBoolean(values, num));
              ++num;
              continue;
            default:
              continue;
          }
        }
        else
        {
          switch (obj)
          {
            case Imi.SharedWithServer.ScEntitas.Components.ButtonType _:
              fieldInfo.SetValue((object) this, (object) BitConverter.ToInt32(values, num));
              num += 4;
              continue;
            case JVector _:
              JVector zero = JVector.Zero;
              zero.X = BitConverter.ToSingle(values, num);
              int startIndex1 = num + 4;
              zero.Y = BitConverter.ToSingle(values, startIndex1);
              int startIndex2 = startIndex1 + 4;
              zero.Z = BitConverter.ToSingle(values, startIndex2);
              num = startIndex2 + 4;
              fieldInfo.SetValue((object) this, (object) zero);
              continue;
            case AreaOfEffect areaOfEffect3:
              num = areaOfEffect3.FromBytes(values, num);
              fieldInfo.SetValue((object) this, obj);
              continue;
            case Curve _:
              num = ((Curve) obj).FromBytes(values, num);
              fieldInfo.SetValue((object) this, obj);
              continue;
            default:
              continue;
          }
        }
      }
    }

    public void UpdateData(SkillGraphConfig config)
    {
      foreach (FieldInfo field in this.GetType().GetFields(BindingFlags.Instance | BindingFlags.Public))
        field.SetValue((object) this, field.GetValue((object) config));
    }

    protected abstract void SetupSkillGraph(SkillGraph skillGraph);
  }
}
