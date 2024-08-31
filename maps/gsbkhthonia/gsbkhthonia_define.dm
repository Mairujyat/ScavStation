/datum/map/gsbkhthonia
	name = "Khthonia"
	full_name = "GSB Khthonia"
	path = "gsbkhthonia"
	ground_noun = "ground"

	station_name = "Galactic Survey Boat Khthonia"
	station_short = "Khthonia"

	dock_name     = "Val Salia Station"
	boss_name     = "Trademaster"
	boss_short    = "Admin"
	company_name  = "Tradehouse Ivenmoth"
	company_short = "Ivenmoth"

	default_law_type = /datum/ai_laws/nanotrasen

	lobby_screens = list('maps/ministation/ministation_lobby.png')

	overmap_ids = list(OVERMAP_ID_SPACE)
	num_exoplanets = 3
	away_site_budget = 3
	lobby_tracks = list(/decl/music_track/absconditus,
/decl/music_track/level3_mod, /decl/music_track/tintin, /decl/music_track/zazie

	)

	shuttle_docked_message = "The public ferry to %dock_name% has docked with the station. It will depart in approximately %ETD%"
	shuttle_leaving_dock   = "The public ferry has left the station. Estimate %ETA% until the ferry docks at %dock_name%."
	shuttle_called_message = "A public ferry to %dock_name% has been scheduled. It will arrive in approximately %ETA%"
	shuttle_recall_message = "The scheduled ferry has been cancelled."

	emergency_shuttle_docked_message = "The emergency shuttle has docked with the station. You have approximately %ETD% to board the emergency shuttle."
	emergency_shuttle_leaving_dock = "The emergency shuttle has left the station. Estimate %ETA% until the shuttle docks at %dock_name%."
	emergency_shuttle_called_message = "An emergency evacuation shuttle has been called. It will arrive in approximately %ETA%."
	emergency_shuttle_called_sound = 'sound/AI/shuttlecalled.ogg'

	emergency_shuttle_recall_message = "The emergency shuttle has been recalled."

	evac_controller_type = /datum/evacuation_controller/shuttle

	pray_reward_type = /obj/item/mollusc/clam

	starting_money = 5000
	department_money = 1000
	salary_modifier = 0.2

	radiation_detected_message = "High levels of radiation have been detected in proximity of the %STATION_NAME%. Station wide maintenance access has been granted. Please take shelter within the nearest maintenance tunnel."

	allowed_latejoin_spawns = list(
		/decl/spawnpoint/arrivals,
		/decl/spawnpoint/cryo
	)
	default_spawn = /decl/spawnpoint/arrivals

	default_telecomms_channels = list(
		list("name" = "Science",       "key" = "n", "frequency" = 1351, "color" = COMMS_COLOR_SCIENCE,   "span_class" = "sciradio", "secured" = list(access_research)),
		list("name" = "Medical",       "key" = "m", "frequency" = 1355, "color" = COMMS_COLOR_MEDICAL,   "span_class" = "medradio", "secured" = list(access_medical)),
		list("name" = "Supply",        "key" = "u", "frequency" = 1347, "color" = COMMS_COLOR_SUPPLY,    "span_class" = "supradio", "secured" = list(access_cargo)),
		list("name" = "Service",       "key" = "v", "frequency" = 1349, "color" = COMMS_COLOR_SERVICE,   "span_class" = "srvradio", "secured" = list(access_bar)),
		COMMON_FREQUENCY_DATA,
		list("name" = "AI Private",    "key" = "p", "frequency" = 1343, "color" = COMMS_COLOR_AI,        "span_class" = "airadio",  "secured" = list(access_ai_upload)),
		list("name" = "Entertainment", "key" = "z", "frequency" = 1461, "color" = COMMS_COLOR_ENTERTAIN, "span_class" = CSS_CLASS_RADIO, "receive_only" = TRUE),
		list("name" = "Command",       "key" = "c", "frequency" = 1353, "color" = COMMS_COLOR_COMMAND,   "span_class" = "comradio", "secured" = list(access_bridge)),
		list("name" = "Engineering",   "key" = "e", "frequency" = 1357, "color" = COMMS_COLOR_ENGINEER,  "span_class" = "engradio", "secured" = list(access_engine)),
		list("name" = "Security",      "key" = "s", "frequency" = 1359, "color" = COMMS_COLOR_SECURITY,  "span_class" = "secradio", "secured" = list(access_security))
		)

/datum/map/gsbkhthonia/get_map_info()
	return "You're among the surviving crew of the <b>[station_name]</b>. After a severe malfunction with the propulsion system the ship crash-landed in this arid wasteland, her crew left to fend for themselves. \
	The only solace you and your crew have left is your shared sense of purpose and mighty corporate commitment, injected deep into your hearts by the [boss_name]'s stirring speech during the crew orientation video: \
	<b>In the event of an emergency, never lose hope! There is <i>always</i> work to be done, and each ship is stocked out the wazoo - there's <i>no way</i> there'll be a drop in productivity!</b>"