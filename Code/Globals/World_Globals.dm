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
	)

	list/mob/player/players_in_world = list()
	list/mob/player/moving_players = list()

mob
	pixel_y = 4

#define TELEPORT_FLAG "teleporting"


mob
	verb
		Test_Maptext(t as text)
			maptext_width = 100
			maptext_height = 100
			maptext = "<font face='PKMN RBYGSC' size='1'>[t]"
