using Terraria;
using Terraria.ID;
using Terraria.ModLoader;
using Terraria.GameContent.Creative;

namespace LimitlessStuff.Items
{
	public class FlaskBagCrimson : ModItem
	{
		public override void SetStaticDefaults()
		{
			DisplayName.SetDefault("Flask Bag (No Cursed Flames)");
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
			switch (Main.rand.Next(0, 6))
			{
				case 0:
					player.AddBuff(71, 2);
					break;
				case 1:
					player.AddBuff(74, 2);
					break;
				case 2:
					player.AddBuff(75, 2);
					break;
				case 3:
					player.AddBuff(76, 2);
					break;
				case 4:
					player.AddBuff(77, 2);
					break;
				case 5:
					player.AddBuff(78, 2);
					break;
				case 6:
					player.AddBuff(79, 2);
					break;
			}
		}
		
		public override void UpdateAccessory(Player player, bool hideVisual)
		{
			switch (Main.rand.Next(0, 6))
			{
				case 0:
					player.AddBuff(71, 2);
					break;
				case 1:
					player.AddBuff(74, 2);
					break;
				case 2:
					player.AddBuff(75, 2);
					break;
				case 3:
					player.AddBuff(76, 2);
					break;
				case 4:
					player.AddBuff(77, 2);
					break;
				case 5:
					player.AddBuff(78, 2);
					break;
				case 6:
					player.AddBuff(79, 2);
					break;
			}
		}

		public override void AddRecipes()
		{
			Recipe recipe = CreateRecipe();
			recipe.AddIngredient(ItemID.FlaskofFire, 30);
			recipe.AddIngredient(ItemID.FlaskofGold, 30);
			recipe.AddIngredient(ItemID.FlaskofIchor, 30);
			recipe.AddIngredient(ItemID.FlaskofNanites, 30);
			recipe.AddIngredient(ItemID.FlaskofParty, 30);
			recipe.AddIngredient(ItemID.FlaskofPoison, 30);
			recipe.AddIngredient(ItemID.FlaskofVenom, 30);
			recipe.AddIngredient(ModContent.ItemType<EmptyBag>(), 1);
			recipe.Register();
		}
	}
}
