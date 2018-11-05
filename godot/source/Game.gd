extends Node2D

onready var player = $World/Animal
onready var player_control = $Mechanics/PlayerControl

func _ready():
	player_control.set_player(player)