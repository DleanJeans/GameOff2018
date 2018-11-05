class_name Animal
extends KinematicBody2D

signal jumped

var velocity = Vector2() setget set_velocity, get_velocity
var kind = AnimalKind.new()

func set_velocity(value):
	$Movement.velocity = value

func get_velocity():
	return $Movement.velocity

func get_max_speed():
	return kind.land_speed

func start_jumping():
	$Movement.start_jumping()

func stop_jumping():
	$Movement.stop_jumping()

func move_left():
	$Movement.move_left()

func move_right():
	$Movement.move_right()