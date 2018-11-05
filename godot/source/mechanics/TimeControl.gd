class_name TimeControl
extends Node2D

export(float) var slomo_time_scale = 0.25

var _in_slomo = false

func _process(delta):
	if Input.is_action_just_pressed('slomo'):
		if _in_slomo:
			disable_slomo()
		else:
			enable_slomo()
		_in_slomo = not _in_slomo

func enable_slomo():
	Engine.time_scale = slomo_time_scale

func disable_slomo():
	Engine.time_scale = 1

func pause():
	get_tree().paused = true

func unpause():
	get_tree().paused = false