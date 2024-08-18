extends State

@onready var animated_sprite: AnimatedSprite2D = $"../../AnimatedSprite2D"

func state_enter():
	animated_sprite.play("idle_with_arm")
	DimensionManager.cutscene_end.connect(on_cutscene_end)
	
func on_cutscene_end():
	transitioned.emit(self, "Idle")
