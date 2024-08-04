extends CharacterBody2D

const SPEED := 40
var direction = 1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var health_component: HealthComponent = $HealthComponent
@onready var hurt_box_component: HurtBoxComponent = $HurtBoxComponent
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


@onready var ray_cast_2d_bottom_right = $RayCast2D_bottom_right
@onready var ray_cast_2d_bottom_left = $RayCast2D_bottom_left


enum CurrentState {
	IDLE,
	ATTACK,
	HURT,
	DEAD
}

var state : CurrentState = CurrentState.IDLE

func _ready() -> void:
	hurt_box_component.being_hit.connect(on_being_hit)
	health_component.died.connect(on_died)

func _process(delta: float) -> void:
	match state:
		CurrentState.IDLE:
			idle_state(delta)
		CurrentState.ATTACK:
			attack_state(delta)
		CurrentState.HURT:
			hurt_state(delta)
		CurrentState.DEAD:
			dead_state(delta)

func idle_state(delta: float) -> void:
	#if (!ray_cast_2d_bottom_right.is_colliding()):
		#direction = -1
		#sprite.flip_h = true
	#if(!ray_cast_2d_bottom_left.is_colliding()):
		#direction = 1
		#sprite.flip_h = false
	position.x = direction * SPEED * delta

func attack_state(delta: float) -> void:
	var direction_to_player = get_direction_to_player()
	velocity = Vector2(direction_to_player.x, 0) * SPEED
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()

func hurt_state(delta: float) -> void:
	# Implement hurt behavior here
	pass

func dead_state(delta: float) -> void:
	velocity = Vector2.ZERO
	queue_free()

func get_direction_to_player():
	var player_node = get_tree().get_first_node_in_group("player")
	if player_node != null :
		return (player_node.global_position - global_position).normalized()
	return Vector2.ZERO
	
func on_being_hit():
	state = CurrentState.HURT

func on_died():
	state = CurrentState.DEAD
	
func _on_player_detector_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		state = CurrentState.ATTACK
