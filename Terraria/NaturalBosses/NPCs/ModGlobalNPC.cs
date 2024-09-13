using Microsoft.Xna.Framework;
using System;
using System.Collections.Generic;
using Terraria;
using Terraria.GameContent.Events;
using Terraria.ID;
using Terraria.ModLoader;

namespace NaturalBosses.NPCs
{
	public class ModGlobalNPC : GlobalNPC
	{
		public override void EditSpawnPool(IDictionary<int, float> pool, NPCSpawnInfo spawnInfo)
		{
			//layers
            int y = spawnInfo.SpawnTileY;
            bool cavern = y >= Main.maxTilesY * 0.4f && y <= Main.maxTilesY * 0.8f;
            bool underground = y > Main.worldSurface && y <= Main.maxTilesY * 0.4f;
            bool surface = y < Main.worldSurface && !spawnInfo.Sky;
            bool wideUnderground = cavern || underground;
            bool underworld = spawnInfo.Player.ZoneUnderworldHeight;
            bool sky = spawnInfo.Sky;

            //times
            bool night = !Main.dayTime;
            bool day = Main.dayTime;

            //biomes
            bool ocean = spawnInfo.Player.ZoneBeach;
            bool dungeon = spawnInfo.Player.ZoneDungeon;
            bool meteor = spawnInfo.Player.ZoneMeteor;
            bool spiderCave = spawnInfo.SpiderCave;
            bool mushroom = spawnInfo.Player.ZoneGlowshroom;
            bool jungle = spawnInfo.Player.ZoneJungle;
            bool granite = spawnInfo.Granite;
            bool marble = spawnInfo.Marble;
            bool corruption = spawnInfo.Player.ZoneCorrupt;
            bool crimson = spawnInfo.Player.ZoneCrimson;
            bool snow = spawnInfo.Player.ZoneSnow;
            bool hallow = spawnInfo.Player.ZoneHallow;
            bool desert = spawnInfo.Player.ZoneDesert;

            bool nebulaTower = spawnInfo.Player.ZoneTowerNebula;
            bool vortexTower = spawnInfo.Player.ZoneTowerVortex;
            bool stardustTower = spawnInfo.Player.ZoneTowerStardust;
            bool solarTower = spawnInfo.Player.ZoneTowerSolar;

            bool water = spawnInfo.Water;

            //events
            bool goblinArmy = Main.invasionType == 1;
            bool frostLegion = Main.invasionType == 2;
            bool pirates = Main.invasionType == 3;
            bool oldOnesArmy = DD2Event.Ongoing && spawnInfo.Player.ZoneOldOneArmy;
            bool frostMoon = surface && night && Main.snowMoon;
            bool pumpkinMoon = surface && night && Main.pumpkinMoon;
            bool solarEclipse = surface && day && Main.eclipse;
            bool martianMadness = Main.invasionType == 4;
            bool lunarEvents = NPC.LunarApocalypseIsUp && (nebulaTower || vortexTower || stardustTower || solarTower);
			bool anyEvent = goblinArmy || frostLegion || pirates || oldOnesArmy || frostMoon || pumpkinMoon || solarEclipse || martianMadness || lunarEvents;

            bool normalSpawn = !spawnInfo.PlayerInTown && !anyEvent;
			if (!Main.hardMode)
			{
				if (normalSpawn && !anyEvent)
				{
					if (surface)
					{
						if (day && NPC.downedSlimeKing && !NPC.AnyNPCs(NPCID.KingSlime))
						{
							pool[NPCID.KingSlime] = 0.0005f;
						}
						
						if (night && NPC.downedBoss1 && !NPC.AnyNPCs(NPCID.EyeofCthulhu))
						{
							pool[NPCID.EyeofCthulhu] = 0.0005f;
						}
						
						if (snow && night && NPC.downedDeerclops && !NPC.AnyNPCs(NPCID.Deerclops))
						{
							pool[NPCID.Deerclops] = 0.0005f;
						}
					}
					
					if (NPC.downedBoss2)
					{
						if (corruption && !NPC.AnyNPCs(NPCID.EaterofWorldsHead))
						{
							pool[NPCID.EaterofWorldsHead] = 0.0005f;
						}
						
						if (crimson && !NPC.AnyNPCs(NPCID.BrainofCthulhu))
						{
							pool[NPCID.BrainofCthulhu] = 0.0005f;
						}
					}
					
					if (dungeon && NPC.downedBoss3 && !NPC.AnyNPCs(NPCID.SkeletronHead))
					{
						pool[NPCID.SkeletronHead] = 0.0005f;
					}
					
					if (jungle && cavern && NPC.downedQueenBee && !NPC.AnyNPCs(NPCID.QueenBee))
					{
						pool[NPCID.QueenBee] = 0.0005f;
					}
				}
			}
			else
			{
				if (surface)
				{
					if (day)
					{
						if (!NPC.AnyNPCs(NPCID.KingSlime))
						{
							pool[NPCID.KingSlime] = 0.0005f;
						}
						if (normalSpawn && hallow && !NPC.downedPlantBoss && !NPC.AnyNPCs(NPCID.QueenSlimeBoss))
						{
							pool[NPCID.QueenSlimeBoss] = 0.0005f;
						}
					}
					
					if (night)
					{
						if(!NPC.AnyNPCs(NPCID.EyeofCthulhu))
						{
							pool[NPCID.EyeofCthulhu] = 0.0005f;
						}
						if (hallow && normalSpawn && NPC.downedEmpressOfLight && !NPC.AnyNPCs(NPCID.HallowBoss))
						{
							pool[NPCID.HallowBoss] = 0.0005f;
						}
					}
					
					if (snow && night && !NPC.AnyNPCs(NPCID.Deerclops))
					{
						pool[NPCID.Deerclops] = 0.0005f;
					}
					
					if (ocean && water && normalSpawn && NPC.downedFishron && !NPC.AnyNPCs(NPCID.DukeFishron))
					{
						pool[NPCID.DukeFishron] = 0.0005f;
					}
					
					if (jungle && normalSpawn && NPC.downedGolemBoss && !NPC.AnyNPCs(NPCID.Golem))
					{
						pool[NPCID.Golem] = 0.0005f;
					}
				}
				
				if (corruption && !NPC.AnyNPCs(NPCID.EaterofWorldsHead))
				{
					pool[NPCID.EaterofWorldsHead] = 0.0005f;
				}
				
				if (crimson && !NPC.AnyNPCs(NPCID.BrainofCthulhu))
				{
					pool[NPCID.BrainofCthulhu] = 0.0005f;
				}
				
				if ((dungeon || (night && surface)) && !NPC.AnyNPCs(NPCID.SkeletronHead))
				{
					pool[NPCID.SkeletronHead] = 0.0005f;
				}
				
				if (jungle && !NPC.AnyNPCs(NPCID.QueenBee))
				{
					pool[NPCID.QueenBee] = 0.0005f;
				}
				
				if (underworld && !NPC.AnyNPCs(NPCID.WallofFlesh))
				{
					pool[NPCID.WallofFlesh] = 0.0005f;
				}
				
				if (NPC.downedPlantBoss)
				{
					if (surface)
					{
						if (day && hallow && !NPC.AnyNPCs(NPCID.QueenSlimeBoss))
						{
							pool[NPCID.QueenSlimeBoss] = 0.0005f;
						}
						if (night)
						{
							if (!NPC.AnyNPCs(NPCID.TheDestroyer))
							{
								pool[NPCID.TheDestroyer] = 0.0005f;
							}
							if (!NPC.AnyNPCs(NPCID.Retinazer))
							{
								pool[NPCID.Retinazer] = 0.0005f;
							}
							if (!NPC.AnyNPCs(NPCID.Spazmatism))
							{
								pool[NPCID.Spazmatism] = 0.0005f;
							}
							if (!NPC.AnyNPCs(NPCID.SkeletronPrime))
							{
								pool[NPCID.SkeletronPrime] = 0.0005f;
							}
						}
					}
					if (jungle && cavern && !NPC.AnyNPCs(NPCID.Plantera))
					{
						pool[NPCID.Plantera] = 0.0005f;
					}
				}
				else
				{
					if (surface && night && normalSpawn)
					{
						if (NPC.downedMechBoss1 && !NPC.AnyNPCs(NPCID.TheDestroyer))
						{
							pool[NPCID.TheDestroyer] = 0.0005f;
						}
						
						if (NPC.downedMechBoss2)
						{
							if(!NPC.AnyNPCs(NPCID.Retinazer))
							{
								pool[NPCID.Retinazer] = 0.0005f;
							}
							if(!NPC.AnyNPCs(NPCID.Spazmatism))
							{
								pool[NPCID.Spazmatism] = 0.0005f;
							}
						}
						
						if (NPC.downedMechBoss3 && !NPC.AnyNPCs(NPCID.SkeletronPrime))
						{
							pool[NPCID.SkeletronPrime] = 0.0005f;
						}
					}
				}
			}
		}
    }
}