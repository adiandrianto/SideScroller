extends Sprite2D
class_name ButtonCorridor

@export var interaction_area: Area2D
@onready var label: Label = $Label
@export var gate: StaticBody2D

var can_open = true
func _ready():
	label.visible = false
	
func _process(delta: float) -> void:
	if Input.is_action_just_released("interact") && can_open && label.visible:
		open()
		frame = 1
		
func open():
	gate.open()
	can_open = false
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		label.visible = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		label.visible = false
