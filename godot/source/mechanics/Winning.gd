extends Node2D

var finish_line:FinishLine

func _ready():
	finish_line = Group.get_first_node(Group.FINISH_LINE)
	finish_line.connect('reached', self, '_on_animal_finished')

func _on_animal_finished(animal:Animal):
	print('Yay!')