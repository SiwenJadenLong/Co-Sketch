extends Node2D

# @onready var parent = $".";
@export var lineTemplate: PackedScene = preload("res://scenes/Gameplay/linemaker/lineTemplate.tscn");

@onready var line := lineTemplate.instantiate();

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = get_global_mouse_position();
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("drawEvent"):
		addLinePoint(position);
		
func addLinePoint(mousePosition: Vector2) -> void:
	line.get_node("Line2D").add_point(mousePosition);
