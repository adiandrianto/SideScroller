extends Node2D
class_name Door

@export var interaction_area: Area2D
@export var animation_player: AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer
@export var tile_map: TileMap
@export var second_dimension: TileMapLayer
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var enemyA : CharacterBody2D = get_tree().get_first_node_in_group("enemy")
@onready var label: Label = $Label

var can_open = true

func _ready() -> void:
	label.visible = false
	second_dimension.collision_enabled = false
	tile_map.visible = true

func _process(delta: float) -> void:
	if Input.is_action_just_released("interact") && can_open && label.visible:
		DimensionManager.is_inside = true
		DimensionManager.emit_signal("door_open")
		open()
		
	if Input.is_action_pressed("interact") && not can_open && label.visible:
		DimensionManager.is_inside = false
		DimensionManager.emit_signal("door_close") 
		DimensionManager.emit_signal("opening_cue")
		DimensionManager.is_opening_scene = false
		close()
		

func open():
	animation_player.play("open")
	await animation_player.animation_finished
	tile_map.visible = false
	second_dimension.collision_enabled = true
	can_open = false

func close():
	animation_player.play("close")
	await animation_player.animation_finished
	second_dimension.collision_enabled = false
	tile_map.visible = true
	can_open = true
	
func _on_interaction_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		label.visible = true

func _on_interaction_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		label.visible = false
