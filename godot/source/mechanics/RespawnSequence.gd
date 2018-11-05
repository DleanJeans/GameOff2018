class_name RespawnSequence
extends Node2D

onready var animal:Animal = get_parent()
onready var timer:Timer = Timer.new()

var freeze_time = 3
var jump_pad:JumpPad

func _ready():
	add_child(timer)
	timer.connect('timeout', self, 'queue_free')
	timer.start(freeze_time)
	
	animal.position = jump_pad.top
	var respawn_flashing = Scenes.RespawnFlashing.instance()
	respawn_flashing.connect('tree_exiting', animal, 'emit_signal', ['respawned'])
	animal.add_child(respawn_flashing)
	animal.set_meta('frozen', true)

func _exit_tree():
	animal.set_meta('frozen', null)

func _physics_process(delta):
#	animal.velocity = Vector2(0, 5)
	animal.velocity.x = 0