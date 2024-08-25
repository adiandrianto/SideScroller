extends CharacterBody2D

@onready var player : Player = get_tree().get_first_node_in_group("player")
@onready var sprite: AnimatedSprite2D = $Sprite2D

func _ready() -> void:
	DimensionManager.boss_defeated.connect(on_boss_defeated)
	set_physics_process(false)
	
func _physics_process(delta: float) -> void:
	var player_pos = player.global_position
	var speed = 100
	var direction = (player.global_position - global_position).normalized()
	var distance = global_position.distance_to(player.global_position)
	velocity = speed * Vector2(direction.x,0)
	if direction.x > 0:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
		
	if velocity.length() > 10:
		sprite.play("walk")
	else :
		sprite.play("idle")
		set_physics_process(false)
		await get_tree().create_timer(1).timeout
		set_physics_process(true)
		
	move_and_slide()
	
func on_boss_defeated():
	set_physics_process(true)
