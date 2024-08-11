extends Area2D
class_name PickUp

@onready var player: Player
@export var animation_player: AnimationPlayer
@export var audio_stream_player: AudioStreamPlayer
@export var pickup_path: String
@export var pickup_type: String
@export var is_inside : bool

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	player = get_tree().get_first_node_in_group("player")
	animation_player.play("idle")
	
func _process(delta: float) -> void:
	if is_inside && DimensionManager.is_inside:
		can_be_seen()
	elif is_inside && not DimensionManager.is_inside:
		invincible()
	elif not is_inside && DimensionManager.is_inside:
		invincible()
	else :
		can_be_seen()
		
func invincible():
	visible = false
	monitoring = false
	
func can_be_seen():
	visible = true
	monitoring = true
	
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		animation_player.play("pick_up")
		audio_stream_player.play()
		if pickup_type == "weapon":
			PickupManager.change_weapon(pickup_path)
		elif pickup_type == "heart":
			print("heart picked")
			PickupManager.add_health.emit()
		elif pickup_type == "grenade":
			print("grenade picked")
			PickupManager.add_grenade.emit()
