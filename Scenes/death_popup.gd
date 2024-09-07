extends TextureRect

@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var button: Button = $VBoxContainer/Button
@onready var button_2: Button = $VBoxContainer/Button2
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hover: AudioStreamPlayer2D = $Hover
@onready var click: AudioStreamPlayer2D = $Click
@onready var label: Label = $VBoxContainer/Label
@onready var lost_sfx: AudioStreamPlayer2D = $lostSFX

func _ready() -> void:
	visible = false
	button.disabled = true
	button_2.disabled = true
	DimensionManager.player_died.connect(on_player_died)
	
func _on_button_pressed() -> void:
	click.play()
	await click.finished
	animation_player.play("fade_out")
	label.visible = false
	button.visible = false
	button_2.visible = false
	await animation_player.animation_finished
	player.health_component.current_health = player.health_component.max_health
	PickupManager.emit_signal("player_health_changed")
	get_tree().paused = false
	visible = false
	button.disabled = true
	button_2.disabled = true


func _on_button_2_pressed() -> void:
	click.play()
	await click.finished
	label.visible = false
	button.visible = false
	button_2.visible = false
	get_tree().quit()

func on_player_died():
	lost_sfx.play()
	animation_player.play("fade_in")
	visible = true
	label.visible = true
	button.visible = true
	button_2.visible = true
	button.disabled = false
	button_2.disabled = false

func _on_button_mouse_entered() -> void:
	hover.play()
	await hover.finished

func _on_button_2_mouse_entered() -> void:
	hover.play()
	await hover.finished
