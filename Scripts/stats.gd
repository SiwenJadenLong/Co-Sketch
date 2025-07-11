extends Control;

@onready var inkUsed: ProgressBar = $MarginContainer/HBoxContainer/inkBar
@onready var stopwatch: Label = $MarginContainer/HBoxContainer/Stopwatch;
@onready var current_level: Label = $MarginContainer/HBoxContainer/currentLevel;

@onready var coinCounter = $MarginContainer/HBoxContainer/VBoxContainer/coin/Label;
@onready var pennyCounter = $MarginContainer/HBoxContainer/VBoxContainer/penny/Label;

#connect levelwon signal to hiding the stats
func _ready():
	SignalBus.levelWon.connect(_levelWon)

#update global variables every frame.
func _process(_delta):
	inkUsed.max_value = GlobalVariables.inkLimit;
	inkUsed.value = GlobalVariables.inkLimit-GlobalVariables.totalLineDistance;
	stopwatch.text = str(GlobalVariables.levelTime).pad_decimals(2);
	current_level.text = "Level %s" % GlobalVariables.currentLevelNumber;
	coinCounter.text = str(GlobalVariables.coins);
	pennyCounter.text = str(GlobalVariables.winConditionCoins);

func _levelWon():
	hide();
