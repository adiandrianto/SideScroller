extends Area2D

@export var pickup_path: String
@export var is_inside : bool
@export var animation_player: AnimationPlayer
@onready var player: Player
@onready var sprite: Sprite2D = $Sprite2D
@onready var label: Label = $Label

var can_open := true

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	label.visible = false
	
func _process(delta: float) -> void:
	if is_inside && DimensionManager.is_inside:
		can_be_seen()
	elif is_inside && not DimensionManager.is_inside:
		invincible()
	elif not is_inside && DimensionManager.is_inside:
		invincible()
	else :
		can_be_seen()
		
	if Input.is_action_pressed("interact") && can_open && label.visible == true :
			sprite.frame = 1
			PickupManager.change_weapon(pickup_path)
			DimensionManager.emit_signal("game_start")
			can_open =  false
			animation_player.play("opening_3")
		
func invincible():
	visible = false
	monitoring = false
	
func can_be_seen():
	visible = true
	monitoring = true
	
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player") && DimensionManager.is_opening_done == true:
		label.visible = true

func _on_area_exited(area: Area2D) -> void:
	label.visible = false
