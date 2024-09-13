using Terraria;
using Terraria.ID;
using Terraria.ModLoader;

namespace LimitlessStuff.Items
{
	public class ModGlobalItem : GlobalItem
	{
		public override void UpdateInventory(Item item, Player player)
		{
			if (item.stack >= item.maxStack && item.maxStack > 10)
			{
				if (item.buffType > 0)
				{
					player.AddBuff(item.buffType, 2);
				}
			}
			
			if (item.stack < item.maxStack && !item.consumable && item.maxStack > 10)
			{
				item.consumable = true;
			}
			else if (item.stack >= item.maxStack && item.consumable && item.maxStack > 10)
			{
				item.consumable = false;
			}
			
			if (item.stack >= 1)
			{
				switch (item.type)
				{
					case ItemID.SharpeningStation:
						player.AddBuff(159, 2);
						break;
					case ItemID.AmmoBox:
						player.AddBuff(93, 2);
						break;
					case ItemID.CrystalBall:
						player.AddBuff(29, 2);
						break;
					case ItemID.BewitchingTable:
						player.AddBuff(150, 2);
						break;
					case ItemID.PeaceCandle:
						player.AddBuff(157, 2);
						break;
					case ItemID.SliceOfCake:
						player.AddBuff(192, 2);
						break;
					case ItemID.Sunflower:
						player.AddBuff(146, 2);
						break;
					case ItemID.StarinaBottle:
						player.AddBuff(158, 2);
						break;
					case ItemID.Campfire:
						player.AddBuff(87, 2);
						break;
					case ItemID.CatBast:
						player.AddBuff(215, 2);
						break;
					case ItemID.HoneyBucket:
						player.AddBuff(48, 2);
						break;
					case ItemID.HeartLantern:
						player.AddBuff(89, 2);
						break;
					case ItemID.WaterCandle:
						player.AddBuff(86, 2);
						break;
				}
			}
		}
		
		public override bool ConsumeItem(Item item, Player player)
		{
			if (item.stack >= item.maxStack && item.maxStack > 1 && !(item.type == ItemID.CopperCoin || item.type == ItemID.SilverCoin || item.type == ItemID.GoldCoin))
			{
				return false;
			}
			else
			{
				return true;
			}
		}
	}
}