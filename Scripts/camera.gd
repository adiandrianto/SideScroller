extends Camera2D

@export var player: Player
@export var smoothing_enabled: bool
@export_range(1, 10) var smooth_value: int = 8

var y_distance:= 5
var x_distance:= 10

func _physics_process(_delta: float) -> void:
	var weight: float
	var direction = player.direction
	
	if player != null :
		var camera_pos: Vector2
		
		if smoothing_enabled :
			weight = float(11-smooth_value) /100
			camera_pos = lerp(global_position, player.global_position, weight)
		else :
			camera_pos = player.global_position
			
		if direction > 0 :
			global_position = Vector2((camera_pos.x + x_distance), (camera_pos.y - y_distance)).floor()
		else :
			global_position = Vector2((camera_pos.x - x_distance), (camera_pos.y - y_distance)).floor()
