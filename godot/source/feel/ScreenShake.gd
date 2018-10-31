extends Node2D

export(NodePath) var camera_path
export(float) var strength = 50
export(float) var duration = 0.5

onready var camera:Camera2D = get_node(camera_path)
onready var half_duration = duration * 0.5

func shake_to(direction:Vector2, multiplier = 1):
	if not camera:
		return
	var shake_offset = direction * strength * multiplier
	
	$Tween.stop_all()
	$Tween.interpolate_property(camera, 'offset', Vector2(), shake_offset, half_duration, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Tween.interpolate_property(camera, 'offset', shake_offset, Vector2(), half_duration, Tween.TRANS_CUBIC, Tween.EASE_IN, half_duration)
	$Tween.start()