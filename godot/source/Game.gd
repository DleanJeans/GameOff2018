extends Node2D

onready var player_control = $Mechanics/PlayerControl
onready var time_control = $Mechanics/TimeControl
onready var countdown = $Mechanics/Countdown

func _ready():
	time_control.pause()
	countdown.connect('timeout', time_control, 'unpause')
	
	_set_random_animal_as_player()
	
	countdown.connect('started_one_sec', $UI/CountdownLabel, 'play_animation')

func _set_random_animal_as_player():
	var animals = Group.get_nodes(Group.ANIMALS)
	var random_index = randi() % animals.size()
	var player = animals[random_index]
	player_control.set_player(player)
	animals.remove(random_index)
	
	for a in animals:
		var brain = Scenes.Brain.instance()
		a.add_child(brain)