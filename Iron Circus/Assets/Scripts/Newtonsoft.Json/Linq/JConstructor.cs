// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Linq.JConstructor
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using Newtonsoft.Json.Utilities;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Runtime.CompilerServices;
using System.Threading;
using System.Threading.Tasks;

namespace Newtonsoft.Json.Linq
{
  public class JConstructor : JContainer
  {
    private string _name;
    private readonly List<JToken> _values = new List<JToken>();

    public override async Task WriteToAsync(
      JsonWriter writer,
      CancellationToken cancellationToken,
      params JsonConverter[] converters)
    {
      await writer.WriteStartConstructorAsync(this._name, cancellationToken).ConfigureAwait(false);
      for (int i = 0; i < this._values.Count; ++i)
        await this._values[i].WriteToAsync(writer, cancellationToken, converters).ConfigureAwait(false);
      await writer.WriteEndConstructorAsync(cancellationToken).ConfigureAwait(false);
    }

    public static Task<JConstructor> LoadAsync(
      JsonReader reader,
      CancellationToken cancellationToken = default (CancellationToken))
    {
      return JConstructor.LoadAsync(reader, (JsonLoadSettings) null, cancellationToken);
    }

    public static async Task<JConstructor> LoadAsync(
      JsonReader reader,
      JsonLoadSettings settings,
      CancellationToken cancellationToken = default (CancellationToken))
    {
      ConfiguredTaskAwaitable<bool> configuredTaskAwaitable;
      if (reader.TokenType == JsonToken.None)
      {
        configuredTaskAwaitable = reader.ReadAsync(cancellationToken).ConfigureAwait(false);
        if (!await configuredTaskAwaitable)
          throw JsonReaderException.Create(reader, "Error reading JConstructor from JsonReader.");
      }
      configuredTaskAwaitable = reader.MoveToContentAsync(cancellationToken).ConfigureAwait(false);
      int num = (int) await configuredTaskAwaitable;
      JConstructor c = reader.TokenType == JsonToken.StartConstructor ? new JConstructor((string) reader.Value) : throw JsonReaderException.Create(reader, "Error reading JConstructor from JsonReader. Current JsonReader item is not a constructor: {0}".FormatWith((IFormatProvider) CultureInfo.InvariantCulture, (object) reader.TokenType));
      c.SetLineInfo(reader as IJsonLineInfo, settings);
      await c.ReadTokenFromAsync(reader, settings, cancellationToken).ConfigureAwait(false);
      return c;
    }

    protected override IList<JToken> ChildrenTokens => (IList<JToken>) this._values;

    internal override int IndexOfItem(JToken item) => this._values.IndexOfReference<JToken>(item);

    internal override void MergeItem(object content, JsonMergeSettings settings)
    {
      if (!(content is JConstructor jconstructor))
        return;
      if (jconstructor.Name != null)
        this.Name = jconstructor.Name;
      JContainer.MergeEnumerableContent((JContainer) this, (IEnumerable) jconstructor, settings);
    }

    public string Name
    {
      get => this._name;
      set => this._name = value;
    }

    public override JTokenType Type => JTokenType.Constructor;

    public JConstructor()
    {
    }

    public JConstructor(JConstructor other)
      : base((JContainer) other)
    {
      this._name = other.Name;
    }

    public JConstructor(string name, params object[] content)
      : this(name, (object) content)
    {
    }

    public JConstructor(string name, object content)
      : this(name)
    {
      this.Add(content);
    }

    public JConstructor(string name)
    {
      switch (name)
      {
        case "":
          throw new ArgumentException("Constructor name cannot be empty.", nameof (name));
        case null:
          throw new ArgumentNullException(nameof (name));
        default:
          this._name = name;
          break;
      }
    }

    internal override bool DeepEquals(JToken node) => node is JConstructor jconstructor && this._name == jconstructor.Name && this.ContentsEqual((JContainer) jconstructor);

    internal override JToken CloneToken() => (JToken) new JConstructor(this);

    public override void WriteTo(JsonWriter writer, params JsonConverter[] converters)
    {
      writer.WriteStartConstructor(this._name);
      int count = this._values.Count;
      for (int index = 0; index < count; ++index)
        this._values[index].WriteTo(writer, converters);
      writer.WriteEndConstructor();
    }

    public override JToken this[object key]
    {
      get
      {
        ValidationUtils.ArgumentNotNull(key, nameof (key));
        return key is int index ? this.GetItem(index) : throw new ArgumentException("Accessed JConstructor values with invalid key value: {0}. Argument position index expected.".FormatWith((IFormatProvider) CultureInfo.InvariantCulture, (object) MiscellaneousUtils.ToString(key)));
      }
      set
      {
        ValidationUtils.ArgumentNotNull(key, nameof (key));
        if (!(key is int index))
          throw new ArgumentException("Set JConstructor values with invalid key value: {0}. Argument position index expected.".FormatWith((IFormatProvider) CultureInfo.InvariantCulture, (object) MiscellaneousUtils.ToString(key)));
        this.SetItem(index, value);
      }
    }

    internal override int GetDeepHashCode() => this._name.GetHashCode() ^ this.ContentsHashCode();

    public static JConstructor Load(JsonReader reader) => JConstructor.Load(reader, (JsonLoadSettings) null);

    public static JConstructor Load(JsonReader reader, JsonLoadSettings settings)
    {
      if (reader.TokenType == JsonToken.None && !reader.Read())
        throw JsonReaderException.Create(reader, "Error reading JConstructor from JsonReader.");
      reader.MoveToContent();
      JConstructor jconstructor = reader.TokenType == JsonToken.StartConstructor ? new JConstructor((string) reader.Value) : throw JsonReaderException.Create(reader, "Error reading JConstructor from JsonReader. Current JsonReader item is not a constructor: {0}".FormatWith((IFormatProvider) CultureInfo.InvariantCulture, (object) reader.TokenType));
      jconstructor.SetLineInfo(reader as IJsonLineInfo, settings);
      jconstructor.ReadTokenFrom(reader, settings);
      return jconstructor;
    }
  }
}
