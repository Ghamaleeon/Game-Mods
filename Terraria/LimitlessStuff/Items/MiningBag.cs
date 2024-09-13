using Terraria;
using Terraria.ID;
using Terraria.ModLoader;
using Terraria.GameContent.Creative;

namespace LimitlessStuff.Items
{
	public class MiningBag : ModItem
	{
		public override void SetStaticDefaults()
		{
			DisplayName.SetDefault("Mining Bag");
			Tooltip.SetDefault("Grants mining buffs\nAlso works on inventory");
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
			player.AddBuff(104, 2);
			player.AddBuff(9, 2);
			player.AddBuff(11, 2);
			player.AddBuff(111, 2);
			player.AddBuff(192, 2);
		}

		public override void AddRecipes()
		{
			Recipe recipe = CreateRecipe();
			recipe.AddIngredient(ItemID.MiningPotion, 30);
			recipe.AddIngredient(ItemID.SpelunkerPotion, 30);
			recipe.AddIngredient(ItemID.ShinePotion, 30);
			recipe.AddIngredient(ItemID.TrapsightPotion, 30);
			recipe.AddIngredient(ItemID.SliceOfCake, 1);
			recipe.AddIngredient(ModContent.ItemType<EmptyBag>(), 1);
			recipe.Register();
		}
	}
}
