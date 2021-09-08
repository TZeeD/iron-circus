// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Systems.Physics.LoadArenaSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.Diagnostics;
using Imi.SharedWithServer.Game;
using System;
using System.Collections.Generic;
using System.IO;

namespace Imi.SharedWithServer.ScEntitas.Systems.Physics
{
  public class LoadArenaSystem
  {
    public static void LoadArena(GameContext gameContext, string arenaPath, string arenaName)
    {
      ArenaReader reader = new ArenaReader();
      reader.ReadArena(Path.Combine(arenaPath, arenaName + ".json"));
      Log.Debug(string.Format("Arena loaded. Highest uniqueId: {0}", (object) LoadArenaSystem.CreateEntities(reader, gameContext)));
      reader.CreateWorldColliders(gameContext.gamePhysics.world);
    }

    private static int CreateEntities(ArenaReader reader, GameContext gameContext)
    {
      int num1 = -1;
      List<List<IComponent>> entityComponents = reader.entityComponents;
      int num2 = 0;
      foreach (List<IComponent> components in entityComponents)
      {
        GameEntity entity = gameContext.CreateEntity();
        LoadArenaSystem.AddComponents(entity, components);
        if (entity.hasRigidbody)
        {
          if (!entity.rigidbody.value.IsStatic && !entity.rigidbody.value.IsTrigger)
          {
            Log.Warning("Non-Static Non-Trigger Rigidbody '" + entity.rigidbody.value.name + "' found in Arena file! Turning it static");
            entity.rigidbody.value.IsStatic = true;
          }
          if (entity.rigidbody.value.name.StartsWith("FieldCollider"))
            entity.rigidbody.value.name = entity.rigidbody.value.name.Replace("(Auto-generated)", num2++.ToString());
        }
        if (entity.hasUniqueId && num1 < (int) entity.uniqueId.id.Value())
          num1 = (int) entity.uniqueId.id.Value();
      }
      return num1;
    }

    private static void AddComponents(GameEntity entity, List<IComponent> components)
    {
      for (int index1 = 0; index1 < components.Count; ++index1)
      {
        Type type = components[index1].GetType();
        int index2 = Array.IndexOf<Type>(GameComponentsLookup.componentTypes, type);
        entity.AddComponent(index2, components[index1]);
      }
    }
  }
}
