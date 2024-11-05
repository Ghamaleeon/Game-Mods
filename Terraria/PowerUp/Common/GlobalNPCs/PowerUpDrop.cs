using PowerUp.Content.Items;
using PowerUp.Common.Configs;
using Terraria;
using Terraria.ID;
using Terraria.ModLoader;

namespace PowerUp.Common.GlobalNPCs {
	public class PowerUpDrop : GlobalNPC {
		public override void OnKill(NPC npc) {

			if (!NPCID.Sets.NeverDropsResourcePickups[npc.type]
			&& npc.lifeMax > 1 && npc.damage > 0
			&& Main.rand.NextBool(ModContent.GetInstance<PowerUpConfig>().DropChance)) {
				Item.NewItem(npc.GetSource_Loot(), npc.getRect(), ModContent.ItemType<PowerUpItem>());
			}
		}
	}
}
