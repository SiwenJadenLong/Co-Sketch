extends Button;

@export var levelNumber : String;
#
func _ready():
	if levelNumber:
		text = "LEVEL%s" % levelNumber;
	#text = "test"

func _on_pressed():
	if levelNumber:
		SignalBus.levelChange.emit("lvl%s" % levelNumber);
