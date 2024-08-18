extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var start: Button = $Start
@onready var credits: Button = $Credits
@onready var exit: Button = $Exit

func _ready() -> void:
	AudioPlayer.play_theme_music()

func _on_start_pressed() -> void:
	visibility()
	AudioPlayer.stop()
	animation_player.play("fade_out")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")


func _on_credits_pressed() -> void:
	visibility()
	animation_player.play("fade_out")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://Scenes/Credits/Credits.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()

func visibility():
	start.visible = false
	credits.visible = false
	exit.visible = false
