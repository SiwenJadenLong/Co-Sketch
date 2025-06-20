extends Button

@export var levelnumber : String;

#func _ready():
	#text = "LEVEL%s" % levelnumber

func _on_pressed():
	Signalbus.levelchange.emit("lvl%s" % levelnumber);
