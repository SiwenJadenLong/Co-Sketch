extends Node

@export var currentlevel : PackedScene
var paused = false
@onready var main_ui = $Main_UI
@onready var pause_menu = $Main_UI/Pause_Menu
@onready var levelcontainer = $Levelcontainer
var level_instance


func _ready():
	load_new_level("lvl1")
	Signalbus.playerdeath.connect(playerdeath);
	Signalbus.levelchange.connect(load_new_level);
	
func playerdeath():
	
	$AnimationPlayer.play("generictransition ahh");


#Loading and unloading new levels-----------------------------------
func unload_level():
	if (is_instance_valid(level_instance)):
		level_instance.queue_free()
	level_instance = null

func load_new_level(level_name : String):
	unload_level()
	var level_path := "res://scenes/levels/%s.tscn" % level_name
	var level_resource := load(level_path)
	if level_resource:
		level_instance = level_resource.instantiate()
		levelcontainer.add_child(level_instance)
	
#----------------------------------------------------------------------

# Pausing-----------------------------------
func _input(event):
#	Pause Menu
	if event.is_action("Pause"):
		togglepause()

#toggling pause, freezes Level node
func togglepause():
	paused = !paused
	if paused:
		levelcontainer.process_mode = Node.PROCESS_MODE_DISABLED;
		pause_menu.visible = true;
		get_tree().paused = true;
	elif !paused:
		levelcontainer.process_mode = Node.PROCESS_MODE_INHERIT
		pause_menu.visible = false;
		get_tree().paused = false;
	else:
		print("how did you get here?")

#-----------------------------------

#Pause Menu Code-----------------------------------
func on_resume_button_pressed():
	togglepause()
	
func _on_restart_pressed():
	pass # Replace with function body.
	
func _on_main_menu_pressed():
	pass # Replace with function body.

func _on_level_select_pressed():
	$Main_UI/Level_Select.visible = true

#-----------------------------------
func level_select_exit_pressed():
	$Main_UI/Level_Select.visible = false
#Level Select code-----------------------------------
