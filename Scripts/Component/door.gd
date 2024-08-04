extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var tile_map: TileMap = $"../TileMap"
@onready var second_dimension: TileMapLayer = $"../GroundTile/2ndDimension"
@onready var ray_cast_2d: RayCast2D = $RayCast2D

func _process(delta: float) -> void:
	if ray_cast_2d.collide_with_areas:
		print(ray_cast_2d.get_collider())
		
func open():
	animation_player.play("open")
	await animation_player.animation_finished
	tile_map.visible = false
	second_dimension.collision_enabled = true
	
