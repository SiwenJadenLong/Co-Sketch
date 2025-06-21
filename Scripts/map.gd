extends Node2D

var wincondition : bool
@onready var allobjects: Array[Node] = $Objects.get_children()
@onready var allplayers: Array[Node] = $Players.get_children()

#Freeze Objects
func stopobjects():
	$Objects.process_mode = Node.PROCESS_MODE_DISABLED;

#Placeholder always win
#TODO make win condition with coins or smth
func _ready():
	for x in allobjects:
		if x is door:
			x.win_condition = true

func level_win_check():
	var level_win := true
	for object in allobjects:
		if object is door:
			if !object.opendoor:
				level_win = false
	return level_win
