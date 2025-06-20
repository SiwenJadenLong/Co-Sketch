extends Node2D
#var startingpos : Vector2 = 

#Placeholder player respawn
#func _ready():
	#Signalbus.playerdeath.connect(reset);

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		body.position = Vector2(0,0);

#Freeze Objects
func stopobjects():
	$Objects.process_mode = Node.PROCESS_MODE_DISABLED;


func _on_tree_entered():
	$Camera2D.make_current()
