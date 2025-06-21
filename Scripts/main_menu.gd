extends Control

func _on_start_pressed():
	Signalbus.levelchange.emit("lvl1");
	hide()
