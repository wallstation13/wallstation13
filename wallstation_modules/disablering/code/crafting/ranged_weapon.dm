// ORIGINAL FILE: code/modules/components/crafting/ranged_weapon.dm
/datum/crafting_recipe/disabler_rifle
	name = "Disabler Rifle"
	result = /obj/item/gun/energy/disabler/rifle
	reqs = list(
		/obj/item/gun/energy/disabler = 1,
		/obj/item/weaponcrafting/gunkit/disabler_rifle = 1,
	)
	time = 10 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/disabler_smg
	name = "Disabler SMG"
	result = /obj/item/gun/energy/disabler/smg
	reqs = list(
		/obj/item/gun/energy/disabler = 1,
		/obj/item/weaponcrafting/gunkit/disabler_smg = 1,
	)
	time = 10 SECONDS
	category = CAT_WEAPON_RANGED
