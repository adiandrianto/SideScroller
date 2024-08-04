extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayera
@onready var tile_map: TileMap = $"../TileMap"
@onready var second_dimension: TileMapLayer = $"../GroundTile/2ndDimension"
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var player: CharacterBody2D = $"../Player"
var can_open = true
var can_close = false

func _process(delta: float) -> void:
	if ray_cast_2d.is_colliding():
		if Input.is_action_pressed("up") && can_open:
			open()
		if Input.is_action_pressed("down") && can_close:
			close()

func open():
	animation_player.play("open")
	await animation_player.animation_finished
	tile_map.visible = false
	second_dimension.collision_enabled = true
	can_close = true
	can_open = false

func close():
	animation_player.play("close")
	await animation_player.animation_finished
	second_dimension.collision_enabled = false
	tile_map.visible = true
	can_close = false
	can_open = true
