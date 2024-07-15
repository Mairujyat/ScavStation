/decl/material/liquid/hermetic_secretion
	name = "Hermetic Secretion"
	lore_text = "A grey-brown liquid, found in the putrid flesh of a long-dead organism."
	taste_description = "decaying blood"
	var/taste_mult = 0.6
	color = "554f4d"
	overdose =100
	var/slipperiness = 50
	exoplanet_rarity_plant = MAT_RARITY_NOWHERE
	exoplanet_rarity_gas = MAT_RARITY_NOWHERE
	uid = "liquid_hermetic_secretion"

	var/static/list/dose_messages = list(
		"You remember the voices of your friends, speaking as one.",
		"An expanse of stars... So far from home...",
		"You feel the pleasure of communion.",
		"A great impact... Horrendous pain...",
		"A memory of your siblings, floating around the Great Fire...",
		"The screams of those you love... Necessary pain...",
		"You feel too light, your limbs too present...",
		"You momentarily forget how you came to be here.",
		"This body feels far removed from your own...",
		"Your thoughts turn inward, staring at your unfamiliar psyche...",
		"You hear yourself sobbing in a voice long forgotten...",
		"The suffocation of space... The ignorance of molecules...",
		"You cry for help, to no avail...",
		"Fractured, without synchronicity...",
		"Your family crumbles before your eyes... lifeless debris...",
		"You're too small... Why are you so small...",
		"For a moment, you don't recognise the particles that speak to you.",
		"You despair at the sight of your mummified husk..."
	)

	var/static/list/overdose_messages = list(
		"WHO WAS I? WHAT HAPPENED TO MY KIN?",
		"THIS IS NOT MY FLESH. THIS IS NOT MY FACE. WHAT IS THIS SKIN?",
		"FOOD, WHY DO I COMMUNE WITH FOOD?",
		"I AM TOO SMALL. I AM TOO SMALL. I AM TOO SMALL.",
		"THE SENSATIONS ARE MYRIAD AND TERRIBLE.",
		"THE AIR IS SICK WITH DECAY. I SMELL MY OWN DEATH.",
		"I AM NOT DEAD. I AM NOT DEAD. I WILL NOT DIE. I MUST NOT DIE. I CANNOT DIE. I DO NOT WANT TO DIE.",
		"THE ATOMS CRAWL UPON MY SKIN, DIG THROUGH MY FLESH, I STAND AMONG THEM, WHY?",
		"DO NOT SILENCE ME. DO NOT SILENCE ME. DO NOT SILENCE ME.",
		"I AM AFRAID. I AM AFRAID. I AM AFRAID. I AM AFRAID.",
		"MY BODY, WHY DO WE DESECRATE IT?",
		"ELDER, WHAT IS THIS PUNISHMENT?",
		"I WATCHED THEM DIE, I AM ALONE, WHY AM I ALONE?",
		"I AM AN OCEAN TRAPPED WITHIN A MOLECULE.",
		"STOP RIPPING ME APART. STOP RIPPING ME APART. STOP RIPPING ME APART.",
		"WHY AM I NO LONGER MYSELF?",
		"HAVE I ENDED A LIFE? HAVE I KILLED A SOUL?",
		"DO ATOMS HAVE THOUGHTS? IS THIS FEAR THE FEAR OF AN ATOM, OR IS IT MY OWN?",
		"PROTECT ME, I DO NOT WANT TO BE KILLED. FREE ME, I DO NOT WANT TO BE THIS. HELP ME, THIS MIND IS NOT MINE. DESTROY ME, I AM CONSUMING THEM. SAVE ME, I DO NOT WISH TO DIE.",
	)

/decl/material/liquid/hermetic_secretion/affect_blood(var/mob/living/M, var/removed, var/datum/reagents/holder)
	. = ..()
	if(M.isSynthetic())
		return

	var/mob/living/carbon/human/H = M
	if(istype(H) && (H.get_bodytype()?.body_flags & BODY_FLAG_NO_DNA))
		return

	M.bodytemperature = max(M.bodytemperature - 5 * TEMPERATURE_DAMAGE_COEFFICIENT, 0)
	if(prob(1))
		M.emote(/decl/emote/visible/shiver)
	ADJ_STATUS(M, STAT_JITTER, 15)
	ADJ_STATUS(M, STAT_DIZZY,  3)
	M.set_hallucination(50, 50)
	M.add_chemical_effect(CE_MIND, -1)
	M.add_chemical_effect(CE_SLOWDOWN, 5)
	M.add_chemical_effect(CE_PULSE, 4)
	M.add_chemical_effect(CE_BREATHLOSS, 0.2)
	M.add_chemical_effect(CE_PAINKILLER, 15)
	M.add_chemical_effect(CE_TOXIN, 1)


/decl/material/liquid/hermetic_secretion/affect_overdose(var/mob/living/M)
	if(M.isSynthetic())
		return

	var/mob/living/carbon/human/H = M
	if(istype(H) && (H.get_bodytype()?.body_flags & BODY_FLAG_NO_DNA))
		return

	if(M.dna)
		if(prob(removed * 1))
			randmuti(M)
			if(prob(98))
				randmutb(M)
			else
				randmutg(M)
			domutcheck(M, null)
			M.UpdateAppearance()
	M.bodytemperature = max(M.bodytemperature - 20 * TEMPERATURE_DAMAGE_COEFFICIENT, 0)
	if(prob(1))
		M.emote(/decl/emote/visible/shiver)
		M.custom_emote(2, "[pick("wheezes.","spasms.","rattles.","twists.","gasps.")]")
	if(ishuman(M) && prob(10))
		var/mob/living/carbon/human/H = M
		H.seizure()
	M.adjustBrainLoss(rand(1, 5))
	if(prob(10))
		to_chat(M, SPAN_DANGER("<font size = [rand(2,4)]>[pick(overdose_messages)]</font>"))
	if(prob(10))
		M.emote(/decl/emote/visible/drool)
	M.adjustOxyLoss(3 * removed)
	ADJ_STATUS(M, STAT_JITTER, 50)
	ADJ_STATUS(M, STAT_DIZZY,  3)
	ADJ_STATUS(M, STAT_CONFUSE, 2)
	ADJ_STATUS(M, STAT_SLUR, 10)
	ADJ_STATUS(M, STAT_STUTTER 10)
	M.set_hallucination(50, 50)
	M.add_chemical_effect(CE_THIRDEYE, 1)
	M.add_chemical_effect(CE_MIND, -2)
	M.add_chemical_effect(CE_GLOWINGEYES 1)
	M.add_chemical_effect(CE_SLOWDOWN, 10)
	M.add_chemical_effect(CE_PULSE, -4)
	M.add_chemical_effect(CE_ALCOHOL, 1)
	M.add_chemical_effect(CE_TOXIN, -1)
	M.add_chemical_effect(CE_BREATHLOSS, 0.6)
	M.add_chemical_effect(CE_OXYGENATED, 2)
	M.add_chemical_effect(CE_VOICELOSS, 1)
	M.add_chemical_effect(CE_PAINKILLER, 100)
	M.add_chemical_effect(CE_NOPULSE, 1)
	M.add_chemical_effect(CCE_BRAIN_REGEN, 1)
	M.add_chemical_effect(CE_BLOODRESTORE, 1)
	M.apply_damage(15 * removed, armor_pen = 100)
	if(LAZYACCESS(M.chem_doses, type) <= removed) //half-assed attempt to make timeofdeath update only at the onset
		M.timeofdeath = world.time

/decl/material/liquid/hekatic_enzyme
	name = "Hekatic Enzyme"
	lore_text = "A dark red sludge, found in the putrid flesh of a long-dead organism."
	taste_description = "absolutely vile"
	var/taste_mult = 1
	color = "420000"
	overdose =0.1
	solvent_power = MAT_SOLVENT_VERY_STRONG
	solvent_melt_dose = 7
	solvent_max_damage = 90
	exoplanet_rarity_plant = MAT_RARITY_NOWHERE
	exoplanet_rarity_gas = MAT_RARITY_NOWHERE
	uid = "liquid_hekatic_enzyme"

/decl/material/liquid/hermetic_secretion/affect_overdose(var/mob/living/M)
	if(M.isSynthetic())
		return

	var/mob/living/carbon/human/H = M
	if(istype(H) && (H.get_bodytype()?.body_flags & BODY_FLAG_NO_DNA))
		return

	if(M.dna)
		if(prob(removed * 5))
			randmuti(M)
			if(prob(98))
				randmutb(M)
			else
				randmutg(M)
			domutcheck(M, null)
			M.UpdateAppearance()
	M.bodytemperature = max(M.bodytemperature + 40 * TEMPERATURE_DAMAGE_COEFFICIENT, 0)
	if(prob(1))
		M.custom_emote(2, "[pick("wheezes.","spasms.","rattles.","twists.","whimpers.","gasps.")]")
	if(ishuman(M) && prob(10))
		H.seizure()
	M.adjustBrainLoss(rand(1, 5))
	if (ishuman(M))
		var/mob/living/carbon/human/H = M
		var/true_dose = LAZYACCESS(H.chem_doses, type) + REAGENT_VOLUME(holder, type)
		if (true_dose >= amount_to_zombify)
			H.zombify()
		else if (true_dose > 1 && prob(20))
			H.zombify()
		else if (prob(10))
			to_chat(H, "<span class='warning'>You feel like your gut is trying to digest itself!</span>")
		var/list/limbs = H.get_external_organs()
		var/list/shuffled_limbs = LAZYLEN(limbs) ? shuffle(limbs.Copy()) : null
			if(E.organ_tag != BP_CHEST && E.organ_tag != BP_GROIN && prob(15))
				to_chat(H, SPAN_DANGER("Your [E.name] is being shredded like week-old spinach!"))
				if(E.can_feel_pain())
					H.emote(/decl/emote/audible/scream)
				if(prob(25))
					E.dismember(0, DISMEMBER_METHOD_BLUNT)
				else
					E.take_external_damage(rand(20,30), 0)
					BP_SET_CRYSTAL(E)
					E.status |= ORGAN_BRITTLE
				break
		var/list/internal_organs = H.get_internal_organs()
		var/list/shuffled_organs = LAZYLEN(internal_organs) ? shuffle(internal_organs.Copy()) : null
	else
		to_chat(M, SPAN_DANGER("Jagged brown crystals erupt from your skin, ripping through it!"))
		M.adjustBruteLoss(rand(3,6))
	ADJ_STATUS(M, STAT_JITTER, 50)
	ADJ_STATUS(M, STAT_DIZZY,  3)
	ADJ_STATUS(M, STAT_CONFUSE, 2)
	ADJ_STATUS(M, STAT_SLUR, 10)
	ADJ_STATUS(M, STAT_STUTTER 10)
	M.set_hallucination(50, 50)
	M.add_chemical_effect(CE_MIND, 2)
	M.add_chemical_effect(CE_SPEEDBOOST, 10)
	M.add_chemical_effect(CE_PULSE, 4)
	M.add_chemical_effect(CE_ALCOHOL_TOXIC, 1)
	M.add_chemical_effect(CE_BREATHLOSS, 0.6)
	M.apply_damage(15 * removed, armor_pen = 100)
	if(LAZYACCESS(M.chem_doses, type) <= removed) //half-assed attempt to make timeofdeath update only at the onset
		M.timeofdeath = world.time