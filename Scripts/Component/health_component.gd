extends Node
class_name HealthComponent

@export var max_health: int
@export var current_health: int

signal died
signal health_changed

func _ready():
	current_health = max_health
	
func damaged(dmg: int):
	current_health = max(current_health - dmg, 0)
	health_changed.emit()
	Callable(check_death).call_deferred()
	
func get_health_percent():
	if max_health <= 0:
		return
	
	return current_health/max_health
	
func check_death():
	if current_health == 0:
		died.emit()
