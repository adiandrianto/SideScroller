extends Node

var is_inside: bool = false
var is_opening_scene: bool = true
var is_opening_done:bool = false
signal door_open
signal door_close

signal boss_started
signal player_died
signal boss_defeated

signal opening_cue
signal cutscene_end
signal game_start
