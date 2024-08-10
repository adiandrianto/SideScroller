extends Area2D
class_name PickUp

@onready var player: CharacterBody2D
@export var animation_player: AnimationPlayer
@export var audio_stream_player: AudioStreamPlayer
@export var pickup_path: String
@export var pickup_type: String

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	player = get_tree().get_first_node_in_group("player")
	animation_player.play("idle")
	
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		animation_player.play("pick_up")
		audio_stream_player.play()
		if pickup_type == "weapon":
			PickupManager.change_weapon(pickup_path)
		elif pickup_type == "heart":
			PickupManager.add_heart()
		elif pickup_type == "grenade":
			PickupManager.emit_signal("grenade_acquired")
			PickupManager.add_grenade()
