using System;

[Serializable]
public class ShopItem
{
	public ShopItem(ItemDefinition baseDefinition)
	{
	}

	public bool ownedByPlayer;
	public bool buyable;
	public ItemDefinition itemDefinition;
}
