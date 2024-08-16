
#define UNITS_PER_RAT 8

/datum/reagent/rats
	name = "Rats"
	description = "It's amazing what medicine can do nowadays."
	reagent_state = SOLID
	color = "#463001"
	taste_mult = 5
	taste_description = "greasy fuzz"
	metabolization_rate = 2.5 * REAGENTS_METABOLISM //0.5u/s
	penetrates_skin = NONE
	self_consuming = TRUE
	ph = 7.4 // same as blood
	/// The rat to spawn on spill
	var/rat_mob = /mob/living/basic/mouse/rat
	/// Set to true when there are enough units to produce a rat, never reset.
	var/is_living_rat = FALSE

/datum/reagent/rats/on_mob_life(mob/living/carbon/victim, seconds_per_tick)
	if (volume >= UNITS_PER_RAT)
		if (!is_living_rat)
			is_living_rat = TRUE
			if (volume >= UNITS_PER_RAT * 2)
				victim.visible_message(
					span_userdanger("There's a rat crawling inside of you!"),
				)
			else
				victim.visible_message(
					span_userdanger("There's rats inside of you!")
				)
	. = ..() // delay metabolism until we determine if there's enough "rat juice" to make a full rat
	if (!is_living_rat)
		return
	if (SPT_PROB(5, seconds_per_tick))
		if (prob(50))
			victim.cause_wound_of_type_and_severity(WOUND_SLASH, pick(victim.bodyparts), WOUND_SEVERITY_TRIVIAL, WOUND_SEVERITY_SEVERE)
			victim.visible_message(
				span_userdanger("The rats are slashing you apart!"),
			)
		else
			victim.cause_wound_of_type_and_severity(WOUND_PIERCE, pick(victim.bodyparts), WOUND_SEVERITY_TRIVIAL, WOUND_SEVERITY_MODERATE)
			victim.visible_message(
				span_userdanger("The rats are tearing you apart!"),
			)
	if (SPT_PROB(1, seconds_per_tick))
		victim.cause_wound_of_type_and_severity(WOUND_PIERCE, pick(victim.bodyparts), WOUND_SEVERITY_CRITICAL)
		victim.visible_message(
				span_userdanger("A rat crawls out of you!"),
			)
		new rat_mob(get_turf(victim.loc))
		volume = max(0, volume - UNITS_PER_RAT)
	if(SPT_PROB(2, seconds_per_tick)) // Stuns, but purges rats.
		victim.vomit(VOMIT_CATEGORY_BLOOD, lost_nutrition = rand(5,10), purge_ratio = 0)
		victim.visible_message(
				span_danger("A rat crawls out of [victim]'s mouth!"),
				span_userdanger("A rat crawls out of your mouth!"),
			)
		victim.cause_wound_of_type_and_severity(WOUND_BLUNT, victim.head, WOUND_SEVERITY_TRIVIAL, WOUND_SEVERITY_MODERATE)
		new rat_mob(get_turf(victim.loc))
		volume = max(0, volume - UNITS_PER_RAT)

/datum/reagent/rats/expose_obj(obj/exposed_obj, reac_volume)
	. = ..()
	var/turf/open/my_turf = exposed_obj.loc
	if(!istype(my_turf))
		return
	var/static/list/accepted_types = typecacheof(list(/obj/machinery/atmospherics, /obj/structure/cable, /obj/structure/disposalpipe))
	if(!accepted_types[exposed_obj.type])
		return
	expose_turf(my_turf, reac_volume)

/datum/reagent/rats/expose_turf(turf/exposed_turf, reac_volume)
	. = ..()
	if(!istype(exposed_turf) || isspaceturf(exposed_turf)) // Is the turf valid
		return
	var/rats_to_spawn = floor(reac_volume / UNITS_PER_RAT)
	if (rats_to_spawn == 0)
		return
	var/variance = ceil(rats_to_spawn / 10)
	var/sqrt_variance = sqrt(variance)
	for (var/i in 1 to rats_to_spawn)
		var/mob/living/basic/mouse/rat/spawned = new rat_mob(exposed_turf)
		var/turf/target_turf = locate(exposed_turf.x + sqrt(rand(0, variance)) - sqrt_variance / 2, exposed_turf.y + sqrt(rand(0, variance)) - sqrt_variance / 2, exposed_turf.z)
		if (!target_turf.density)
			spawned.forceMove(target_turf)

/datum/chemical_reaction/rats // frankenrat
	results = list(/datum/reagent/rats = (UNITS_PER_RAT * 2))
	required_reagents = list(
		/datum/reagent/blood = 40,
		/datum/reagent/medicine/c2/synthflesh = 60,
		/datum/reagent/stable_plasma = 20,
		)
	optimal_ph_min = 3
	optimal_ph_max = 12
	required_temp = 470
	reaction_flags = REACTION_INSTANT | REAGENT_SPLITRETAINVOL
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_UNIQUE

#undef UNITS_PER_RAT
