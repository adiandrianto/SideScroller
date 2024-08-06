extends State

@onready var sprite: Sprite2D = $"../../Sprite2D"
@onready var animation_player = $"../../AnimationPlayer"
@export var enemy :CharacterBody2D
@onready var ray_cast_2d: RayCast2D = $"../../RayCast2D"

var direction := Vector2.LEFT
var player: CharacterBody2D
const SPEED := 4600

func state_enter():
	player = get_tree().get_first_node_in_group("player")
	animation_player.play("move")

func state_physics_update(delta):
	var away_from_player_direction = Vector2(((enemy.global_position - player.global_position).normalized().x),0)
	var distance = enemy.global_position - player.global_position
	enemy.velocity = away_from_player_direction * SPEED * delta
	if player.global_position.x - enemy.global_position.x < 0 :
		ray_cast_2d.scale = Vector2(1,1)
		sprite.flip_h = true
	else :
		sprite.flip_h = false
		ray_cast_2d.scale = Vector2(-1,-1)
	
	if ray_cast_2d.is_colliding():
		print(ray_cast_2d.get_collider())
		if ray_cast_2d.get_collider().get_parent() is GroundTile :
			print("asoidhd")
			transitioned.emit(self, "attack")
	
	if distance.length() > 175 && enemy.is_on_floor():
		transitioned.emit(self, "attack")
	if not enemy.is_on_floor():
		transitioned.emit(self, "idle")
		
func state_exit():
	animation_player.stop(false)
