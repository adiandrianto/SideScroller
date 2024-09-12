extends TextureRect
@onready var label: Label = $Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var credits = preload("res://Scenes/Credits/Boss_Credits.tscn")

func _ready() -> void:
	visible = false
	DimensionManager.boss_defeated.connect(on_boss_defeated)
	
func on_boss_defeated():
	visible = true
	animation_player.play("fade_in")
	await animation_player.animation_finished
	await get_tree().create_timer(5.0).timeout
	animation_player.play("fade_out")
	await  animation_player.animation_finished
	visible = false
	var activate = credits.instantiate()
	activate.global_position = label.global_position
	get_parent().add_child(activate)
