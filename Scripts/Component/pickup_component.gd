extends Area2D
class_name PickUp

@onready var player: CharacterBody2D
@export var animation_player: AnimationPlayer
@export var audio_stream_player: AudioStreamPlayer
@export var pickup_path: String

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	animation_player.play("idle")
	
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		animation_player.play("pick_up")
		audio_stream_player.play()
		PickupManager.change_weapon(pickup_path)
		print("machine gun acquired")
