extends Node;

var paused = false;
var canPause = true;

@onready var levelContainer = $levelContainer;

@onready var mainUI = $mainUI;

#MainUI things
@onready var pauseMenu: Control = $mainUI/pauseMenu;
@onready var stats: Control = $mainUI/stats;
@onready var mainMenu: Control = $mainUI/mainMenu;
@onready var levelSelect: Control = $mainUI/levelSelect;
@onready var winScreen: Control = $mainUI/winScreen

#Overlay
@onready var deathMarkers: Node2D = $overLay/deathMarkers;
@export var deathSequenceTime : float;

var levelInstance;

func _ready():
	SignalBus.playerDeath.connect(playerDeath);
	SignalBus.levelChange.connect(loadNewLevel);
	SignalBus.togglePause.connect(togglePause);
	SignalBus.unloadLevel.connect(unloadLevel);

#On player death signal, load new level and play placeholder transition
func playerDeath():
	deathMarkers.show();
	await get_tree().create_timer(deathSequenceTime).timeout;
	levelContainer.process_mode = Node.PROCESS_MODE_DISABLED;
	deathMarkers.hide();
	await call_deferred("loadNewLevel", GlobalVariables.currentLevelNumber);
	levelContainer.process_mode = Node.PROCESS_MODE_PAUSABLE;


#Loading and unloading new levels-----------------------------------
func unloadLevel():
	stats.hide()
	if (is_instance_valid(levelInstance)):
		levelInstance.queue_free();
	levelInstance = null;

func loadNewLevel(levelnumber : int):
	unloadLevel();
	var levelPath : String = "res://scenes/levels/lvl%s.tscn" % str(levelnumber);
	var levelResource : PackedScene = load(levelPath);
	if levelResource:
		levelInstance = levelResource.instantiate();
		levelContainer.add_child(levelInstance);
	GlobalVariables.currentLevelNumber = levelnumber;
#	TODO Make level loader string compatible
	GlobalVariables.currentLevelName = "lvl%s" % str(levelnumber);
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
	winScreen.hide();

#toggling pause, freezes Level node
func togglePause():
	paused = !paused;
	if paused:
		pauseMenu.show();
		get_tree().paused = true;
		SignalBus.gamePaused.emit(true);
	else:
		pauseMenu.hide();
		get_tree().paused = false;
		SignalBus.gamePaused.emit(false);

#-----------------------------------
