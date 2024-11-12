using System.ComponentModel;
using Terraria;
using Terraria.DataStructures;
using Terraria.GameContent.Bestiary;
using Terraria.ModLoader;
using Terraria.ModLoader.Config;

namespace BossScaling {
	public class BossScaling : Mod {
		
		public class ScalingConfig : ModConfig {
			public override ConfigScope Mode => ConfigScope.ServerSide;
			
			[Header("ToBosses")]
			[DefaultValue(20)]
			public int BossHealthScaling;
			[DefaultValue(10)]
			public int BossDamageScaling;
			[DefaultValue(20)]
			public int BossValueScaling;
			
			[Header("ToEnemies")]
			[DefaultValue(20)]
			public int EnemyHealthScaling;
			[DefaultValue(10)]
			public int EnemyDamageScaling;
			[DefaultValue(20)]
			public int EnemyValueScaling;
		}
		
		public class NPCScaling : GlobalNPC {
			public override void OnSpawn(NPC npc, IEntitySource source) {
				float killCount = Main.BestiaryTracker.Kills.GetKillCount(npc);
				
				if (npc.boss) {
					npc.lifeMax = (int)(npc.lifeMax * (1 + killCount * ((float)(ModContent.GetInstance<ScalingConfig>().BossHealthScaling) / 100)));
					
					npc.damage = (int)(npc.damage * (1 + killCount * ((float)(ModContent.GetInstance<ScalingConfig>().BossDamageScaling) / 100)));
					
					npc.value = (int)(npc.value * (1 + killCount * ((float)(ModContent.GetInstance<ScalingConfig>().BossValueScaling) / 100)));
				} else {
					npc.lifeMax = (int)(npc.lifeMax * (1 + killCount * ((float)(ModContent.GetInstance<ScalingConfig>().EnemyHealthScaling) / 1000)));
					
					npc.damage = (int)(npc.damage * (1 + killCount * ((float)(ModContent.GetInstance<ScalingConfig>().EnemyDamageScaling) / 1000)));
					
					npc.value = (int)(npc.value * (1 + killCount * ((float)(ModContent.GetInstance<ScalingConfig>().EnemyValueScaling) / 1000)));
				}
				
				npc.life = npc.lifeMax;
				npc.defDamage = npc.damage;
			}
		}
		
		public class ProjectileScaling : GlobalProjectile {
			public override void OnSpawn(Projectile projectile, IEntitySource source) {
				if (source is EntitySource_Parent parent && parent.Entity is NPC npc) {
					float killCount = Main.BestiaryTracker.Kills.GetKillCount(npc);
					
					if (npc.boss) {
						projectile.damage = (int)(projectile.damage * (1 + killCount * ((float)(ModContent.GetInstance<ScalingConfig>().BossDamageScaling) / 100)));
					} else {
						projectile.damage = (int)(projectile.damage * (1 + killCount * ((float)(ModContent.GetInstance<ScalingConfig>().EnemyDamageScaling) / 1000)));
					}
				}
			}
		}
	}
}