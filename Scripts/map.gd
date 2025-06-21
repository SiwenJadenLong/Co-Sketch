extends Node2D
#Placeholder player respawn
#func _ready():
	#Signalbus.playerdeath.connect(reset);


#Freeze Objects
func stopobjects():
	$Objects.process_mode = Node.PROCESS_MODE_DISABLED;


func _on_tree_entered():
	$Camera2D.make_current()
