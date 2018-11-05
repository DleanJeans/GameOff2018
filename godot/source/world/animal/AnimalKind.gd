class_name AnimalKind
extends Node

export(int) var land_speed = 500
export(int) var air_speed = 0
export(int) var water_speed = 10
export(int) var jump_speed = 500

func can_fly():
	return air_speed > 0