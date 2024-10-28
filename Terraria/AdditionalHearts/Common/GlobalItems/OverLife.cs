using Terraria;
using Terraria.ID;
using Terraria.ModLoader;

namespace AdditionalHearts.Common.GlobalItems{
	public class OverLife : GlobalItem {
		
		public override bool? UseItem(Item item, Player player) {
			
			if (item.type == ItemID.LifeCrystal) {
				player.Heal(20);
				player.statLifeMax2 = player.statLifeMax2 + 20;
				return true;
			}
			
			return null;
		}
	}
}