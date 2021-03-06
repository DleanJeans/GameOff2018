extends Timer

export(bool) var debug_disabled = false

signal started_one_sec(sec)

var wait

func _ready():
	if debug_disabled:
		wait_time = 1
	
	start(wait_time + 1)
	
	while time_left > 0:
		yield(get_tree().create_timer(1), 'timeout')
		_emit_one_sec()

func _emit_one_sec():
	emit_signal('started_one_sec', round(time_left))
	print('Time Left: %s' % round(time_left))