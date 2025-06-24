extends Control

@onready var finalTime: Label = $Background/Panel/MarginContainer/VBoxContainer/finalTime

func _ready():
	SignalBus.levelWon.connect(_levelWon)

func _process(delta):
	finalTime.text = "Finished in: %s" % str(GlobalVariables.levelTime).pad_decimals(2);

func _levelWon():
	show()


func winScreenLevelSelectPressed() -> void:
	get_parent().get_node("levelSelect").show()


func winScreenNextLevelPressed() -> void:
	var nextLevelNumber = GlobalVariables.currentLevelNumber + 1
	SignalBus.levelChange.emit(nextLevelNumber)
	hide()
