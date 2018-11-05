extends Node

const ANIMALS = 'Animals'
const FINISH_LINE = 'FinishLine'

func get_nodes(group:String):
	return get_tree().get_nodes_in_group(group)

func get_first_node(group:String):
	return get_nodes(group)[0]