/*
Galactic Survey Boat "Khthonia"
A trash planet with a trash ship
*/
#if !defined(USING_MAP_DATUM)

//
//	#ifdef UNIT_TEST
//		#include "../../code/unit_tests/offset_tests.dm"
//	#endif

	#include "../random_ruins/exoplanet_ruins/playablecolony/playablecolony.dm"
	#include "../../mods/content/pheromones/_pheromones.dme"
	#include "../../mods/content/xenobiology/_xenobiology.dme"
	#include "../../mods/content/corporate/_corporate.dme"
	#include "../../mods/content/matchmaking/_matchmaking.dme"
	#include "../../mods/species/ascent/_ascent.dme"
	#include "../../mods/species/neoavians/_neoavians.dme"
	//#include "../../mods/species/vox/_vox.dme"
	#include "../../mods/species/serpentid/_serpentid.dme"
	#include "../../mods/species/bayliens/_bayliens.dme"
	#include "../../mods/content/mundane.dm"
	#include "../../mods/content/bigpharma/_bigpharma.dme"
	#include "../../mods/content/government/_government.dme"
	#include "../../mods/content/modern_earth/_modern_earth.dme"
	#include "../../mods/content/mouse_highlights/_mouse_highlight.dme"
	#include "../../mods/content/psionics/_psionics.dme"
	#include "../../mods/content/scaling_descriptors.dm"
	#include "../../mods/valsalia/_valsalia.dme"

	//#include "gsbkhthonia_antagonists.dm"
	//#include "gsbkhthonia_areas.dm"
	#include "gsbkhthonia_departments.dm"
	#include "gsbkhthonia_jobs.dm"
	//#include "gsbkhthonia_shuttles.dm"
	//#include "gsbkhthonia_unit_testing.dm"
	//#include "gsbkhthonia_overrides.dm"

	#include "gsbkhthonia-0.dmm"
	#include "gsbkhthonia-1.dmm"
	#include "gsbkhthonia-2.dmm"
	#include "gsbkhthonia-3.dmm"
	#include "gsbkhthonia-4.dmm"


	#include "../away/bearcat/bearcat.dm"
	#include "../away/casino/casino.dm"
	#include "../away/derelict/derelict.dm"
	#include "../away/errant_pisces/errant_pisces.dm"
	#include "../away/lost_supply_base/lost_supply_base.dm"
	#include "../away/magshield/magshield.dm"
	#include "../away/mining/mining.dm"
	#include "../away/mobius_rift/mobius_rift.dm"
	#include "../away/smugglers/smugglers.dm"
	#include "../away/slavers/slavers_base.dm"
	#include "../away/unishi/unishi.dm"
	#include "../away/yacht/yacht.dm"
	#include "../away/liberia/liberia.dm"

	#include "../../mods/mobs/dionaea/_dionaea.dme"
	#include "../../mods/mobs/borers/_borers.dme"

	#include "gsbkhthonia_overmap.dm"

	//#include "jobs/command.dm"
	#include "jobs/civilian.dm"
	//#include "jobs/engineering.dm"
	//#include "jobs/medical.dm"
	//#include "jobs/security.dm"
	//#include "jobs/science.dm"
	//#include "jobs/yinglets.dm"
	//#include "jobs/tradehouse.dm"
	//#include "jobs/synthetics.dm"

	#include "outfits/_outfits.dm"
	//#include "outfits/command.dm"
	#include "outfits/civilian.dm"
	//#include "outfits/engineering.dm"
	//#include "outfits/medical.dm"
	//#include "outfits/science.dm"
	//#include "outfits/security.dm"
	//#include "outfits/yinglets.dm"
	//#include "outfits/tradehouse.dm"

	#define USING_MAP_DATUM /datum/map/gsbkhthonia

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring gsbkhthonia.

#endif