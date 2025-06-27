extends Area2D
class_name coin
@export var amplitude: int;
@export var bobSpeed: float;
var up: bool = true;

var preTween: float;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#TODO Tween this value
	
	if up:
		if preTween <= amplitude:
			preTween += bobSpeed;
		else:
			up = false;
	else:
		if preTween >= -amplitude:
			preTween -= bobSpeed;
		else:
			up = true;
			
	position.y = preTween;
