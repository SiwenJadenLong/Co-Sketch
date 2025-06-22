extends Node;

var paused = false;
var canPause = true;

@onready var levelContainer = $levelContainer;

@onready var mainUI = $mainUI;

@onready var pauseMenu = $mainUI/pauseMenu;
@onready var stats: Control = $mainUI/stats;
@onready var mainMenu: Control = $mainUI/mainMenu;
@onready var levelSelect: Control = $mainUI/levelSelect;

var levelInstance;
var currentLevelName : String;

#Connect signals and load lvl1 as default
func _ready():
	#call_deferred("loadNewLevel", "lvl1")
	SignalBus.playerDeath.connect(playerDeath);
	SignalBus.levelChange.connect(loadNewLevel);

#On player death signal, load new level and play placeholder transition
func playerDeath():
	call_deferred("loadNewLevel", currentLevelName);
	$AnimationPlayer.play("generictransition ahh");


#Loading and unloading new levels-----------------------------------
func unloadLevel():
	stats.hide()
	if (is_instance_valid(levelInstance)):
		levelInstance.queue_free();
	levelInstance = null;

func loadNewLevel(levelName : String):
	unloadLevel();
	var levelPath := "res://scenes/levels/%s.tscn" % levelName;
	var levelResource := load(levelPath);
	if levelResource:
		levelInstance = levelResource.instantiate();
		levelContainer.add_child(levelInstance);
	currentLevelName = levelName;
	stats.show();
	hideallpopupui();
#----------------------------------------------------------------------

# Pausing-----------------------------------
func _input(event):
#	Pause Menu
	if event.is_action("Pause") and canPause:
		togglePause();

func hideallpopupui():
	paused = false;
	levelContainer.process_mode = Node.PROCESS_MODE_INHERIT;
	pauseMenu.hide();
	get_tree().paused = false;
	levelSelect.hide();
	mainMenu.hide();

#toggling pause, freezes Level node
func togglePause():
	paused = !paused;
	if paused:
		levelContainer.process_mode = Node.PROCESS_MODE_DISABLED;
		pauseMenu.visible = true;
		get_tree().paused = true;
		SignalBus.gamePaused.emit(true);
	elif !paused:
		levelContainer.process_mode = Node.PROCESS_MODE_INHERIT;
		pauseMenu.visible = false;
		get_tree().paused = false;
		SignalBus.gamePaused.emit(false);
	else:
		print("how did you get here?");

#-----------------------------------

#


#Pause Menu Code-----------------------------------
func pauseMenuResumePressed():
	togglePause();
	
func pauseMenuRestartPressed():
	SignalBus.levelChange.emit(currentLevelName);
	#call_deferred("loadNewLevel", currentLevelName)
	
func pauseMenuLevelSelectPressed():
	levelSelect.visible = true;

func pauseMenuMainMenuPressed():
	call_deferred("unloadLevel");
	mainMenu.show();

#-----------------------------------

#----Level Select code----------------
func levelSelectExitPressed():
	levelSelect.visible = false;
#-----------------------------------


#Main Menu Code-----------------------------------
func mainMenuStartPressed():
	SignalBus.levelChange.emit("lvl1");
	mainMenu.hide();

func mainMenuLevelSelectPressed() -> void:
	levelSelect.visible = true;
#-----------------------------------
