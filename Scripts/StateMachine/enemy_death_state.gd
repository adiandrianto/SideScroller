extends State
class_name EnemyDeath

@onready var animation_player = $"../../AnimationPlayer"
@export var enemy :CharacterBody2D
var player:CharacterBody2D

func state_enter():
	animation_player.play("death")
		
