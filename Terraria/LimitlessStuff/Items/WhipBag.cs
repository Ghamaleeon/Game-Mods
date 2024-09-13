using Terraria;
using Terraria.ID;
using Terraria.ModLoader;
using Terraria.GameContent.Creative;

namespace LimitlessStuff.Items
{
	public class WhipBag : ModItem
	{
		public override void SetStaticDefaults()
		{
			DisplayName.SetDefault("Whip Bag");
			Tooltip.SetDefault("Each frame, grants a random melee speed buff while in inventory");
			CreativeItemSacrificesCatalog.Instance.SacrificeCountNeededByItemId[Type] = 1;
		}
		
		public override void SetDefaults()
		{
			Item.maxStack = 1;
			Item.rare = 1;
			Item.value = 0;
		}
		
		public override void UpdateInventory(Player player)
		{
			switch (Main.rand.Next(0, 3))
			{
				case 0:
					player.AddBuff(314, 1);
					break;
				case 1:
					player.AddBuff(308, 1);
					break;
				case 2:
					player.AddBuff(311, 1);
					break;
			}
		}

		public override void AddRecipes()
		{
			Recipe recipe = CreateRecipe();
			recipe.AddIngredient(4913, 30);
			recipe.AddIngredient(4678, 30);
			recipe.AddIngredient(4680, 30);
			recipe.AddIngredient(ModContent.ItemType<EmptyBag>(), 1);
			recipe.Register();
		}
	}
}
