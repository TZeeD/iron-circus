// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.ArenaReader
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.Diagnostics;
using Imi.SharedWithServer.ScEntitas.Components;
using Jitter;
using Jitter.Dynamics;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using System.Collections.Generic;
using System.IO;

namespace Imi.SharedWithServer.Game
{
  public class ArenaReader
  {
    public List<List<IComponent>> entityComponents = new List<List<IComponent>>();

    public List<JRigidbody> JitterColliders { get; } = new List<JRigidbody>();

    public void ReadArena(string path)
    {
      Log.Debug("Reading arena. Path: " + path);
      using (StreamReader streamReader = new StreamReader(path))
      {
        string end = streamReader.ReadToEnd();
        TypeNameSerializationBinder serializationBinder = new TypeNameSerializationBinder();
        JsonSerializerSettings settings = new JsonSerializerSettings()
        {
          TypeNameHandling = TypeNameHandling.Auto,
          Formatting = Formatting.Indented,
          SerializationBinder = (ISerializationBinder) serializationBinder
        };
        this.entityComponents = JsonConvert.DeserializeObject<List<List<IComponent>>>(end, settings);
        foreach (List<IComponent> entityComponent in this.entityComponents)
        {
          foreach (IComponent component in entityComponent)
          {
            if (component is RigidbodyComponent)
              this.JitterColliders.Add(((RigidbodyComponent) component).value);
          }
        }
      }
    }

    public void CreateWorldColliders(World world)
    {
      Log.Debug("Creating world colliders.");
      foreach (JRigidbody jitterCollider in this.JitterColliders)
        world.AddBody(jitterCollider);
    }
  }
}
