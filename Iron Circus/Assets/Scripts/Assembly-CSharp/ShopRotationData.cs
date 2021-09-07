using System;

[Serializable]
public class ShopRotationData
{
	public ShopRotationData(ItemDefinition item, long countdownInMs)
	{
	}

	public ShopItem item;
	public long countdownInMs;
}
