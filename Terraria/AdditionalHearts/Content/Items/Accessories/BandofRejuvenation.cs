using System.Collections.Generic;
using Terraria;
using Terraria.DataStructures;
using Terraria.ID;
using Terraria.ModLoader;

namespace AdditionalHearts.Content.Items.Accessories {
	public class BandofRejuvenation : ModItem {
		
		public const int HealCooldown = 18;
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
		
		public override void AddRecipes() {
			CreateRecipe()
				.AddIngredient<BandofHealing>()
				.AddIngredient(ItemID.PhilosophersStone)
				.AddIngredient(ItemID.SoulofLight, 10)
				.AddIngredient(ItemID.SoulofMight, 5)
				.AddTile(TileID.TinkerersWorkbench)
				.Register();
		}
	}
}
