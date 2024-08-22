extends CharacterBody2D
class_name FlyingEnemy

@onready var sprite = $Sprite2D
@onready var hurt_box_component = $HurtBoxComponent
@onready var hit_box_component = $HitBoxComponent
@onready var state_label = $StateLabel
@onready var health_component = $HealthComponent
@onready var animation_player = $AnimationPlayer
@onready var state_machine = $StateMachine
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var is_inside := false

func _process(delta):
	state_label.text = state_machine.current_state.name
	if is_inside && DimensionManager.is_inside:
		can_be_seen()
	elif is_inside && not DimensionManager.is_inside:
		invincible()
	elif not is_inside && DimensionManager.is_inside:
		invincible()
	else :
		can_be_seen()
		
func invincible():
	visible = false
	hurt_box_component.monitorable = false
	hurt_box_component.monitoring = false
	
func can_be_seen():
	visible = true
	hurt_box_component.monitorable = true
	hurt_box_component.monitoring = true
	
func _physics_process(delta):
	move_and_slide()

func _on_health_component_died():
	audio_stream_player.play()
	animation_player.play("death")
