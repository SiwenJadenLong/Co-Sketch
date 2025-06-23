extends Button;

@export var levelNumber : int;
#
func _ready():
	if levelNumber:
		text = "LEVEL%s" % levelNumber;
	#text = "test"

func _on_pressed():
	if levelNumber:
		SignalBus.levelChange.emit(levelNumber);
