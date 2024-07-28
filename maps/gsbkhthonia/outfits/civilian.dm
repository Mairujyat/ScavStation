/decl/hierarchy/outfit/job/gsbkhthonia/cargo
	l_ear = /obj/item/radio/headset/headset_cargo
	name = "GSBKhthonia - Job - Cargo technician"
	uniform = /obj/item/clothing/under/cargotech
	id_type = /obj/item/card/id/gsbkhthonia/cargo
	pda_type = /obj/item/modular_computer/pda/cargo
	backpack_contents = list(/obj/item/crowbar = 1, /obj/item/storage/ore = 1)
	outfit_flags = OUTFIT_HAS_BACKPACK | OUTFIT_EXTENDED_SURVIVAL | OUTFIT_HAS_VITALS_SENSOR
	suit = /obj/item/clothing/suit/storage/toggle/redcoat/service/officiated
	yinglet_suit_service = TRUE

/decl/hierarchy/outfit/job/gsbkhthonia/cargo/Initialize()
	. = ..()
	BACKPACK_OVERRIDE_ENGINEERING

/decl/hierarchy/outfit/job/gsbkhthonia/bartender
	l_ear = /obj/item/radio/headset/headset_service
	name = "GSBKhthonia - Job - Bartender"
	uniform = /obj/item/clothing/under/bartender
	id_type = /obj/item/card/id/gsbkhthonia/bartender
	pda_type = /obj/item/modular_computer/pda
	suit = /obj/item/clothing/suit/storage/toggle/redcoat/service/officiated
	head = /obj/item/clothing/head/chefhat
	yinglet_suit_service = TRUE

/decl/hierarchy/outfit/job/gsbkhthonia/janitor
	l_ear = /obj/item/radio/headset/headset_service
	name = "GSBKhthonia - Job - Janitor"
	uniform = /obj/item/clothing/under/janitor
	id_type = /obj/item/card/id/gsbkhthonia/janitor
	pda_type = /obj/item/modular_computer/pda
	suit = /obj/item/clothing/suit/storage/toggle/redcoat/service/officiated
	yinglet_suit_service = TRUE

/decl/hierarchy/outfit/job/gsbkhthonia/librarian
	l_ear = /obj/item/radio/headset/headset_service
	name = "GSBKhthonia - Job - Librarian"
	uniform = /obj/item/clothing/under/yinglet/yinglibrarian
	id_type = /obj/item/card/id/gsbkhthonia/librarian
	pda_type = /obj/item/modular_computer/pda
	suit = /obj/item/clothing/suit/storage/toggle/redcoat/service/officiated
	yinglet_suit_service = TRUE

//cards
/obj/item/card/id/gsbkhthonia/cargo
	name = "identification card"
	desc = "A card issued to cargo staff."
	detail_color = COLOR_BROWN

/obj/item/card/id/gsbkhthonia/bartender
	desc = "A card issued to kitchen staff."

/obj/item/card/id/gsbkhthonia/janitor
	desc = "A card issued to custodial staff."

/obj/item/card/id/gsbkhthonia/librarian
	desc = "A card issued to the station librarian."
