extends AudioStreamPlayer

var last_pitch = 1.0

func custom_play(from_position=0.0):
	print("CUSTOM CALLED")
	
	randomize()
	pitch_scale = randf_range(0.8, 1.2)
	
	while abs(pitch_scale - last_pitch) < .1:
		randomize()
		pitch_scale = randf_range(0.8, 1.2)
	
	last_pitch = pitch_scale
	
	play(0.0)
	
