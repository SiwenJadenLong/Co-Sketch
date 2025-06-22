extends Node2D;

var winCondition : bool;
@onready var allObjects : Array[Node] = $objects.get_children()
@onready var allPlayers : Array[Node] = $players.get_children()
signal doorOpened;

#Freeze Objects
func stopobjects():
	$objects.process_mode = Node.PROCESS_MODE_DISABLED;

#Run on node entering game
func _ready():
	#dooropened.connect(win)
#	Placeholder always win
#	TODO make win condition with coins or smth	
	for x in allObjects:
		if x is door:
			x.winCondition = true;

func levelWin_check():
	var levelWin := true
	for object in allObjects:
		if object is door:
			if !object.opendoor:
				levelWin = false;
	return levelWin;

#func win():
	#if levelWin_check():
		#
