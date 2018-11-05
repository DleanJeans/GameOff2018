extends Node2D

export(float) var gravity = 5000
export(float) var damping = 0.1
export(float) var time_to_max_speed = 0.25
export(float) var time_to_jump_apex = 0.35

onready var parent = get_parent()
onready var kind = parent.kind

var velocity = Vector2()
var jumping = false
var moving_x = false
var pressed_jump = false
var was_on_floor = false

func can_jump():
	return $GroundDetector.get_overlapping_bodies().size() > 0

func start_jumping():
	if parent.has_meta('frozen'): return
	
	if parent.is_on_floor() or $OnFloorTimer.time_left > 0:
		if velocity.y >= 0:
			velocity.y = -kind.jump_speed
		jumping = true
		$JumpTimer.start(time_to_jump_apex)
		parent.emit_signal('jumped')
	elif can_jump():
		pressed_jump = true

func stop_jumping():
	jumping = false

func get_speed_x():
	var speed =  kind.land_speed if parent.is_on_floor() else kind.air_speed
	speed *= parent.get_physics_process_delta_time() / time_to_max_speed
	return speed

func _move_x(speed:float):
	if sign(velocity.x) == -sign(speed):
		speed *= 2
	velocity.x += speed
	moving_x = true

func move_left():
	_move_x(-get_speed_x())

func move_right():
	_move_x(get_speed_x())

func _physics_process(delta):
	_clamp_velocity_x()
	
	$VelocityLabel.text = str(velocity.round())
	_apply_velocity()
	_apply_damping_if_on_ground()
	_apply_gravity_if_airborne()
	_jump_when_on_floor_if_pressed_jump()
	
	moving_x = false
	
	if parent.position.x < 0:
		parent.position.x = 1600
	elif parent.position.x > 1600:
		parent.position.x = 0
	
	if not parent.is_on_floor() and was_on_floor:
		$OnFloorTimer.start()
	elif not was_on_floor and parent.is_on_floor():
		velocity.y = 0
	
	was_on_floor = parent.is_on_floor()

func _clamp_velocity_x():
	var max_speed = parent.get_max_speed()
	velocity.x = clamp(velocity.x, -max_speed, max_speed)

func _apply_jump_if_pressed():
	if jumping:
		velocity.y = -kind.jump_speed

func _apply_velocity():
	parent.move_and_slide(velocity, Direction.UP)

func _apply_damping_if_on_ground():
	if parent.is_on_floor() and not moving_x and not pressed_jump:
		velocity.x *= 1 - damping

func _apply_gravity_if_airborne():
	if not jumping and not parent.is_on_floor():
		velocity.y += gravity * parent.get_physics_process_delta_time()

func _jump_when_on_floor_if_pressed_jump():
	if parent.is_on_floor() and pressed_jump:
		start_jumping()
		pressed_jump = false

func _on_JumpTimer_timeout():
	jumping = false