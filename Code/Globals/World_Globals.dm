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
	list/mob/player/players_in_world = list()
	list/mob/player/moving_players = list()

mob
	pixel_y = 4

#define TELEPORT_FLAG "teleporting"