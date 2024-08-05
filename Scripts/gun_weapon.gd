extends Node2D
class_name Weapon

@export var sprite: Sprite2D
@export var marker_left: Marker2D
@export var marker_right: Marker2D
@export var marker_up: Marker2D
@export var bullet_scene: PackedScene
@export var shoot_delay : float

var can_shoot = true

func flip_left():
	sprite.flip_h = true
	
func flip_right():
	sprite.flip_h = false
	
func shoot():
	var bullet = bullet_scene.instantiate()
	var marker: Marker2D
	if not can_shoot:
		return
	else :
		if sprite.flip_h == true:
			bullet.velocity = Vector2.LEFT
			bullet.rotation = deg_to_rad(180)
			marker = marker_left
		else:
			bullet.velocity = Vector2.RIGHT
			marker = marker_right
		if Input.is_action_pressed("up"):
			bullet.velocity = Vector2.UP
			bullet.rotation = deg_to_rad(-90)
			marker = marker_up
		
		bullet.position = marker.global_position
		get_tree().root.add_child(bullet)
	
	can_shoot = false
	await get_tree().create_timer(shoot_delay).timeout #time between shoot
	can_shoot = true
	
