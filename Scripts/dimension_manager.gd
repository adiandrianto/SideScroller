extends Node

@onready var is_inside: bool = true
@onready var is_opening_scene: bool = true
@onready var is_opening_done:= false

signal door_open
signal door_close

signal boss_started
signal player_died
signal boss_defeated

signal opening_cue
signal cutscene_end
signal game_start
signal closing_cue
signal closing_finished
