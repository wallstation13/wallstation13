/datum/design/shotgun_slug
	name = "Shotgun Slug (Lethal)"
	id = "shotgun_slug"
	build_type =  PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 2 * SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/ammo_casing/shotgun
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/buckshot_shell
	name = "Buckshot Shell (Lethal)"
	id = "buckshot_shell"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 2 * SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/ammo_casing/shotgun/buckshot
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
