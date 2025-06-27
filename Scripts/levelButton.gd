extends Button;

@export var levelNumber : int;
@export var randomButtonBackground : Array[Texture2D];
@onready var back: TextureRect = $TextureRect

func _ready():
	if levelNumber:
		text = "LEVEL %s" % levelNumber;
	$TextureRect.texture = randomButtonBackground[randi_range(0,randomButtonBackground.size()-1)];
	if randi_range(0,1)== 1: back.flip_h = true;
	if randi_range(0,1)== 1: back.flip_v = true;
func _on_pressed():
	if levelNumber:
		SignalBus.levelChange.emit(levelNumber);
