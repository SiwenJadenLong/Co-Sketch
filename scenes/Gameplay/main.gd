extends Node

@export var currentlevel : PackedScene
var paused = false
@onready var main_ui = $"Main UI"
@onready var pause_menu = $"Main UI/Pause Menu"
@onready var level = $Level


func _ready():
	loadnewlevel()
	Signalbus.playerdeath.connect(playerdeath);
	
func playerdeath():
	
	$AnimationPlayer.play("generictransition ahh");

func loadnewlevel():
	#$Level.add_child(currentlevel.instance())
	pass

func _input(event):
#	Pause Menu
	if event.is_action("Pause"):
		togglepause()

#toggling pause, freezes Level node
func togglepause():
	paused = !paused
	if paused:
		$Level.process_mode = Node.PROCESS_MODE_DISABLED;
		pause_menu.visible = true;
		get_tree().paused = true;
	elif !paused:
		$Level.process_mode = Node.PROCESS_MODE_INHERIT
		pause_menu.visible = false;
		get_tree().paused = false;
	else:
		print("how did you get here?")

#Pause Menu Code-----------------------------------
func on_resume_button_pressed():
	togglepause()
	
func _on_restart_pressed():
	pass # Replace with function body.
	
func _on_main_menu_pressed():
	pass # Replace with function body.

func _on_level_select_pressed():
	pass # Replace with function body.

#-----------------------------------
