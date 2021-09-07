using System.Collections.Generic;

public class LocalizationConfig : SingletonScriptableObject<LocalizationConfig>
{
	public string exportFilename;
	public List<string> fixedKeys;
	public List<ItemLocaData> itemKeys;
	public List<string> keys;
	public List<string> unusedEntries;
	public ScLanguage[] languages;
}
