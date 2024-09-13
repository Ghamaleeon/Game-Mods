using Terraria;
using Terraria.ID;
using Terraria.ModLoader;
using Terraria.GameContent.Creative;

namespace LimitlessStuff.Items
{
	public class FlaskBag : ModItem
	{
		public override void SetStaticDefaults()
		{
			DisplayName.SetDefault("Flask Bag (All)");
			Tooltip.SetDefault("Each frame, grants a random flask buff\nAlso works on inventory");
			CreativeItemSacrificesCatalog.Instance.SacrificeCountNeededByItemId[Type] = 1;
		}
		
		public override void SetDefaults()
		{
			Item.maxStack = 1;
			Item.rare = 1;
			Item.value = 0;
			Item.accessory = true;
		}
		
		public override void UpdateInventory(Player player)
		{
			int rng = Main.rand.Next(72, 79);
			switch (rng)
			{
				case 72:
					player.AddBuff(71, 2);
					break;
				default:
					player.AddBuff(rng, 2);
					break;
			}
		}
		
		public override void UpdateAccessory(Player player, bool hideVisual)
		{
			int rng = Main.rand.Next(72, 79);
			switch (rng)
			{
				case 72:
					player.AddBuff(71, 2);
					break;
				default:
					player.AddBuff(rng, 2);
					break;
			}
		}

		public override void AddRecipes()
		{
			Recipe recipe = CreateRecipe();
			recipe.AddIngredient(ItemID.FlaskofCursedFlames, 30);
			recipe.AddIngredient(ModContent.ItemType<FlaskBagCrimson>(), 1);
			recipe.Register();
			
			Recipe recipe2 = CreateRecipe();
			recipe2.AddIngredient(ItemID.FlaskofIchor, 30);
			recipe2.AddIngredient(ModContent.ItemType<FlaskBagCorruption>(), 1);
			recipe2.Register();
		}
	}
}
