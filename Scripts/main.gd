extends Node

var paused = false
@onready var main_ui = $Main_UI
@onready var pause_menu = $Main_UI/Pause_Menu
@onready var levelcontainer = $Levelcontainer
@onready var main_menu: Control = $"Main_UI/Main Menu"
@onready var stats: Control = $Main_UI/Stats

var level_instance
var currentlevelname : String

#Connect signals and load lvl1 as default
func _ready():
	#call_deferred("load_new_level", "lvl1")
	Signalbus.playerdeath.connect(playerdeath);
	Signalbus.levelchange.connect(load_new_level);

#On player death signal, load new level and play placeholder transition
func playerdeath():
	load_new_level(currentlevelname)
	$AnimationPlayer.play("generictransition ahh");


#Loading and unloading new levels-----------------------------------
func unload_level():
	stats.hide()
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
	currentlevelname = level_name
	stats.show()
	hideallpopupui()
#----------------------------------------------------------------------

# Pausing-----------------------------------
func _input(event):
#	Pause Menu
	if event.is_action("Pause"):
		togglepause()

func hideallpopupui():
	paused = false;
	levelcontainer.process_mode = Node.PROCESS_MODE_INHERIT;
	pause_menu.visible = false;
	get_tree().paused = false;
	$Main_UI/Level_Select.visible = false

#toggling pause, freezes Level node
func togglepause():
	paused = !paused
	if paused:
		levelcontainer.process_mode = Node.PROCESS_MODE_DISABLED;
		pause_menu.visible = true;
		get_tree().paused = true;
		Signalbus.gamepaused.emit(true)
	elif !paused:
		levelcontainer.process_mode = Node.PROCESS_MODE_INHERIT
		pause_menu.visible = false;
		get_tree().paused = false;
		Signalbus.gamepaused.emit(false)
	else:
		print("how did you get here?")

#-----------------------------------

#


#Pause Menu Code-----------------------------------
func _on_resume_pressed():
	togglepause()
	
func _on_restart_pressed():
	load_new_level(currentlevelname)
	
func _on_main_menu_pressed():
	call_deferred("unload_level")
	main_menu.show()
	

func _on_level_select_pressed():
	$Main_UI/Level_Select.visible = true

#----Level Select code----------------
func level_select_exit_pressed():
	$Main_UI/Level_Select.visible = false
#-----------------------------------
