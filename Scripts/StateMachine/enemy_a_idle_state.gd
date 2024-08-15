extends State

@onready var animation_player = $"../../AnimationPlayer"
@export var enemy :CharacterBody2D
@onready var detection_area: Area2D = $"../../DetectionArea"
@onready var sprite: Sprite2D = $"../../Sprite2D"

var direction := Vector2.LEFT
var player: CharacterBody2D
const SPEED := 50


func state_enter():
	#animation_player.play("idle")
	player = get_tree().get_first_node_in_group("player")
	
	if sprite.flip_h == true:
		detection_area.scale *= -1

func state_physics_update(delta):
	
	enemy.velocity = lerp(enemy.velocity, Vector2.ZERO,0.1)
	enemy.move_and_slide()
	
func state_exit():
	pass

func _on_detection_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		transitioned.emit(self, "attack")

func _on_health_component_health_changed() -> void:
	transitioned.emit(self, "attack")
