using Microsoft.Xna.Framework;
using ChaosPickup.Common.Configs;
using Terraria;
using Terraria.Audio;
using Terraria.ID;
using Terraria.Localization;
using Terraria.ModLoader;

namespace ChaosPickup.Content.Items {
	public class ChaosPickupItem : ModItem {

		public override LocalizedText Tooltip => LocalizedText.Empty;

		public override void SetStaticDefaults() {
			ItemID.Sets.ItemsThatShouldNotBeInInventory[Type] = true;
			ItemID.Sets.IgnoresEncumberingStone[Type] = true;
			ItemID.Sets.IsAPickup[Type] = true;
			ItemID.Sets.ItemSpawnDecaySpeed[Type] = 4;
			ItemID.Sets.ItemNoGravity[Item.type] = true;
		}

		public override void SetDefaults() {
			Item.height = 12;
			Item.width = 12;
		}

		public override void PostUpdate() {
			Lighting.AddLight(Item.Center, Color.WhiteSmoke.ToVector3() * 0.55f * Main.essScale);
		}

		public override bool OnPickup(Player player) {
			int buff = Main.rand.Next(0, ModContent.GetInstance<ChaosPickupConfig>().PossibleBuffs.Count);
			player.AddBuff(ModContent.GetInstance<ChaosPickupConfig>().PossibleBuffs[buff].Type, 10 * 60);

			SoundEngine.PlaySound(SoundID.Grab, player.Center);

			return false;
		}
	}
}
