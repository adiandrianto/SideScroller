extends State

@export var slow_down_speed := 500
@onready var animated_sprite: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var weapon = $MachineGun
@onready var can_shoot_weapon := true 

var direction := Vector2.LEFT
const SPEED := 50

func state_enter():
	animated_sprite.play("idle")
		
func state_process(delta):
	pass
	#if Input.is_action_just_pressed("jump"):
		#transitioned.emit(self, "Jump")
#
	#if Input.is_action_pressed("right") or Input.is_action_pressed("left"):
		#transitioned.emit(self, "Run")
		
func state_physics_update(delta):
	owner.velocity.x = move_toward(owner.velocity.x, 0, slow_down_speed)
	owner.move_and_slide()
	var direction = Input.get_axis("left", "right")
	if direction && owner.is_on_floor():
		transitioned.emit(self, "run")
	if not owner.is_on_floor():
		transitioned.emit(self, "fall")
	if Input.is_action_just_pressed("jump"):
		transitioned.emit(self, "jump")
	
func state_exit():
	animated_sprite.stop()
