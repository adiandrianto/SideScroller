extends Area2D
class_name HurtBoxComponent

signal being_hit
@export var health_component: Node

func _ready():
	area_entered.connect(on_area_entered)
	
func on_area_entered(other_area: Area2D):
	being_hit.emit()
	if not other_area is HitBoxComponent:
		return
	if health_component == null :
		return
	
	var hitbox_component = other_area as HitBoxComponent
	health_component.damaged(hitbox_component.dmg_point)
	print("being hit")
