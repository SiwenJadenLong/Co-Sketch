extends Node2D

# @onready var parent = $".";
@export var lineTemplate: PackedScene = preload("res://scenes/Gameplay/linemaker/lineTemplate.tscn");
@export var collisionTemplate: PackedScene = preload("res://scenes/Gameplay/linemaker/hitbox.tscn");

@onready var lineContainer := lineTemplate.instantiate();
@onready var line := lineContainer.get_node("Line2D");

@onready var player = get_parent().get_parent();

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN);
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = get_global_mouse_position();
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("drawEvent") and player.playerState == player.states.editing:
		addLinePoint(position);
		
func addLinePoint(mousePosition: Vector2) -> void:
	line.add_point(mousePosition);
	if line.get_point_count() == 1:
		get_parent().add_child(lineContainer);
	if line.get_point_count() > 1:
		var collision = CollisionShape2D.new();
		var newSegmentShape = SegmentShape2D.new();
		newSegmentShape.a = line.get_point_position(line.get_point_count()-2);
		newSegmentShape.b = line.get_point_position(line.get_point_count()-1);
		collision.name = "Segment%sHitbox" % (line.get_point_count()-1) ;
		collision.shape = newSegmentShape;
		lineContainer.add_child(collision);
