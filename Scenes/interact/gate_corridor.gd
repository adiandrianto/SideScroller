extends StaticBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

func open():
	animated_sprite.play("open")
	

func _on_animated_sprite_2d_animation_finished() -> void:
	collision.disabled = true
