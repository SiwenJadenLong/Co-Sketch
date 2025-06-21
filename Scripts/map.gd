extends Node2D

var wincondition : bool
#Freeze Objects
func stopobjects():
	$Objects.process_mode = Node.PROCESS_MODE_DISABLED;

#Placeholder always win
#TODO make win condition with coins or smth
func _ready():
	wincondition = true
