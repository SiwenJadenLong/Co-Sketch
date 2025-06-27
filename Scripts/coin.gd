extends Area2D
class_name coin

@export var penny: bool = false;

var up: bool = true;

var preTween: float;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if penny:
		$Sprite2D.animation = "penny";
	else:
		$Sprite2D.animation = "default";

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
