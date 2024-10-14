using ChaosPickup.Content.Items;
using ChaosPickup.Common.Configs;
using Terraria;
using Terraria.ID;
using Terraria.ModLoader;

namespace ChaosPickup.Common.GlobalNPCs {
	public class ChaosPickupGlobalNPC : GlobalNPC {
		public override void OnKill(NPC npc) {

			if (!NPCID.Sets.NeverDropsResourcePickups[npc.type] && npc.lifeMax > 1 && npc.damage > 0 && Main.rand.NextBool(ModContent.GetInstance<ChaosPickupConfig>().DropChance)) {
				Item.NewItem(npc.GetSource_Loot(), npc.getRect(), ModContent.ItemType<ChaosPickupItem>());
			}
		}
	}
}
