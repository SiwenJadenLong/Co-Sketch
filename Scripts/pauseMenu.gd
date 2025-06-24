extends Control


func pauseMenuResumePressed():
	SignalBus.togglePause.emit()
	
func pauseMenuRestartPressed():
	SignalBus.levelChange.emit(GlobalVariables.currentLevelNumber);
	
func pauseMenuLevelSelectPressed():
	get_parent().get_node("levelSelect").show();

func pauseMenuMainMenuPressed():
	call_deferred("unloadLevel");
	get_parent().get_node("mainMenu").show();
