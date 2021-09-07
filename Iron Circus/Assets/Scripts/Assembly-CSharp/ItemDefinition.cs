using System;
using Imi.SharedWithServer.Config;
using UnityEngine;

[Serializable]
public class ItemDefinition
{
	public ItemDefinition(int definitionId)
	{
	}

	public string name;
	public ShopManager.ShopItemType type;
	public string fileName;
	public ShopManager.ItemTier tier;
	public int priceCreds;
	public int priceSteel;
	public ChampionConfig champion;
	public int definitionId;
	public bool unlockedByDefault;
	public Sprite icon;
	public Object prefab;
}
