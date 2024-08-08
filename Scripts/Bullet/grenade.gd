extends RigidBody2D

@onready var explode = preload("res://Scenes/Weapons/grenade_explosion.tscn")
var expl
var strength = 0
var direction = false

func init(d = 0):
	direction = d

func throw(imp_vec):
	strength = imp_vec
	if direction:
		strength.x *= -1
	apply_impulse(Vector2.ZERO, strength)


func _on_timer_timeout() -> void:
	explode_grenade()

func explode_grenade():
	$Timer.stop()
	sleeping = true
	expl = explode.instantiate()
	$AnimatedSprite2D.visible = false
	add_child(expl)
	expl.connect("exploded", grenade_exploded)

func grenade_exploded():
	queue_free()
