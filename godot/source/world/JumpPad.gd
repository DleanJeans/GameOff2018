class_name JumpPad
extends Area2D

var top:Vector2 setget , get_top

func get_top():
	var half_height = 50 * scale.y
	var half_width = 50 * scale.x
	var random_x = rand_range(-half_width, half_width) * 0.75
	return position + Vector2(random_x, -half_height)