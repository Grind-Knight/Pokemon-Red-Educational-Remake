/* 
This file should contain all global #define's for things so that the rest of your code has access. 
*/

world
	fps = 20
	icon_size = 16
	view = 6

	mob = /mob/player

client
	fps = 60

var
	list/extra_resources = list(\
	'PKMN_RBYGSC.ttf'
	//'PokemonGb-RAeo.ttf'
	)

	list/mob/player/players_in_world = list()
	list/mob/player/moving_players = list()

mob
	pixel_y = 4	// Pokemon Red offsets all mobs by 4 pixels.

var
	const
		//MOB VARS
		INVENTORY_SIZE_LIMIT = 20

		//MOB FLAGS
		TELEPORT_FLAG = "teleporting"

		//CLIENT STATES
		IN_GAME = "in_game"
		IN_MENU = "in_menu"

		//LAYERS
		HUD_LAYER = 100
		MENU_LAYER = 101
		BUTTON_LAYER = 102
		CURSOR_LAYER = 103

