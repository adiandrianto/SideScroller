extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var firstdoor: Door = $"------- Ladder & Door -------/Door3"
@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var closing_cue: Area2D = $"------- Cutscene -------/ClosingCue"
@onready var button: Button = $UI/Button

func _ready() -> void:
	PickupManager.update_player()
	button.pressed.connect(on_button_pressed)
	DimensionManager.is_opening_done = true
	DimensionManager.emit_signal("cutscene_end")
	DimensionManager.is_inside = false

func on_button_pressed():
	if not animation_player.is_playing():
		animation_player.play()
		button.visible = false
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("next") && not animation_player.is_playing():
		animation_player.play()
		button.visible = false

func pause():
	animation_player.pause()
	button.visible = true
	
func end_cutscene():
	DimensionManager.emit_signal("cutscene_end")
	
func _on_closing_cue_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		DimensionManager.emit_signal("closing_cue")
		animation_player.play("closing")
		closing_cue.call_deferred("queue_free")
