extends State

@onready var animation_player = $"../../AnimationPlayer"
@onready var bullet_scene = preload("res://Scenes/Bullets/enemy_laser_bullet.tscn")
@export var enemy :CharacterBody2D
@onready var sprite: Sprite2D = $"../../Sprite2D"
@onready var marker_left: Marker2D = $"../../MarkerLeft"
@onready var marker_right: Marker2D = $"../../MarkerRight"
@onready var ray_cast: RayCast2D = $"../../RayCast2D"

var direction := Vector2.ZERO
var player: CharacterBody2D
var can_shoot = true
const SPEED := 50

func state_enter():
	player = get_tree().get_first_node_in_group("player")

func state_physics_update(delta):
	enemy.velocity = lerp(enemy.velocity, Vector2.ZERO,0.1)
	if DimensionManager.is_inside ==false && owner.is_inside == false:
		shoot()
	elif DimensionManager.is_inside == true && owner.is_inside == true:
		shoot()
	else :
		return
		
	var distance = enemy.global_position - player.global_position
	if distance.length() < 100 && not ray_cast.is_colliding():
		transitioned.emit(self, "moveaway")
	if distance.x > 0 :
		sprite.flip_h = false
	else :
		sprite.flip_h = true
	
	if distance.length() > 450 :
		transitioned.emit(self, "idle")


func shoot():
	var bullet = bullet_scene.instantiate()
	var marker: Marker2D
	if not can_shoot:
		return
	else :
		if sprite.flip_h == true:
			bullet.velocity = Vector2.LEFT
			bullet.rotation = deg_to_rad(180)
			marker = marker_right
		else:
			bullet.velocity = Vector2.RIGHT
			marker = marker_left
		
		bullet.position = marker.global_position
		bullet.velocity = bullet.global_position.direction_to(player.global_position)
		get_tree().root.add_child(bullet)
	
	can_shoot = false
	await get_tree().create_timer(2).timeout #time between shoot
	can_shoot = true
	
func state_exit():
	pass
