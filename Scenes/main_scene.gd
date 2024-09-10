extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var firstdoor: Door = $"------- Ladder & Door -------/Door3"
@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var closing_cue: Area2D = $"------- Cutscene -------/ClosingCue"
@onready var button: Button = $UI/Button
@onready var is_paused: bool = false
@onready var textsound: AudioStreamPlayer = $"------- Cutscene -------/textsound"
@onready var rich_text_label: RichTextLabel = $UI/PanelContainer/RichTextLabel
@onready var sfx_timer: Timer = $"------- Cutscene -------/Timer"

func _ready() -> void:
	button.pressed.connect(on_button_pressed)
	DimensionManager.is_inside = true
	firstdoor.open()
	DimensionManager.opening_cue.connect(on_opening_cue)
	animation_player.play("opening_1")
	player.on_closing()

func on_button_pressed():
	if not animation_player.is_playing():
		animation_player.play()
		button.visible = false
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("next") && is_paused:
		animation_player.play()
		button.visible = false
		is_paused = false

func pause():
	is_paused = true
	animation_player.pause()
	button.visible = true
	
func end_cutscene():
	DimensionManager.emit_signal("cutscene_end")
	
func on_opening_cue():
	if DimensionManager.is_opening_scene == true:
		animation_player.play("opening_2")
		
func opening_2_finished():
	DimensionManager.is_opening_done = true
	
func _on_closing_cue_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		DimensionManager.emit_signal("closing_cue")
		animation_player.play("closing")
		closing_cue.call_deferred("queue_free")

func timer_start():
	sfx_timer.start()
	
func timer_stop():
	sfx_timer.stop()
	
func _on_timer_timeout() -> void:
	var sfx = textsound.duplicate()

	sfx.pitch_scale = randf_range(0.8, 1.2)
	get_tree().root.add_child(sfx)
	sfx.play()
	await sfx.finished
	sfx.queue_free()
