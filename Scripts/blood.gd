extends Area2D

var is_colliding = false
var vspeed = randi_range(-5,5)
var hspeed = randi_range(-3,3)
var blood_acc = randf_range(0.05,0.1)
var do_wobble = false
var max_count = randi_range(5,50)
var count = 0

func _physics_process(delta: float) -> void:
	if(!is_colliding): # in the air
		do_wobble = false
		vspeed = lerp(vspeed,5,0.02)
		hspeed = lerp(hspeed,0,0.02)
		visible = true
	
	#we add random wobble when moving downwards to avoid str8 lines
	if(do_wobble):
		hspeed += randf_range(-0.01,0.01)
		hspeed = clamp(hspeed,-0.1,0.1)
		
	#update our position based on the vspeed and hspeed
	position.y += vspeed
	position.x += hspeed
	
	#delete this object if it left the screen downwards
	if(position.y > 1000):
		queue_free()
