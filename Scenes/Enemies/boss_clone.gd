extends CharacterBody2D

@onready var true_boss: Boss = get_tree().get_first_node_in_group("boss")
@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var animation_player: AnimationPlayer = $AnimationPlayer
const BOSS_BOULDER = preload("res://Scenes/Bullets/boss_boulder.tscn")
@onready var marker_right: Marker2D = $MarkerRight
@onready var marker_left: Marker2D = $MarkerLeft
@onready var sprite: Sprite2D = $Sprite2D

var can_shoot:= true

func _ready() -> void:
	animation_player.play("appear")
	true_boss.alien_health.died.connect(on_boss_death)
	
func on_boss_death():
	queue_free()
	
func _on_health_component_died() -> void:
	animation_player.play("clone_death")
	
func _physics_process(delta: float) -> void:
	if not animation_player.is_playing():
		shoot()
	if global_position < player.global_position:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	if true_boss != null:	
		if true_boss.visible == false:
			animation_player.play("clone_death")
	
func shoot():
	var boulder = BOSS_BOULDER.instantiate()
	var marker: Marker2D
	if not can_shoot:
		return
	else :
		if sprite.flip_h == true:
			boulder.velocity = Vector2.RIGHT
			marker = marker_right
		else:
			boulder.velocity = Vector2.LEFT
			boulder.rotate(deg_to_rad(180))
			marker = marker_left
		
		boulder.position = marker.global_position
		get_tree().root.add_child(boulder)
	
	can_shoot = false
	var t = randf_range(2.0,3.5)
	await get_tree().create_timer(t).timeout #time between shoot
	can_shoot = true
