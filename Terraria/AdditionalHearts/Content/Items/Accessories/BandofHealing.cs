using System.Collections.Generic;
using Terraria;
using Terraria.DataStructures;
using Terraria.ID;
using Terraria.ModLoader;

namespace AdditionalHearts.Content.Items.Accessories {
	public class BandofHealing : ModItem {
		
		public const int HealCooldown = 36;
		public int HealDelay = 0;
		
		public override void SetDefaults() {
			Item.CloneDefaults(ItemID.BandofRegeneration);
			Item.lifeRegen = 0;
		}
		
		public override void UpdateAccessory(Player player, bool hideVisual) {
			player.AddBuff(BuffID.PotionSickness, 3600);
			
			if (HealDelay == 0 && player.statLife < player.statLifeMax2) {
				player.statLife++;
				HealDelay = HealCooldown;
			}
			
			if (HealDelay > 0) HealDelay--;
		}
	}
}
