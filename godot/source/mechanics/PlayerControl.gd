extends Node2D

export(bool) var enabled = false setget set_enabled

var _player:Animal

var _holding_before_start = false

func set_player(player:Animal):
	_player = player
	self.enabled = true

func set_enabled(enable):
	enabled = enable
	set_physics_process(enable)

func _physics_process(delta):
	_process_movement()

func _process_movement():
	if Input.is_action_just_released('left'):
		_holding_before_start = false
	if Input.is_action_just_released('right'):
		_holding_before_start = false
	
	if _holding_before_start:
		return
	
	if Input.is_action_pressed('left'):
		if get_tree().paused:
			_holding_before_start = true
		else:
			_player.move_left()
	if Input.is_action_pressed('right'):
		if get_tree().paused:
			_holding_before_start = true
		else:
			_player.move_right()
		
	if Input.is_action_just_pressed('up'):
		_player.start_jumping()
	elif Input.is_action_just_released('up'):
		_player.stop_jumping()
	
	if Input.is_action_just_pressed('down'):
		pass