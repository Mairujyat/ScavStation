// the underfloor wiring terminal for the APC
// autogenerated when an APC is placed
// all conduit connects go to this object instead of the APC
// using this solves the problem of having the APC in a wall yet also inside an area

/obj/machinery/power/terminal
	name = "terminal"
	icon_state = "term"
	desc = "It's an underfloor wiring terminal for power equipment."
	level = 1
	layer = EXPOSED_WIRE_TERMINAL_LAYER
	var/obj/item/stock_parts/power/terminal/master
	anchored = 1

	stat_immune = NOINPUT | NOSCREEN | NOPOWER
	interact_offline = TRUE
	uncreated_component_parts = null
	construct_state = /decl/machine_construction/noninteractive/terminal // Auxiliary entity; all interactions pass through owner machine part instead.

/obj/machinery/power/terminal/Initialize()
	. = ..()
	var/turf/T = src.loc
	if(level == 1 && isturf(T))
		hide(!T.is_plating())

/obj/machinery/power/terminal/Destroy()
	master = null
	. = ..()

/obj/machinery/power/terminal/attackby(obj/item/W, mob/user)
	if(isWirecutter(W))
		var/turf/T = get_turf(src)
		var/obj/machinery/machine = master_machine()

		if(istype(T) && !T.is_plating())
			to_chat(user, SPAN_WARNING("You must remove the floor plating in front of \the [machine] first!"))
			return

		 // If this is a terminal that's somehow been left behind, let it be removed freely. 
		if(machine && !machine.components_are_accessible(/obj/item/stock_parts/power/terminal))
			to_chat(user, SPAN_WARNING("You must open the panel on \the [machine] first!"))
			return

		user.visible_message(SPAN_WARNING("\The [user] dismantles the power terminal from \the [machine]."), \
										  "You begin to cut the cables...")
		playsound(src.loc, 'sound/items/Deconstruct.ogg', 50, 1)
		if(do_after(user, 50, src))
			if(!QDELETED(src) && (!master || !machine || machine.components_are_accessible(/obj/item/stock_parts/power/terminal)))
				if (prob(50) && electrocute_mob(user, powernet, src))
					spark_at(machine, amount=5, cardinal_only = TRUE)
					if(HAS_STATUS(user, STAT_STUN))
						return TRUE
				new /obj/item/stack/cable_coil(T, 10)
				to_chat(user, SPAN_NOTICE("You cut the cables and dismantle the power terminal."))
				qdel_self()
	. = ..()

/obj/machinery/power/terminal/examine(mob/user)
	. = ..()
	var/obj/machinery/machine = master_machine()
	if(machine)
		to_chat(user, "It is attached to \the [machine].")

/obj/machinery/power/terminal/proc/master_machine()
	var/obj/machinery/machine = master && master.loc
	if(istype(machine))
		return machine

/obj/machinery/power/terminal/hide(var/do_hide)
	if(do_hide && level == 1)
		layer = WIRE_TERMINAL_LAYER
	else
		reset_plane_and_layer()

/obj/machinery/power/terminal/connect_to_network()
	. = ..()
	var/obj/machinery/machine = master_machine()
	if(machine)
		machine.power_change()

/obj/machinery/power/terminal/disconnect_from_network()
	. = ..()
	var/obj/machinery/machine = master_machine()
	if(machine)
		machine.power_change()

/obj/machinery/power/terminal/on_update_icon()
	. = ..()
	if(master)
		var/obj/machinery/machine = master_machine()
		
		// Wall frames and SMES have directional terminals.
		if(!master.terminal_dir && !ispath(machine.frame_type, /obj/item/frame))
			icon_state = "term-omni"
		else
			icon_state = "term"