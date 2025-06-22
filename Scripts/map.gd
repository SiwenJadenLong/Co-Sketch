extends Node2D;

var winCondition : bool;
@onready var objects := $objects;
@onready var players := $players;
@onready var allobjects : Array[Node] = $players.get_children()
@onready var allplayers : Array[Node] = $objects.get_children()
signal doorOpened;

#Freeze Objects
func stopobjects():
	$objects.process_mode = Node.PROCESS_MODE_DISABLED;

#Run on node entering game
func _ready():
	#dooropened.connect(win)
#	Placeholder always win
#	TODO make win condition with coins or smth	
	for x in allobjects:
		if x is door:
			x.win_condition = true;

func level_win_check():
	var level_win := true
	for object in allobjects:
		if object is door:
			if !object.opendoor:
				level_win = false;
	return level_win;

#func win():
	#if level_win_check():
		#
