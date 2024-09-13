extends State

func state_enter():
	DimensionManager.boss_started.connect(on_boss_started)

func state_physics_update(delta):
	pass
	
func state_exit():
	pass
	
func on_boss_started():
	transitioned.emit(self, "wait")
