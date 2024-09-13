using Terraria;
using Terraria.ID;
using Terraria.ModLoader;
using Terraria.GameContent.Creative;

namespace LimitlessStuff.Items
{
	public class SimpleCombatBag : ModItem
	{
		public override void SetStaticDefaults()
		{
			DisplayName.SetDefault("Combat Bag (Simple)");
			Tooltip.SetDefault("Grants combat buffs\nAlso works on inventory");
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
			player.AddBuff(2, 2);
			player.AddBuff(3, 2);
			player.AddBuff(5, 2);
			player.AddBuff(26, 2);
		}

		public override void AddRecipes()
		{
			Recipe recipe = CreateRecipe();
			recipe.AddIngredient(ItemID.RegenerationPotion, 30);
			recipe.AddIngredient(ItemID.SwiftnessPotion, 30);
			recipe.AddIngredient(ItemID.IronskinPotion, 30);
			recipe.AddRecipeGroup("WellFed", 30);
			recipe.AddIngredient(ModContent.ItemType<EmptyBag>(), 1);
			recipe.Register();
		}
	}
}
