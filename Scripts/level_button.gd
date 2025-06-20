extends Button

@export var levelnumber : String
#
func _ready():
	if levelnumber:
		text = "LEVEL%s" % levelnumber
	#text = "test"

func _on_pressed():
	if levelnumber:
		Signalbus.levelchange.emit("lvl%s" % levelnumber);
