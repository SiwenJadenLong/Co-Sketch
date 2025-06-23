extends Control;

@onready var stopwatch: Label = $MarginContainer/HBoxContainer/Stopwatch;
@onready var current_level: Label = $MarginContainer/HBoxContainer/currentLevel;

func _ready():
	SignalBus.levelWon.connect(_levelWon)

func _process(delta):
	stopwatch.text = str(GlobalVariables.levelTime).pad_decimals(2);
	current_level.text = "Level %s" % GlobalVariables.currentLevelNumber;

func _levelWon():
	hide();
