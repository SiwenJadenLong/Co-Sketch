extends Node

@export var currentlevel : PackedScene
var paused = false
func _ready():
	loadnewlevel()
	Signalbus.playerdeath.connect(transition);
	
func transition():
	$AnimationPlayer.play("generictransition ahh");

func loadnewlevel():
	$Level.add_child(currentlevel.instance())

func _input(event):
#	Pause Menu
	if event.is_action("Pause"):
		togglepause()

#toggling pause, freezes Level node
func togglepause():
	paused = !paused
	if paused:
		$Level.process_mode = Node.PROCESS_MODE_DISABLED
	elif !paused:
		$Level.process_mode = Node.PROCESS_MODE_INHERIT
	else:
		print("how did you get here?")


func on_resume_button_pressed():
	togglepause()
