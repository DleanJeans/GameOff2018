class_name FinishLine
extends Node2D

export(bool) var detecting = true

signal reached(animal)

var animals_reached = []

func _init():
	if detecting:
		add_to_group(Group.FINISH_LINE)

func _on_Area_body_entered(body):
	if detecting and not body in animals_reached:
		animals_reached.append(body)
		emit_signal('reached', body)