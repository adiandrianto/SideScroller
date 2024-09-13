extends Node2D

@onready var collision: CollisionShape2D = $HitBoxComponent/CollisionShape2D
@onready var particles: GPUParticles2D = $GPUParticles2D
@onready var timer: Timer = $Timer
@onready var player: Player = get_tree().get_first_node_in_group("player")

@export var first_sec: float
func _ready() -> void:
	timer.start(first_sec)
	
func toggle_emission():
	particles.emitting = !particles.emitting
	
func _physics_process(delta: float) -> void:
	if not particles.emitting :
		collision.disabled = true
	else :
		collision.disabled = false
		
func _on_timer_timeout() -> void:
	toggle_emission()
	timer.start(2)
	
