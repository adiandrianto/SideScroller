extends Camera2D

@onready var player: Player = get_tree().get_first_node_in_group("player")
@export var smoothing_enabled: bool
@export_range(1, 10) var smooth_value: int
@export var marker_left: Marker2D
@export var marker_right: Marker2D

var y_distance:= 5
var x_distance:= 10

func _physics_process(_delta: float) -> void:
	var weight: float
	var direction = player.direction
	
	if player != null :
		var camera_pos = player.global_position
		var left_border:= marker_left.global_position.x
		var right_border:= marker_right.global_position.x
		
		if player.global_position.x > right_border:
			global_position = Vector2((camera_pos.x + x_distance), (camera_pos.y - y_distance)).floor()
		elif player.global_position.x < left_border:
			global_position = Vector2((camera_pos.x - x_distance), (camera_pos.y - y_distance)).floor()
		#if smoothing_enabled :
			#weight = float(11-smooth_value) /10
			#camera_pos = lerp(global_position, player.global_position, weight)
		#else :
			#camera_pos = player.global_position
	
