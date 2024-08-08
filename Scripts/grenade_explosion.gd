extends Node2D

signal exploded

func _ready() -> void:
	$AnimatedSprite2D.play("explode")


func _on_animated_sprite_2d_animation_finished() -> void:
	$AnimatedSprite2D.stop()
	emit_signal("exploded")
