extends Node2D

signal reached_max_speed

onready var animal:Animal = get_parent()

var _jump_after_respawn = false

var _moving_direction = 1

func _ready():
	animal.ground_detector.connect('area_entered', self, 'start_jumping')
	animal.connect('respawned', self, '_double_back_and_jump')

func start_jumping(area):
	animal.start_jumping()

func _double_back_and_jump():
	_moving_direction = -1	
	yield(animal.ground_detector, 'area_exited')
	yield(self, 'reached_max_speed')
	_moving_direction = 1

func _physics_process(delta):
	if _moving_direction > 0:
		animal.move_right()
	elif _moving_direction < 0:
		animal.move_left()
	
	if animal.velocity.x <= -animal.get_max_speed() * 0.9:
		emit_signal('reached_max_speed')

func _on_FinishLineDetector_area_entered(area):
	var finish_line = Group.get_first_node(Group.FINISH_LINE)
	if area.get_parent() == finish_line:
		set_physics_process(false)