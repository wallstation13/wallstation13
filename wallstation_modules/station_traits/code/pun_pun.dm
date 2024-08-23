#define SECHUD_BUSSER "hudbusser"
#define JOB_PUN_PUN "Pun Pun"
#define JOB_DISPLAY_ORDER_PUN_PUN JOB_DISPLAY_ORDER_PSYCHOLOGIST + 0.5 //between the psych and the AI

///A station trait that make Pun Pun a playable job for the shift.
/datum/station_trait/job/pun_pun
	name = "Pun Pun is a Crewmember"
	button_desc = "Ook ook ah ah, sign up to play as the bartender's monkey."
	weight = 1
	report_message = "We've evaluated the bartender's monkey to have the mental capacity of the average crewmember. As such, we made them one."
	show_in_report = TRUE
	job_to_add = /datum/job/pun_pun

/datum/station_trait/job/pun_pun/on_lobby_button_update_overlays(atom/movable/screen/lobby/button/sign_up/lobby_button, list/overlays)
	. = ..()
	var/mutable_appearance/pun_pun_overlay = mutable_appearance('wallstation_modules/station_traits/icons/signup_button.dmi')
	pun_pun_overlay.icon_state = LAZYFIND(lobby_candidates, lobby_button.get_mob()) ? "pun_pun_on" : "pun_pun_off"
	overlays += pun_pun_overlay

///Pun Pun gets the strong arm implant if the 'Cybernetic Revolutions' trait also rolls.
/datum/station_trait/cybernetic_revolution/New()
	job_to_cybernetic[/datum/job/pun_pun] = /obj/item/organ/internal/cyberimp/arm/strongarm
	return ..()

///Pun Pun gets to access the monkey agent uplink item, being a monkey itself.
/datum/uplink_item/role_restricted/monkey_agent/New()
	. = ..()
	restricted_roles += JOB_PUN_PUN

///Pun Pun gets to access the monkey supplies uplink item, being a monkey itself.

/datum/uplink_item/role_restricted/monkey_supplies/New()
	. = ..()
	restricted_roles += JOB_PUN_PUN

///The job of our playable Pun Pun.
/datum/job/pun_pun
	title = JOB_PUN_PUN
	description = "Assist the service department by serving drinks and food and entertaining the crew."
	department_head = list(JOB_HEAD_OF_PERSONNEL)
	faction = FACTION_STATION
	total_positions = 0
	spawn_positions = 0
	supervisors = "the Bartender"
	spawn_type = /mob/living/carbon/human/species/monkey/punpun
	outfit = /datum/outfit/job/pun_pun
	config_tag = "PUN_PUN"
	random_spawns_possible = FALSE
	paycheck = PAYCHECK_LOWER
	paycheck_department = ACCOUNT_CIV
	display_order = JOB_DISPLAY_ORDER_PUN_PUN
	departments_list = list(/datum/job_department/service)
	exclusive_mail_goodies = TRUE
	mail_goodies = list(
		/obj/item/food/grown/banana = 4,
		/obj/effect/spawner/random/entertainment/money_medium = 3,
		/obj/item/clothing/head/helmet/monkey_sentience = 1,
		/obj/item/book/granter/sign_language = 1,
		/obj/item/food/monkeycube = 1,
	)
	rpg_title = "Homunculus"
	allow_bureaucratic_error = FALSE
	job_flags = STATION_TRAIT_JOB_FLAGS|JOB_ANNOUNCE_ARRIVAL|JOB_NEW_PLAYER_JOINABLE|JOB_EQUIP_RANK|JOB_CREW_MANIFEST|JOB_CREW_MEMBER

/datum/job/pun_pun/get_spawn_mob(client/player_client, atom/spawn_point)
	if (!player_client)
		return
	var/mob/living/monky = new spawn_type(get_turf(spawn_point))
	GLOB.the_one_and_only_punpun = monky
	return monky

/datum/job/pun_pun/after_spawn(mob/living/carbon/human/monkey, client/player_client)
	. = ..()
	monkey.dna.add_mutation(/datum/mutation/human/clever)
	//Lock the clever and monkey mutations so they don't get humanized or become lame to play as.
	for(var/datum/mutation/human/mutation as anything in monkey.dna.mutations)
		mutation.mutadone_proof = TRUE
		mutation.instability = 0
	ADD_TRAIT(monkey, TRAIT_NO_DNA_SCRAMBLE, SPECIES_TRAIT)

///The outfit of our playable Pun Pun.
/datum/outfit/job/pun_pun
	name = "Pun Pun"
	jobtype = /datum/job/pun_pun

	id_trim = /datum/id_trim/job/pun_pun
	belt = /obj/item/modular_computer/pda/pun_pun
	uniform = /obj/item/clothing/under/suit/waiter
	backpack_contents = list(
		/obj/item/gun/ballistic/shotgun/monkey = 1,
		/obj/item/storage/box/beanbag = 1,
	)
	shoes = null //monkeys cannot equip shoes

///The ID trim of our playable Pun Pun.
/datum/id_trim/job/pun_pun
	trim_icon = 'wallstation_modules/station_traits/icons/id_trim.dmi'
	assignment = "busser"
	trim_state = "trim_busser"
	department_color = COLOR_SERVICE_LIME
	subdepartment_color = COLOR_SERVICE_LIME
	sechud_icon_state = SECHUD_BUSSER
	minimal_access = list(
		ACCESS_MINERAL_STOREROOM,
		ACCESS_SERVICE,
		ACCESS_THEATRE,
		)
	extra_access = list(
		ACCESS_HYDROPONICS,
		ACCESS_KITCHEN,
		ACCESS_BAR,
		)
	template_access = list(
		ACCESS_CAPTAIN,
		ACCESS_CHANGE_IDS,
		ACCESS_HOP,
		)
	job = /datum/job/pun_pun

///The PDA we give to Pun Pun.
/obj/item/modular_computer/pda/pun_pun
	name = "monkey PDA"
	greyscale_colors = "#ffcc66#914800"
	starting_programs = list(
		/datum/computer_file/program/bounty_board,
		/datum/computer_file/program/emojipedia,
	)

///An underpowered single-shot shotgun given to Pun Pun when the station job trait rolls.
/obj/item/gun/ballistic/shotgun/monkey
	name = "\improper Barback's Shot"
	desc = "A chimp-sized, single-shot and break-action shotgun with an unpractical stock."
	icon = 'wallstation_modules/station_traits/icons/monkey_shotgun.dmi'
	icon_state = "chimp_shottie"
	inhand_icon_state = "shotgun"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	force = 8
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = NONE
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/single
	obj_flags = UNIQUE_RENAME
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_MEDIUM
	semi_auto = TRUE
	bolt_type = BOLT_TYPE_NO_BOLT
	spread = 10
	projectile_damage_multiplier = 0.5
	projectile_wound_bonus = -25
	recoil = 1
	pin = /obj/item/firing_pin/monkey
	pb_knockback = 1

/obj/item/ammo_box/magazine/internal/shot/single
	name = "single-barrel shotgun internal magazine"
	max_ammo = 1

///Delete the maploaded Pun Pun if the job trait is present and leave a landmark in its wake.
/mob/living/carbon/human/species/monkey/punpun/Initialize(mapload)
	if(!mapload || !(locate(/datum/station_trait/job/pun_pun) in SSstation.station_traits))
		return ..()
	REGISTER_REQUIRED_MAP_ITEM(1, 1) //Register the mapped pun pun so that the unit test will pass anyway.
	new /obj/effect/landmark/start/pun_pun(loc)
	return INITIALIZE_HINT_QDEL

///The Landmark where we spawn our playable Pun Pun. Left in place of the maploaded Pun Pun when the trait rolls.
/obj/effect/landmark/start/pun_pun
	name = JOB_PUN_PUN
	icon = 'icons/mob/human/human.dmi'
	icon_state = "monkey"

#undef SECHUD_BUSSER
#undef JOB_PUN_PUN
#undef JOB_DISPLAY_ORDER_PUN_PUN
