extends StaticBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	DimensionManager.boss_defeated.connect(on_boss_defeated)
	
func open():
	animated_sprite.play("open")
	
func on_boss_defeated():
	open()
	
func _on_animated_sprite_2d_animation_finished() -> void:
	collision.disabled = true
