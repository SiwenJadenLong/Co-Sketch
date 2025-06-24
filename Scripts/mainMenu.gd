extends Control

func mainMenuStartPressed():
	SignalBus.levelChange.emit(1);
	hide();

func mainMenuLevelSelectPressed() -> void:
	get_parent().get_node("levelSelect").show();
