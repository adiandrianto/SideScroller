extends AudioStreamPlayer

@export var phrase: Array[AudioStream]

func play_random():
	if phrase == null || phrase.size() == 0:
		return
	stream = phrase.pick_random()
	play()
