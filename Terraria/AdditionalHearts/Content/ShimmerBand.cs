using AdditionalHearts.Content.Items.Accessories;
using Terraria.ID;
using Terraria.ModLoader;

namespace AdditionalHearts.Content{
	public class ShimmerBand : ModSystem {
		public override void AddRecipes() {
			ItemID.Sets.ShimmerTransformToItem[ItemID.BandofRegeneration] = ModContent.ItemType<BandofHealing>();
		}
	}
}