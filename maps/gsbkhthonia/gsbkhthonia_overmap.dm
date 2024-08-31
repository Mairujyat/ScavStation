/obj/effect/overmap/visitable/exoplanet/gsbkhthonia
	name = "Galactic Survey Boat Khthonia"
	color = "#00ffff"
//	start_x = 4
//	start_y = 4
	vessel_mass = 5000
	max_speed = 1/(2 SECONDS)
	burn_delay = 2 SECONDS
	restricted_area = 30
	sector_flags = OVERMAP_SECTOR_KNOWN|OVERMAP_SECTOR_BASE|OVERMAP_SECTOR_UNTARGETABLE

	initial_generic_waypoints = list(
		"nav_gsbkhthonia_arrivals_west"
	)


	//exploration and rescue shuttles can only dock port side, b/c there's only one door.
	//initial_restricted_waypoints = list(
	//	/datum/shuttle/autodock/overmap/science_shuttle = list("nav_gsbkhthonia_arrivals_west")
	//)
