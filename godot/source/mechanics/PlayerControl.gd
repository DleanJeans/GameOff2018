extends Node2D

export(bool) var enabled = false setget set_enabled

var _player:Animal

func set_player(player:Animal):
	_player = player
	self.enabled = true

func set_enabled(enable):
	enabled = enable
	set_physics_process(enable)

func _physics_process(delta):
	_process_movement()

func _process_movement():
	if Input.is_action_pressed('left'):
		_player.move_left()
	if Input.is_action_pressed('right'):
		_player.move_right()
	if Input.is_action_just_pressed('up'):
		_player.start_jumping()
	if Input.is_action_pressed('up'):
		_player.jump()
	elif Input.is_action_just_released('up'):
		_player.stop_jumping()
	if Input.is_action_just_pressed('down'):
		pass