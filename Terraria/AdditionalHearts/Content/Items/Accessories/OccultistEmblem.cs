using System.Collections.Generic;
using Terraria;
using Terraria.DataStructures;
using Terraria.ID;
using Terraria.ModLoader;

namespace AdditionalHearts.Content.Items.Accessories {
	public class OccultistEmblem : ModItem {
		
		public override void SetDefaults() {
			Item.CloneDefaults(ItemID.SorcererEmblem);
		}
		
		public override void UpdateAccessory(Player player, bool hideVisual) {
			player.GetDamage(DamageClass.Magic) += 2f;
			player.statLifeMax2 += player.statManaMax2;
			player.statManaMax2 = 0;
			
			// var modplayer = player.GetModPlayer<OccultistEmblemEquipped>()
			// modplayer.Equipped = true
		}
		
		public override void AddRecipes() {
			CreateRecipe()
				.AddTile(TileID.TinkerersWorkbench)
				.Register();
		}
	}
	
	public class OccultistEmblemCheck : GlobalItem {
		public override void OnMissingMana(Item item, Player player, int neededMana) {
			if (player.statLife > neededMana) {
				player.statLife -= neededMana;
				player.statMana += neededMana;
			}
		}
	}
}
