/// ORIGINAL FILE: code/modules/deathmatch/deathmatch_maps.dm

/datum/lazy_template/deathmatch/ragecage
	name = "Ragecage"
	desc = "Fun for the whole family, the classic ragecage."
	max_players = 4
	automatic_gameend_time = 4 MINUTES // its a 10x10 cage what are you guys doing in there
	allowed_loadouts = list(/datum/outfit/deathmatch_loadout/assistant)
	map_name = "ragecage"
	key = "ragecage"

/datum/lazy_template/deathmatch/shooting_range
	name = "Shooting Range"
	desc = "A simple room with a bunch of wooden barricades."
	max_players = 6
	allowed_loadouts = list(
		/datum/outfit/deathmatch_loadout/operative/ranged,
		/datum/outfit/deathmatch_loadout/operative/melee,
	)
	map_name = "shooting_range"
	key = "shooting_range"

/datum/lazy_template/deathmatch/securing
	name = "SecuRing"
	desc = "Presenting the Security Ring, ever wanted to shoot people with disablers? Well now you can."
	max_players = 4
	allowed_loadouts = list(/datum/outfit/deathmatch_loadout/securing_sec)
	map_name = "secu_ring"
	key = "secu_ring"

/datum/lazy_template/deathmatch/instagib
	name = "Instagib"
	desc = "EVERYONE GETS AN INSTAKILL RIFLE!"
	max_players = 8
	allowed_loadouts = list(/datum/outfit/deathmatch_loadout/assistant/instagib)
	map_name = "instagib"
	key = "instagib"

/datum/lazy_template/deathmatch/mech_madness
	name = "Mech Madness"
	desc = "Do you hate mechs? Yeah? Dont care! Go fight eachother!"
	max_players = 4
	allowed_loadouts = list(/datum/outfit/deathmatch_loadout/operative)
	map_name = "mech_madness"
	key = "mech_madness"

/datum/lazy_template/deathmatch/sniper_elite
	name = "Sniper Elite"
	desc = "Sound of gunfire and screaming people make my day"
	max_players = 8
	allowed_loadouts = list(/datum/outfit/deathmatch_loadout/operative/sniper)
	map_name = "sniper_elite"
	key = "sniper_elite"
