using Microsoft.Xna.Framework;
using PowerUp.Common.Configs;
using Terraria;
using Terraria.Audio;
using Terraria.ID;
using Terraria.Localization;
using Terraria.ModLoader;

namespace PowerUp.Content.Items {
	public class PowerUpItem : ModItem {

		public override LocalizedText Tooltip => LocalizedText.Empty;

		public override void SetStaticDefaults() {
			ItemID.Sets.ItemsThatShouldNotBeInInventory[Type] = true;
			ItemID.Sets.IgnoresEncumberingStone[Type] = true;
			ItemID.Sets.IsAPickup[Type] = true;
			ItemID.Sets.ItemSpawnDecaySpeed[Type] = 4;
			ItemID.Sets.ItemNoGravity[Item.type] = true;
		}

		public override void SetDefaults() {
			Item.width = 4;
			Item.height = 8;
		}

		public override void PostUpdate() {
			Lighting.AddLight(Item.Center, Color.DarkOrchid.ToVector3() * 0.55f * Main.essScale);
		}

		public override bool OnPickup(Player player) {
			int buff = Main.rand.Next(0, ModContent.GetInstance<PowerUpConfig>().PossiblePowers.Count);
			player.AddBuff(ModContent.GetInstance<PowerUpConfig>().PossiblePowers[buff].Type, ModContent.GetInstance<PowerUpConfig>().PowerDuration * 60);

			SoundEngine.PlaySound(SoundID.Item4, player.Center);

			return false;
		}
	}
}
