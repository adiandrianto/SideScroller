extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayera
@onready var tile_map: TileMap = $"../TileMap"
@onready var second_dimension: TileMapLayer = $"../GroundTile/2ndDimension"
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var player: CharacterBody2D = $"../Player"

func _process(delta: float) -> void:
	if ray_cast_2d.is_colliding():
		print(ray_cast_2d.get_collider())
		if Input.is_action_pressed("up"):
			open()
		if Input.is_action_pressed("down"):
			close()

func open():
	animation_player.play("open")
	await animation_player.animation_finished
	tile_map.visible = false
	second_dimension.collision_enabled = true

func close():
	animation_player.play("close")
	await animation_player.animation_finished
	second_dimension.collision_enabled = false
	tile_map.visible = true
