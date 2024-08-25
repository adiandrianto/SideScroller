extends State

@onready var animated_sprite: AnimatedSprite2D = $"../../AnimatedSprite2D"

func state_enter():
	if owner.weapon != null:
		animated_sprite.play("idle")
	elif owner.weapon == null:
		animated_sprite.play("idle_with_arm")
	DimensionManager.cutscene_end.connect(on_cutscene_end)
	owner.set_physics_process(false)
	
func on_cutscene_end():
	transitioned.emit(self, "Idle")

func state_physics_update(delta):
	owner.velocity.x = move_toward(owner.velocity.x, 0, 500)
	owner.move_and_slide()
	owner.set_physics_process(true)
