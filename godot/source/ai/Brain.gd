extends Node2D

onready var animal:Animal = get_parent()

func _process(delta):
	think()

func think():
	animal.move_right()

func _on_FinishLineDetector_area_entered(area):
	var finish_line = Group.get_first_node(Group.FINISH_LINE)
	if area.get_parent() == finish_line:
		set_process(false)