using UnityEngine;

namespace SteelCircus.UI
{
	public class ChampionPageButton : MonoBehaviour
	{
		public enum itemButtonAction
		{
			None = 0,
			Equip = 1,
			OpenSlotEquip = 2,
			UpdateActiveItem = 3,
			ResetAnimation = 4,
			ShowDebugAnim = 5,
			UpdateAvatarIcon = 6,
		}

		public ShopItem item;
		public ChampionPageButtonGenerator buttonGenerator;
		public int id;
		public itemButtonAction onPointerEnterAction;
		public itemButtonAction onPointerExitAction;
		public itemButtonAction onClickAction;
		public itemButtonAction onSelectAction;
		public itemButtonAction onSubmitAction;
	}
}
