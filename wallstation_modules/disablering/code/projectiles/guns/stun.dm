// ORIGINAL FILE: code/modules/projectiles/guns/energy/stun.dm
/obj/item/gun/energy/disabler
	icon = 'wallstation_modules/disablering/icons/energy.dmi'

// New SMG with undebarrel grenade launcher
/obj/item/gun/energy/disabler/smg
	desc_controls = "Right-click to use underbarrel grenade launcher."
	/// Our underbarrel grenade launcher
	var/obj/item/gun/grenadelauncher/underbarrel

/obj/item/gun/energy/disabler/smg/Initialize(mapload)
	. = ..()
	underbarrel = new /obj/item/gun/grenadelauncher(src)

/obj/item/gun/energy/disabler/smg/examine(mob/user)
	. = ..()
	. += span_notice("Its undebarrel grenade launcher has [underbarrel.grenades.len] / [underbarrel.max_grenades] grenades loaded.")

/obj/item/gun/energy/disabler/add_seclight_point()
	return // Underbarrel grenade launcher takes the space of seclight, and it would be too wacky to put on top of barrel

// Mercilessly ripped from M90 code
/obj/item/gun/energy/disabler/smg/try_fire_gun(atom/target, mob/living/user, params)
	if(LAZYACCESS(params2list(params), RIGHT_CLICK))
		return underbarrel.try_fire_gun(target, user, params)
	return ..()

/obj/item/gun/energy/disabler/smg/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(isgrenade(tool))
		underbarrel.attack_self(user)
		underbarrel.attackby(tool, user, list2params(modifiers))
	return ..()

// Disabler rifle with a scope
/obj/item/gun/energy/disabler/rifle
	name = "disabler rifle"
	desc = "An bulky disabler rifle designed for long range non-lethal takedowns, packing quite a punch but taking long-time to recharge."
	icon = 'wallstation_modules/disablering/icons/wide_guns.dmi'
	worn_icon = 'wallstation_modules/disablering/icons/back.dmi'
	righthand_file = 'wallstation_modules/disablering/icons/guns_righthand.dmi'
	lefthand_file = 'wallstation_modules/disablering/icons/guns_lefthand.dmi'
	icon_state = "disabler_rifle"
	worn_icon_state = "disabler_rifle"
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/rifle)
	w_class = WEIGHT_CLASS_HUGE
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_BACK
	shaded_charge = 1
	fire_delay = 30
	pb_knockback = 1 // It beam is powerful enough to knockdown for a second, so it makes sense to knock you back a tile Point Blank

	SET_BASE_PIXEL(-8, 0)

/obj/item/gun/energy/disabler/rifle/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 1.5) // https://www.youtube.com/watch?v=innJxQM_-CE
