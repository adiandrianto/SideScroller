extends TextureRect

func _ready() -> void:
	visible = false
	DimensionManager.boss_defeated.connect(on_boss_defeated)
	
func on_boss_defeated():
	visible = true
