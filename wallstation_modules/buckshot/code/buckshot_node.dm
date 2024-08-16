/datum/techweb_node/buckshot
	id = "buckshot"
	display_name = "Shotgun ammunition"
	description = "Buckshot shells and slugs, for use with shotguns."
	prereq_ids = list(TECHWEB_NODE_SYNDICATE_BASIC)
	design_ids = list(
		"buckshot_shell",
		"shotgun_slug",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS / 4)
