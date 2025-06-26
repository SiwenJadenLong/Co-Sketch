extends Control

@onready var finalTime: Label = $Background/Panel/MarginContainer/VBoxContainer/finalTime
@onready var player1Deaths: Label = $Background/Panel/MarginContainer/VBoxContainer/HBoxContainer2/P1/perLevelDeaths
@onready var player2Deaths: Label = $Background/Panel/MarginContainer/VBoxContainer/HBoxContainer2/P2/perLevelDeaths

func _ready():
	SignalBus.levelWon.connect(_levelWon)

func _process(delta):
	pass
func _levelWon():
	finalTime.text = "Finished in: %s" % str(GlobalVariables.levelTime).pad_decimals(2);
	player1Deaths.text = "Deaths: %s" % GlobalVariables.perLevelOrangeDeathCounter;
	player2Deaths.text = "Deaths: %s" % GlobalVariables.perLevelBlueDeathCounter;
	
	show();

#TODO Add Death Counter per player on win screen
# Characters will stand on opposite sides and squint at each other while the death counter counts up.
# In the end, whoever has more deaths has the eye cross expression and the other has happy expression

func winScreenLevelSelectPressed() -> void:
	get_parent().get_node("levelSelect").show()


func winScreenNextLevelPressed() -> void:
	var nextLevelNumber = GlobalVariables.currentLevelNumber + 1
	SignalBus.levelChange.emit(nextLevelNumber)
	hide()
	
	GlobalVariables.perLevelOrangeDeathCounter = 0;
	GlobalVariables.perLevelBlueDeathCounter = 0;
