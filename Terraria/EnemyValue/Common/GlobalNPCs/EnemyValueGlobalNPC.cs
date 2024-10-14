using EnemyValue.Common.Configs;
using Terraria;
using Terraria.ID;
using Terraria.ModLoader;

namespace EnemyValue.Common.GlobalNPCs {
	public class EnemyValueGlobalNPC : GlobalNPC {
		public override void OnKill(NPC npc) {
			npc.value = (int)(npc.value * ModContent.GetInstance<EnemyValueConfig>().ValueMultiplier);
		}
	}
}
