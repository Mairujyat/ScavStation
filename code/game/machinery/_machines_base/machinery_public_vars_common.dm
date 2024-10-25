/*
Public vars at /obj/machinery level. Just because they are here does not mean that every machine exposes them; you must add them to the appropriate list.
*/

/obj/machinery
	var/input_toggle = FALSE
	var/identifier = ""

/decl/public_access/public_variable/input_toggle
	expected_type = /obj/machinery
	name = "input toggle"
	desc = "The input toggle variable does not do anything by itself. This makes it useful for having receivers trigger transmitters. Can be toggled by a public method."
	can_write = FALSE
	has_updates = TRUE

/decl/public_access/public_variable/input_toggle/access_var(obj/machinery/machine)
	return machine.input_toggle

/decl/public_access/public_variable/input_toggle/write_var(obj/machinery/machine, new_value)
	. = ..()
	if(.)
		machine.input_toggle = new_value

/decl/public_access/public_method/toggle_input_toggle
	name = "toggle input"
	desc = "Toggles the input toggle variable."
	call_proc = TYPE_PROC_REF(/obj/machinery, toggle_input_toggle)

/obj/machinery/proc/toggle_input_toggle()
	var/decl/public_access/public_variable/variable = GET_DECL(/decl/public_access/public_variable/input_toggle)
	variable.write_var(src, !input_toggle)

/decl/public_access/public_variable/area_uid
	expected_type = /obj/machinery
	name = "area id"
	desc = "An automatically generated area id, if this machine is tied to an area controller."
	can_write = FALSE
	has_updates = FALSE
	var_type = IC_FORMAT_STRING

/decl/public_access/public_variable/area_uid/access_var(obj/machinery/machine)
	return machine.area_uid()

/obj/machinery/proc/area_uid()
	var/area/A = get_area(src)
	return A ? A.uid : "NONE"

/decl/public_access/public_variable/identifier
	expected_type = /obj/machinery
	name = "type identifier"
	desc = "A generic variable intended to give machines a text designator to sort them into categories by function."
	can_write = TRUE
	has_updates = TRUE
	var_type = IC_FORMAT_STRING

/decl/public_access/public_variable/identifier/access_var(obj/machinery/machine)
	return machine.identifier

/decl/public_access/public_variable/identifier/write_var(obj/machinery/machine, new_value)
	. = ..()
	if(.)
		machine.identifier = new_value

/decl/public_access/public_variable/use_power
	expected_type = /obj/machinery
	name = "power use code"
	desc = "Whether the machine is off (0) or on (positive). Some machines have multiple power states. Writing to this variable may turn the machine off or on."
	can_write = TRUE
	has_updates = FALSE
	var_type = IC_FORMAT_NUMBER

/decl/public_access/public_variable/use_power/access_var(obj/machinery/machine)
	return machine.use_power

/decl/public_access/public_variable/use_power/write_var(obj/machinery/machine, new_value)
	if(!(new_value in list(POWER_USE_OFF, POWER_USE_IDLE, POWER_USE_ACTIVE)))
		return FALSE
	. = ..()
	if(.)
		machine.update_use_power(new_value)

/decl/public_access/public_variable/name
	expected_type = /obj/machinery
	name = "name"
	desc = "The machine's name."
	can_write = TRUE
	has_updates = FALSE
	var_type = IC_FORMAT_STRING

/decl/public_access/public_variable/name/access_var(obj/machinery/machine)
	return machine.name

/decl/public_access/public_variable/name/write_var(obj/machinery/machine, new_value)
	. = ..()
	if(.)
		machine.SetName(new_value)

/decl/public_access/public_variable/reagents
	expected_type = /obj/machinery
	name = "reagents"
	desc = "Obtain the list of reagents and their data in the machine."
	can_write = FALSE
	has_updates = TRUE
	var_type = IC_FORMAT_LIST

/decl/public_access/public_variable/reagents/access_var(obj/machinery/machine)
	return machine?.reagents?.reagent_data

/decl/public_access/public_variable/reagents/volumes
	name = "reagents volumes"
	desc = "Obtain the list of reagents and their volumes in the machine."
	var_type = IC_FORMAT_LIST

/decl/public_access/public_variable/reagents/volumes/access_var(obj/machinery/machine)
	return machine?.reagents?.reagent_volumes

/decl/public_access/public_variable/reagents/free_space
	name = "reagents free space"
	desc = "Obtain the volume of free space left for reagents in the machine."
	var_type = IC_FORMAT_NUMBER

/decl/public_access/public_variable/reagents/free_space/access_var(obj/machinery/machine)
	return REAGENTS_FREE_SPACE(machine?.reagents)

/decl/public_access/public_variable/reagents/total_volume
	name = "reagents total volume"
	desc = "Obtain the total volume of reagents in the machine."
	var_type = IC_FORMAT_NUMBER

/decl/public_access/public_variable/reagents/total_volume/access_var(obj/machinery/machine)
	return machine?.reagents?.total_volume

/decl/public_access/public_variable/reagents/maximum_volume
	name = "reagents maximum volume"
	desc = "Obtain the maximum volume of reagents that can fit in the machine."
	var_type = IC_FORMAT_NUMBER

/decl/public_access/public_variable/reagents/maximum_volume/access_var(obj/machinery/machine)
	return machine?.reagents?.maximum_volume

/decl/public_access/public_method/toggle_power
	name = "toggle power"
	desc = "Turns the machine on or off."
	call_proc = TYPE_PROC_REF(/obj/machinery, toggle_power)

/obj/machinery/proc/toggle_power()
	update_use_power(!use_power)

/decl/public_access/public_method/refresh
	name = "refresh machine"
	desc = "Attempts to refresh the machine's status. Implementation may vary."
	call_proc = TYPE_PROC_REF(/obj/machinery, refresh)

/obj/machinery/proc/refresh()
	queue_icon_update()