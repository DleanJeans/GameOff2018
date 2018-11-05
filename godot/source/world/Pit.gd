tool
extends Area2D

export(NodePath) var jump_pad_path
export(Vector2) var shape_scale = Vector2(1, 1) setget set_shape_scale

onready var jump_pad = get_node(jump_pad_path)

func set_shape_scale(value):
	shape_scale = value
	if is_inside_tree():
		$Shape.shape.extents = Vector2(50, 50) * value

func _on_Pit_body_entered(body):
	_start_respawn_for_animal(body)

func _start_respawn_for_animal(animal:Animal):
	var respawn_sequence = RespawnSequence.new()
	respawn_sequence.jump_pad = jump_pad
	animal.add_child(respawn_sequence)