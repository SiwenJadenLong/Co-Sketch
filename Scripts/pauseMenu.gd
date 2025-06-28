extends Control

@export var randomBackgrounds : Array[Texture2D];
@onready var background: TextureRect = $background
var treeReady : bool;

func _ready() -> void:
	treeReady = true;

func pauseMenuResumePressed():
	SignalBus.togglePause.emit()
	
func pauseMenuRestartPressed():
	SignalBus.levelChange.emit(GlobalVariables.currentLevelNumber);
	
func pauseMenuLevelSelectPressed():
	get_parent().get_node("levelSelect").show();

func pauseMenuMainMenuPressed():
	call_deferred("unloadLevel");
	get_parent().get_node("mainMenu").show();

func _on_visibility_changed() -> void:
	if treeReady:
		randomize();
		background.texture = randomBackgrounds[int(randf_range(0,randomBackgrounds.size()))];
		#background.texture = randomBackgrounds[0];
