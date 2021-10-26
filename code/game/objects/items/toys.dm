/* Toys!
 * Contains:
 *		Balloons
 *		Fake telebeacon
 *		Fake singularity
 *		Toy gun
 *		Toy crossbow
 *		Toy swords
 *		Toy bosun's whistle
 *      Toy mechs
 *		Snap pops
 *		Water flower
 *      Therapy dolls
 *      Inflatable duck
 *		Action figures
 *		Plushies
 *		Toy cult sword
 *		Marshalling wand
 *		Ring bell
 *
 *	desk toys
 */



/obj/item/toy
	icon = 'icons/obj/toy.dmi'
	throwforce = 0
	throw_speed = 4
	throw_range = 20
	force = 0

/*
 * Balloons
 */
/obj/item/toy/water_balloon
	name = "water balloon"
	desc = "A translucent balloon. There's nothing in it."
	icon = 'icons/obj/toy.dmi'
	icon_state = "waterballoon-e"
	item_state = "balloon-empty"
	force = 0

/obj/item/toy/water_balloon/Initialize()
	. = ..()
	create_reagents(10)
	item_flags |= ITEM_FLAG_NO_BLUDGEON

/obj/item/toy/water_balloon/resolve_attackby(obj/structure/O, mob/user, click_params)
	. = (istype(O) && fill_from_pressurized_fluid_source(O, user)) || ..()

/obj/item/toy/water_balloon/fill_from_pressurized_fluid_source(obj/source, mob/user)
	. = ..()
	desc = . ? "A translucent balloon with some form of liquid sloshing around in it." : initial(desc)
	update_icon()

/obj/item/toy/water_balloon/attackby(obj/O, mob/user)
	if(istype(O, /obj/item/chems/glass))
		if(O.reagents)
			if(O.reagents.total_volume < 1)
				to_chat(user, "The [O] is empty.")
			else if(O.reagents.total_volume >= 1)
				if(O.reagents.has_reagent(/decl/material/liquid/acid/polyacid, 1))
					to_chat(user, "The acid chews through the balloon!")
					O.reagents.splash(user, reagents.total_volume)
					qdel(src)
				else
					src.desc = "A translucent balloon with some form of liquid sloshing around in it."
					to_chat(user, "<span class='notice'>You fill the balloon with the contents of [O].</span>")
					O.reagents.trans_to_obj(src, 10)
	src.update_icon()
	return

/obj/item/toy/water_balloon/throw_impact(atom/hit_atom)
	..()
	if(reagents && reagents.total_volume >= 1)
		visible_message(SPAN_WARNING("\The [src] bursts!"),"You hear a pop and a splash.")
		reagents.trans_to_turf(get_turf(hit_atom), reagents.total_volume)
		if(!QDELETED(src))
			icon_state = "burst"
			qdel(src)

/obj/item/toy/water_balloon/on_update_icon()
	if(src.reagents.total_volume >= 1)
		icon_state = "waterballoon"
		item_state = "balloon"
	else
		icon_state = "waterballoon-e"
		item_state = "balloon-empty"

/obj/item/toy/balloon
	name = "\improper 'criminal' balloon"
	desc = "FUK CAPITALISM!11!"
	throwforce = 0
	throw_speed = 4
	throw_range = 20
	force = 0
	icon = 'icons/obj/items/balloon.dmi'
	icon_state = "syndballoon"
	item_state = "syndballoon"
	w_class = ITEM_SIZE_HUGE

/obj/item/toy/balloon/Initialize()
	. = ..()
	desc = "Across the balloon is printed: \"[desc]\""

/*
 * Fake telebeacon
 */
/obj/item/toy/blink
	name = "electronic blink toy game"
	desc = "Blink.  Blink.  Blink. Ages 8 and up."
	icon = 'icons/obj/items/device/radio/beacon.dmi'
	icon_state = "beacon"
	item_state = "signaler"

/*
 * Fake singularity
 */
/obj/item/toy/spinningtoy
	name = "gravitational singularity"
	desc = "\"Singulo\" brand spinning toy."
	icon = 'icons/obj/singularity.dmi'
	icon_state = "singularity_s1"

/*
 * Toy swords
 */
/obj/item/energy_blade/sword/toy
	name = "toy sword"
	desc = "A cheap, plastic replica of an energy sword. Realistic sounds! Ages 8 and up."
	sharp = FALSE
	edge =  FALSE
	force = 1
	throwforce = 1
	attack_verb = list("hit")
	material = /decl/material/solid/plastic

	active_hitsound = 'sound/weapons/genhit.ogg'
	active_descriptor = "extended"
	active_force = 1
	active_throwforce = 1
	active_attack_verb = list("hit")
	active_edge = FALSE
	active_sharp = FALSE

/obj/item/sword/katana/toy
	name = "toy katana"
	desc = "Woefully underpowered in D20."
	material = /decl/material/solid/plastic

/*
 * Snap pops
 */
/obj/item/toy/snappop
	name = "snap pop"
	desc = "Wow!"
	icon = 'icons/obj/toy.dmi'
	icon_state = "snappop"
	w_class = ITEM_SIZE_TINY

/obj/item/toy/snappop/throw_impact(atom/hit_atom)
	..()
	spark_at(src, cardinal_only = TRUE)
	new /obj/effect/decal/cleanable/ash(src.loc)
	visible_message(SPAN_WARNING("The [src.name] explodes!"),SPAN_WARNING("You hear a snap!"))
	playsound(src, 'sound/effects/snap.ogg', 50, 1)
	qdel(src)

/obj/item/toy/snappop/Crossed(H)
	if((ishuman(H))) //i guess carp and shit shouldn't set them off
		var/mob/living/carbon/M = H
		if(!MOVING_DELIBERATELY(M))
			to_chat(M, "<span class='warning'>You step on the snap pop!</span>")

			spark_at(src, amount=2)
			new /obj/effect/decal/cleanable/ash(src.loc)
			src.visible_message("<span class='warning'>The [src.name] explodes!</span>","<span class='warning'>You hear a snap!</span>")
			playsound(src, 'sound/effects/snap.ogg', 50, 1)
			qdel(src)

/*
 * Bosun's whistle
 */

/obj/item/toy/bosunwhistle
	name = "bosun's whistle"
	desc = "A genuine Admiral Krush Bosun's Whistle, for the aspiring ship's captain! Suitable for ages 8 and up, do not swallow."
	icon = 'icons/obj/toy.dmi'
	icon_state = "bosunwhistle"
	var/cooldown = 0
	w_class = ITEM_SIZE_TINY
	slot_flags = SLOT_EARS

/obj/item/toy/bosunwhistle/attack_self(mob/user)
	if(cooldown < world.time - 35)
		to_chat(user, "<span class='notice'>You blow on [src], creating an ear-splitting noise!</span>")
		playsound(user, 'sound/misc/boatswain.ogg', 20, 1)
		cooldown = world.time

/*
 * Mech prizes
 */
/obj/item/toy/prize
	icon = 'icons/obj/toy.dmi'
	icon_state = "ripleytoy"
	var/cooldown = 0
	w_class = ITEM_SIZE_TINY

//all credit to skasi for toy mech fun ideas
/obj/item/toy/prize/attack_self(mob/user)
	if(cooldown < world.time - 8)
		to_chat(user, "<span class='notice'>You play with [src].</span>")
		playsound(user, 'sound/mecha/mechstep.ogg', 20, 1)
		cooldown = world.time

/obj/item/toy/prize/attack_hand(mob/user)
	if(loc == user)
		if(cooldown < world.time - 8)
			to_chat(user, "<span class='notice'>You play with [src].</span>")
			playsound(user, 'sound/mecha/mechturn.ogg', 20, 1)
			cooldown = world.time
			return
	..()

/obj/item/toy/prize/powerloader
	name = "toy ripley"
	desc = "Mini-mech action figure! Collect them all! 1/11."

/obj/item/toy/prize/fireripley
	name = "toy firefighting ripley"
	desc = "Mini-mech action figure! Collect them all! 2/11."
	icon_state = "fireripleytoy"

/obj/item/toy/prize/deathripley
	name = "toy deathsquad ripley"
	desc = "Mini-mech action figure! Collect them all! 3/11."
	icon_state = "deathripleytoy"

/obj/item/toy/prize/gygax
	name = "toy gygax"
	desc = "Mini-mech action figure! Collect them all! 4/11."
	icon_state = "gygaxtoy"

/obj/item/toy/prize/durand
	name = "toy durand"
	desc = "Mini-mech action figure! Collect them all! 5/11."
	icon_state = "durandprize"

/obj/item/toy/prize/honk
	name = "toy H.O.N.K."
	desc = "Mini-mech action figure! Collect them all! 6/11."
	icon_state = "honkprize"

/obj/item/toy/prize/marauder
	name = "toy marauder"
	desc = "Mini-mech action figure! Collect them all! 7/11."
	icon_state = "marauderprize"

/obj/item/toy/prize/seraph
	name = "toy seraph"
	desc = "Mini-mech action figure! Collect them all! 8/11."
	icon_state = "seraphprize"

/obj/item/toy/prize/mauler
	name = "toy mauler"
	desc = "Mini-mech action figure! Collect them all! 9/11."
	icon_state = "maulerprize"

/obj/item/toy/prize/odysseus
	name = "toy odysseus"
	desc = "Mini-mech action figure! Collect them all! 10/11."
	icon_state = "odysseusprize"

/obj/item/toy/prize/phazon
	name = "toy phazon"
	desc = "Mini-mech action figure! Collect them all! 11/11."
	icon_state = "phazonprize"

/*
 * Action figures
 */

/obj/item/toy/figure
	name = "Completely Glitched action figure"
	desc = "A \"Space Life\" brand... wait, what the hell is this thing? It seems to be requesting the sweet release of death."
	icon_state = "assistant"
	icon = 'icons/obj/toy.dmi'
	w_class = ITEM_SIZE_TINY

/obj/item/toy/figure/cmo
	name = "Chief Medical Officer action figure"
	desc = "A \"Space Life\" brand Chief Medical Officer action figure."
	icon_state = "cmo"

/obj/item/toy/figure/assistant
	name = "Assistant action figure"
	desc = "A \"Space Life\" brand Assistant action figure."
	icon_state = "assistant"

/obj/item/toy/figure/atmos
	name = "Atmospheric Technician action figure"
	desc = "A \"Space Life\" brand Atmospheric Technician action figure."
	icon_state = "atmos"

/obj/item/toy/figure/bartender
	name = "Bartender action figure"
	desc = "A \"Space Life\" brand Bartender action figure."
	icon_state = "bartender"

/obj/item/toy/figure/borg
	name = "Cyborg action figure"
	desc = "A \"Space Life\" brand Cyborg action figure."
	icon_state = "borg"

/obj/item/toy/figure/gardener
	name = "Gardener action figure"
	desc = "A \"Space Life\" brand Gardener action figure."
	icon_state = "botanist"

/obj/item/toy/figure/captain
	name = "Captain action figure"
	desc = "A \"Space Life\" brand Captain action figure."
	icon_state = "captain"

/obj/item/toy/figure/cargotech
	name = "Cargo Technician action figure"
	desc = "A \"Space Life\" brand Cargo Technician action figure."
	icon_state = "cargotech"

/obj/item/toy/figure/ce
	name = "Chief Engineer action figure"
	desc = "A \"Space Life\" brand Chief Engineer action figure."
	icon_state = "ce"

/obj/item/toy/figure/chaplain
	name = "Chaplain action figure"
	desc = "A \"Space Life\" brand Chaplain action figure."
	icon_state = "chaplain"

/obj/item/toy/figure/chef
	name = "Chef action figure"
	desc = "A \"Space Life\" brand Chef action figure."
	icon_state = "chef"

/obj/item/toy/figure/chemist
	name = "Pharmacist action figure"
	desc = "A \"Space Life\" brand Pharmacist action figure."
	icon_state = "chemist"

/obj/item/toy/figure/clown
	name = "Clown action figure"
	desc = "A \"Space Life\" brand Clown action figure."
	icon_state = "clown"

/obj/item/toy/figure/corgi
	name = "Corgi action figure"
	desc = "A \"Space Life\" brand Corgi action figure."
	icon_state = "ian"

/obj/item/toy/figure/detective
	name = "Detective action figure"
	desc = "A \"Space Life\" brand Detective action figure."
	icon_state = "detective"

/obj/item/toy/figure/dsquad
	name = "Space Commando action figure"
	desc = "A \"Space Life\" brand Space Commando action figure."
	icon_state = "dsquad"

/obj/item/toy/figure/engineer
	name = "Engineer action figure"
	desc = "A \"Space Life\" brand Engineer action figure."
	icon_state = "engineer"

/obj/item/toy/figure/geneticist
	name = "Geneticist action figure"
	desc = "A \"Space Life\" brand Geneticist action figure, which was recently dicontinued."
	icon_state = "geneticist"

/obj/item/toy/figure/hop
	name = "Head of Personel action figure"
	desc = "A \"Space Life\" brand Head of Personel action figure."
	icon_state = "hop"

/obj/item/toy/figure/hos
	name = "Head of Security action figure"
	desc = "A \"Space Life\" brand Head of Security action figure."
	icon_state = "hos"

/obj/item/toy/figure/qm
	name = "Quartermaster action figure"
	desc = "A \"Space Life\" brand Quartermaster action figure."
	icon_state = "qm"

/obj/item/toy/figure/janitor
	name = "Janitor action figure"
	desc = "A \"Space Life\" brand Janitor action figure."
	icon_state = "janitor"

/obj/item/toy/figure/agent
	name = "Internal Affairs Agent action figure"
	desc = "A \"Space Life\" brand Internal Affairs Agent action figure."
	icon_state = "agent"

/obj/item/toy/figure/librarian
	name = "Librarian action figure"
	desc = "A \"Space Life\" brand Librarian action figure."
	icon_state = "librarian"

/obj/item/toy/figure/md
	name = "Medical Doctor action figure"
	desc = "A \"Space Life\" brand Medical Doctor action figure."
	icon_state = "md"

/obj/item/toy/figure/mime
	name = "Mime action figure"
	desc = "A \"Space Life\" brand Mime action figure."
	icon_state = "mime"

/obj/item/toy/figure/miner
	name = "Shaft Miner action figure"
	desc = "A \"Space Life\" brand Shaft Miner action figure."
	icon_state = "miner"

/obj/item/toy/figure/ninja
	name = "Space Ninja action figure"
	desc = "A \"Space Life\" brand Space Ninja action figure."
	icon_state = "ninja"

/obj/item/toy/figure/wizard
	name = "Wizard action figure"
	desc = "A \"Space Life\" brand Wizard action figure."
	icon_state = "wizard"

/obj/item/toy/figure/rd
	name = "Chief Science Officer action figure"
	desc = "A \"Space Life\" brand Chief Science Officer action figure."
	icon_state = "rd"

/obj/item/toy/figure/roboticist
	name = "Roboticist action figure"
	desc = "A \"Space Life\" brand Roboticist action figure."
	icon_state = "roboticist"

/obj/item/toy/figure/scientist
	name = "Scientist action figure"
	desc = "A \"Space Life\" brand Scientist action figure."
	icon_state = "scientist"

/obj/item/toy/figure/syndie
	name = "Doom Operative action figure"
	desc = "A \"Space Life\" brand Doom Operative action figure."
	icon_state = "syndie"

/obj/item/toy/figure/secofficer
	name = "Security Officer action figure"
	desc = "A \"Space Life\" brand Security Officer action figure."
	icon_state = "secofficer"

/obj/item/toy/figure/warden
	name = "Warden action figure"
	desc = "A \"Space Life\" brand Warden action figure."
	icon_state = "warden"

/obj/item/toy/figure/psychologist
	name = "Psychologist action figure"
	desc = "A \"Space Life\" brand Psychologist action figure."
	icon_state = "psychologist"

/obj/item/toy/figure/paramedic
	name = "Paramedic action figure"
	desc = "A \"Space Life\" brand Paramedic action figure."
	icon_state = "paramedic"

/obj/item/toy/figure/ert
	name = "Emergency Response Team Commander action figure"
	desc = "A \"Space Life\" brand Emergency Response Team Commander action figure."
	icon_state = "ert"

/obj/item/toy/therapy_red
	name = "red therapy doll"
	desc = "A toy for therapeutic and recreational purposes. This one is red."
	icon_state = "therapyred"
	item_state = "egg4" // It's the red egg in items_left/righthand
	w_class = ITEM_SIZE_TINY

/obj/item/toy/therapy_purple
	name = "purple therapy doll"
	desc = "A toy for therapeutic and recreational purposes. This one is purple."
	icon_state = "therapypurple"
	item_state = "egg1" // It's the magenta egg in items_left/righthand
	w_class = ITEM_SIZE_TINY

/obj/item/toy/therapy_blue
	name = "blue therapy doll"
	desc = "A toy for therapeutic and recreational purposes. This one is blue."
	icon_state = "therapyblue"
	item_state = "egg2" // It's the blue egg in items_left/righthand
	w_class = ITEM_SIZE_TINY

/obj/item/toy/therapy_yellow
	name = "yellow therapy doll"
	desc = "A toy for therapeutic and recreational purposes. This one is yellow."
	icon_state = "therapyyellow"
	item_state = "egg5" // It's the yellow egg in items_left/righthand
	w_class = ITEM_SIZE_TINY

/obj/item/toy/therapy_orange
	name = "orange therapy doll"
	desc = "A toy for therapeutic and recreational purposes. This one is orange."
	icon_state = "therapyorange"
	item_state = "egg4" // It's the red one again, lacking an orange item_state and making a new one is pointless
	w_class = ITEM_SIZE_TINY

/obj/item/toy/therapy_green
	name = "green therapy doll"
	desc = "A toy for therapeutic and recreational purposes. This one is green."
	icon_state = "therapygreen"
	item_state = "egg3" // It's the green egg in items_left/righthand
	w_class = ITEM_SIZE_TINY

/*
 * Plushies
 */

//Large plushies.
/obj/structure/plushie
	name = "generic plush"
	desc = "A very generic plushie. It seems to not want to exist."
	icon = 'icons/obj/toy.dmi'
	icon_state = "ianplushie"
	anchored = 0
	density = 1
	var/phrase = "I don't want to exist anymore!"

/obj/structure/plushie/attack_hand(mob/user)
	playsound(src.loc, 'sound/effects/rustle1.ogg', 100, 1)
	if(user.a_intent == I_HELP)
		user.visible_message("<span class='notice'><b>\The [user]</b> hugs [src]!</span>","<span class='notice'>You hug [src]!</span>")
	else if (user.a_intent == I_HURT)
		user.visible_message("<span class='warning'><b>\The [user]</b> punches [src]!</span>","<span class='warning'>You punch [src]!</span>")
	else if (user.a_intent == I_GRAB)
		user.visible_message("<span class='warning'><b>\The [user]</b> attempts to strangle [src]!</span>","<span class='warning'>You attempt to strangle [src]!</span>")
	else
		user.visible_message("<span class='notice'><b>\The [user]</b> pokes the [src].</span>","<span class='notice'>You poke the [src].</span>")
		visible_message("[src] says, \"[phrase]\"")

/obj/structure/plushie/ian
	name = "plush corgi"
	desc = "A plushie of an adorable corgi! Don't you just want to hug it and squeeze it and call it \"Ian\"?"
	icon_state = "ianplushie"
	phrase = "Arf!"

/obj/structure/plushie/drone
	name = "plush drone"
	desc = "A plushie of a happy drone! It appears to be smiling."
	icon_state = "droneplushie"
	phrase = "Beep boop!"

/obj/structure/plushie/carp
	name = "plush carp"
	desc = "A plushie of an elated carp! Straight from the wilds of the frontier, now right here in your hands."
	icon_state = "carpplushie"
	phrase = "Glorf!"

/obj/structure/plushie/beepsky
	name = "plush Officer Sweepsky"
	desc = "A plushie of a popular industrious cleaning robot! If it could feel emotions, it would love you."
	icon_state = "beepskyplushie"
	phrase = "Ping!"

//Small plushies.
/obj/item/toy/plushie
	name = "generic small plush"
	desc = "A very generic small plushie. It seems to not want to exist."
	icon = 'icons/obj/toy.dmi'
	icon_state = "nymphplushie"

/obj/item/toy/plushie/attack_self(mob/user)
	if(user.a_intent == I_HELP)
		user.visible_message("<span class='notice'><b>\The [user]</b> hugs [src]!</span>","<span class='notice'>You hug [src]!</span>")
	else if (user.a_intent == I_HURT)
		user.visible_message("<span class='warning'><b>\The [user]</b> punches [src]!</span>","<span class='warning'>You punch [src]!</span>")
	else if (user.a_intent == I_GRAB)
		user.visible_message("<span class='warning'><b>\The [user]</b> attempts to strangle [src]!</span>","<span class='warning'>You attempt to strangle [src]!</span>")
	else
		user.visible_message("<span class='notice'><b>\The [user]</b> pokes the [src].</span>","<span class='notice'>You poke the [src].</span>")

/obj/item/toy/plushie/mouse
	name = "mouse plush"
	desc = "A plushie of a mouse! What was once considered a vile rodent is now your very best friend."
	icon_state = "mouseplushie"

/obj/item/toy/plushie/kitten
	name = "kitten plush"
	desc = "A plushie of a cute kitten! Watch as it purrs it's way right into your heart."
	icon_state = "kittenplushie"

/obj/item/toy/plushie/lizard
	name = "lizard plush"
	desc = "A plushie of a scaly lizard!"
	icon_state = "lizardplushie"

/obj/item/toy/plushie/spider
	name = "spider plush"
	desc = "A plushie of a fuzzy spider! It has eight legs - all the better to hug you with."
	icon_state = "spiderplushie"

//Toy cult sword
/obj/item/sword/cult_toy
	name = "foam sword"
	desc = "An arcane weapon (made of foam) wielded by the followers of the hit Saturday morning cartoon \"King Nursee and the Acolytes of Heroism\"."
	icon = 'icons/obj/items/weapon/swords/cult.dmi'
	material = /decl/material/solid/plastic
	edge = 0
	sharp = 0

/obj/item/inflatable_duck
	name = "inflatable duck"
	desc = "No bother to sink or swim when you can just float!"
	icon = 'icons/clothing/belt/inflatable.dmi'
	icon_state = ICON_STATE_WORLD
	slot_flags = SLOT_LOWER_BODY

/obj/item/marshalling_wand
	name = "marshalling wand"
	desc = "An illuminated, hand-held baton used by hangar personnel to visually signal shuttle pilots. The signal changes depending on your intent."
	icon_state = "marshallingwand"
	item_state = "marshallingwand"
	icon = 'icons/obj/toy.dmi'
	slot_flags = SLOT_LOWER_BODY
	w_class = ITEM_SIZE_SMALL
	force = 1
	attack_verb = list("attacked", "whacked", "jabbed", "poked", "marshalled")

/obj/item/marshalling_wand/Initialize()
	set_light(1.5, 1.5, "#ff0000")
	return ..()

/obj/item/marshalling_wand/attack_self(mob/user)
	playsound(src.loc, 'sound/effects/rustle1.ogg', 100, 1)
	if (user.a_intent == I_HELP)
		user.visible_message("<span class='notice'>[user] beckons with \the [src], signalling forward motion.</span>",
							"<span class='notice'>You beckon with \the [src], signalling forward motion.</span>")
	else if (user.a_intent == I_DISARM)
		user.visible_message("<span class='notice'>[user] holds \the [src] above their head, signalling a stop.</span>",
							"<span class='notice'>You hold \the [src] above your head, signalling a stop.</span>")
	else if (user.a_intent == I_GRAB)
		var/wand_dir
		if(user.get_equipped_item(BP_L_HAND) == src)
			wand_dir = "left"
		else if (user.get_equipped_item(BP_R_HAND) == src)
			wand_dir = "right"
		else
			wand_dir = pick("left", "right")
		user.visible_message("<span class='notice'>[user] waves \the [src] to the [wand_dir], signalling a turn.</span>",
							"<span class='notice'>You wave \the [src] to the [wand_dir], signalling a turn.</span>")
	else if (user.a_intent == I_HURT)
		user.visible_message("<span class='warning'>[user] frantically waves \the [src] above their head!</span>",
							"<span class='warning'>You frantically wave \the [src] above your head!</span>")

/obj/item/toy/shipmodel
	name = "table-top spaceship model"
	desc = "This is a 1:250th scale spaceship model on a handsome wooden stand. Small lights blink on the hull and at the engine exhaust."
	icon = 'icons/obj/toy.dmi'
	icon_state = "shipmodel"

/obj/item/toy/ringbell
	name = "ringside bell"
	desc = "A bell used to signal the beginning and end of various ring sports."
	icon = 'icons/obj/toy.dmi'
	icon_state= "ringbell"
	anchored = 1

/obj/item/toy/ringbell/attack_hand(mob/user)
	if (user.a_intent == I_HELP)
		user.visible_message("<span class='notice'>[user] rings \the [src], signalling the beginning of the contest.</span>")
		playsound(user.loc, 'sound/items/oneding.ogg', 60)
	else if (user.a_intent == I_DISARM)
		user.visible_message("<span class='notice'>[user] rings \the [src] three times, signalling the end of the contest!</span>")
		playsound(user.loc, 'sound/items/threedings.ogg', 60)
	else if (user.a_intent == I_HURT)
		user.visible_message("<span class='warning'>[user] rings \the [src] repeatedly, signalling a disqualification!</span>")
		playsound(user.loc, 'sound/items/manydings.ogg', 60)

//Office Desk Toys

/obj/item/toy/desk
	name = "desk toy master"
	desc = "A object that does not exist. Parent Item"

	var/on = 0
	var/activation_sound = 'sound/effects/flashlight.ogg'

/obj/item/toy/desk/on_update_icon()
	if(on)
		icon_state = "[initial(icon_state)]-on"
	else
		icon_state = "[initial(icon_state)]"

/obj/item/toy/desk/attack_self(mob/user)
	on = !on
	if(on && activation_sound)
		playsound(src.loc, activation_sound, 75, 1)
	update_icon()
	return 1

/obj/item/toy/desk/newtoncradle
	name = "\improper Newton's cradle"
	desc = "A ancient 21th century super-weapon model demonstrating that Sir Isaac Newton is the deadliest sonuvabitch in space."
	icon_state = "newtoncradle"

/obj/item/toy/desk/fan
	name = "office fan"
	desc = "Your greatest fan."
	icon_state= "fan"

/obj/item/toy/desk/officetoy
	name = "office toy"
	desc = "A generic microfusion powered office desk toy. Only generates magnetism and ennui."
	icon_state= "desktoy"

/obj/item/toy/desk/dippingbird
	name = "dipping bird toy"
	desc = "A ancient human bird idol, worshipped by clerks and desk jockeys."
	icon_state= "dippybird"

// tg station ports

/obj/item/toy/eightball
	name = "magic eightball"
	desc = "A black ball with a stencilled number eight in white on the side. It seems full of dark liquid.\nThe instructions state that you should ask your question aloud, and then shake."
	icon_state = "eightball"
	w_class = ITEM_SIZE_TINY

	var/static/list/possible_answers = list(
		"It is certain",
		"It is decidedly so",
		"Without a doubt",
		"Yes, definitely",
		"You may rely on it",
		"As I see it, yes",
		"Most likely",
		"Outlook good",
		"Yes",
		"Signs point to yes",
		"Reply hazy, try again",
		"Ask again later",
		"Better not tell you now",
		"Cannot predict now",
		"Concentrate and ask again",
		"Don't count on it",
		"My reply is no",
		"My sources say no",
		"Outlook not so good",
		"Very doubtful")

/obj/item/toy/eightball/attack_self(mob/user)
	user.visible_message("<span class='notice'>\The [user] shakes \the [src] for a moment, and it says, \"[pick(possible_answers) ].\"</span>")

/obj/item/toy/eightball/afterattack(obj/O, mob/user, var/proximity)
	. = ..()
	if (proximity)
		visible_message("<span class='warning'>\The [src] says, \"[pick(possible_answers) ]\" as it hits \the [O]!</span>")
