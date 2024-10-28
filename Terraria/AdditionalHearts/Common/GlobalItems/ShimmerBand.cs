using AdditionalHearts.Content.Items.Accessories;
using Terraria;
using Terraria.ID;
using Terraria.ModLoader;

namespace AdditionalHearts.Common.GlobalItems {
	public class ShimmerBand : GlobalItem {
		public override void SetDefaults(Item item) {
			if (item.type == ItemID.BandofRegeneration)
				ItemID.Sets.ShimmerTransformToItem[item.type] = ModContent.ItemType<BandofHealing>();
		}
	}
}