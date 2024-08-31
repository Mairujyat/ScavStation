/decl/material/liquid/hermetic_secretion
	name = "Hermetic Secretion"
	lore_text = "A grey-brown liquid, found in the putrid flesh of a long-dead organism."
	taste_description = "decaying blood"
	color = "554f4d"
	molar_mass = 0.020
	boiling_point = 502 CELSIUS
	melting_point = -8.95 CELSIUS
	latent_heat = 2258
	gas_condensation_point = 435.45 // 162.3C
	overdose = 100
	heating_products = list(
		/decl/material/liquid/denatured_toxin = 0.1,
		/decl/material/gas/methyl_bromide = 0.35,
		/decl/material/liquid/presyncopics = 0.1,
		/decl/material/liquid/blood = 0.1,
		/decl/material/liquid/neuroannealer = 0.15,
		/decl/material/liquid/hallucinogenics = 0.05,
		/decl/material/liquid/psychotropics = 0.05,
		/decl/material/liquid/psychoactives = 0.05,
		/decl/material/liquid/amphetamines = 0.05
	)

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
		if(prob(1))
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
		H.seizure()
	M.adjustBrainLoss(rand(1, 5))
	if(prob(10))
		to_chat(M, SPAN_DANGER("<font size = [rand(2,4)]>[pick(overdose_messages)]</font>"))
	if(prob(10))
		M.emote(/decl/emote/visible/drool)
	M.adjustOxyLoss(3)
	ADJ_STATUS(M, STAT_JITTER, 50)
	ADJ_STATUS(M, STAT_DIZZY,  3)
	ADJ_STATUS(M, STAT_CONFUSE, 2)
	ADJ_STATUS(M, STAT_SLUR, 10)
	ADJ_STATUS(M, STAT_STUTTER, 10)
	M.set_hallucination(50, 50)
	M.add_chemical_effect(CE_THIRDEYE, 1)
	M.add_chemical_effect(CE_MIND, -2)
	M.add_chemical_effect(CE_GLOWINGEYES, 1)
	M.add_chemical_effect(CE_SLOWDOWN, 10)
	M.add_chemical_effect(CE_PULSE, -4)
	M.add_chemical_effect(CE_ALCOHOL, 1)
	M.add_chemical_effect(CE_TOXIN, -1)
	M.add_chemical_effect(CE_BREATHLOSS, 0.6)
	M.add_chemical_effect(CE_OXYGENATED, 2)
	M.add_chemical_effect(CE_VOICELOSS, 1)
	M.add_chemical_effect(CE_PAINKILLER, 100)
	M.add_chemical_effect(CE_NOPULSE, 1)
	M.add_chemical_effect(CE_BRAIN_REGEN, 1)
	M.add_chemical_effect(CE_BLOODRESTORE, 1)
	M.apply_damage(15, armor_pen = 100)
	M.timeofdeath = world.time

/decl/material/liquid/hekatic_enzyme
	name = "Hekatic Enzyme"
	lore_text = "A dark red sludge, found in the putrid flesh of a long-dead organism."
	taste_description = "absolutely vile"
	color = "420000"
	molar_mass = 0.020
	boiling_point = 502 CELSIUS
	melting_point = -8.95 CELSIUS
	latent_heat = 2258
	gas_condensation_point = 435.45 // 162.3C
	overdose = 0.1
	solvent_power = MAT_SOLVENT_VERY_STRONG
	solvent_melt_dose = 7
	solvent_max_damage = 90
	var/amount_to_zombify = 0.1
	exoplanet_rarity_plant = MAT_RARITY_NOWHERE
	exoplanet_rarity_gas = MAT_RARITY_NOWHERE
	uid = "liquid_hekatic_enzyme"
	heating_products = list(
		/decl/material/liquid/acid/stomach = 0.35,
		/decl/material/liquid/blood = 0.1,
		/decl/material/liquid/zombie = 0.1,
		/decl/material/liquid/crystal_agent = 0.1,
		/decl/material/liquid/antiseptic = 0.1,
		/decl/material/liquid/hallucinogenics = 0.1,
		/decl/material/liquid/narcotics = 0.15
	)

/decl/material/liquid/hekatic_enzyme/affect_overdose(var/mob/living/M)
	if(ishuman(M) && M.dna)
		if(prob (5))
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
		M.seizure()
	M.adjustBrainLoss(rand(1, 5))
	if (prob(10))
		to_chat(M, "<span class='warning'>You feel like your gut is trying to digest itself!</span>")
		M.emote(/decl/emote/audible/scream)
	if(prob(25))
		M.apply_damage(rand(80,120), 0)
	else
		to_chat(M, SPAN_DANGER("Jagged brown crystals erupt from your skin, ripping through it!"))
		M.adjustBruteLoss(rand(3,6))
	ADJ_STATUS(M, STAT_JITTER, 50)
	ADJ_STATUS(M, STAT_DIZZY,  3)
	ADJ_STATUS(M, STAT_CONFUSE, 2)
	ADJ_STATUS(M, STAT_SLUR, 10)
	ADJ_STATUS(M, STAT_STUTTER, 10)
	M.set_hallucination(50, 50)
	M.add_chemical_effect(CE_MIND, 2)
	M.add_chemical_effect(CE_SPEEDBOOST, 10)
	M.add_chemical_effect(CE_PULSE, 4)
	M.add_chemical_effect(CE_ALCOHOL_TOXIC, 1)
	M.add_chemical_effect(CE_BREATHLOSS, 0.6)
	M.apply_damage(15, armor_pen = 100)
	M.timeofdeath = world.time