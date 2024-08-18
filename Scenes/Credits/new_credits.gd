extends Node2D

var section_time = 2.0
var line_time = 0.3
var base_speed = 100
var speed_up_multiplier = 10.0
var title_color = Color.BLUE_VIOLET

var scroll_speed = base_speed
var speed_up = false

@onready var line := $CreditsContainer/Line
var started := false
var finished := false

var section
var section_next := true
var section_timer := 0.0
var line_timer := 0.0
var curr_line := 0
var lines := []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
