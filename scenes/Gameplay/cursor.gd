extends Node2D

# @onready var parent = $".";
@export var lineTemplate: PackedScene = preload("res://scenes/Gameplay/linemaker/lineTemplate.tscn");
@export var collisionTemplate: PackedScene = preload("res://scenes/Gameplay/linemaker/hitbox.tscn");
@export var massPerLine : float = 1;
@export var debug : bool = false;

@onready var lineContainer := lineTemplate.instantiate();
@onready var players = get_parent().get_parent().get_node("players").get_children();

var line: Line2D;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lineContainer.name = "lineContainer";
	line = lineContainer.summonLine();
	
	SignalBus.editingExited.connect(resetLineContainer);
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = get_global_mouse_position();
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("drawEvent") and (players[0].playerState == players[0].states.editing or players[1].playerState == players[1].states.editing):
		addLinePoint(position);
		
func addLinePoint(mousePosition: Vector2) -> void:
	line.add_point(mousePosition);
	if line.get_point_count() == 1 and !lineContainer.get_parent():
		get_parent().add_child(lineContainer);
	if line.get_point_count() > 1:
		var collision = CollisionShape2D.new();
		var newSegmentShape = SegmentShape2D.new();
		newSegmentShape.a = line.get_point_position(line.get_point_count()-2);
		newSegmentShape.b = line.get_point_position(line.get_point_count()-1);
		
		collision.name = "Segment%sHitbox" % (line.get_point_count()-1) ;
		collision.shape = newSegmentShape;
		
		var combinedPosition : Vector2
		var numberOfPoints : int = line.get_point_count();
		for lineIndex in numberOfPoints:
			combinedPosition += line.get_point_position(lineIndex);\
		lineContainer.center_of_mass = combinedPosition/numberOfPoints;
		lineContainer.mass = (numberOfPoints-1) * massPerLine;
		lineContainer.debug = debug;
		lineContainer.add_child(collision);
		
func resetLineContainer():
	lineContainer = lineTemplate.instantiate();
	line = lineContainer.summonLine();
	get_parent().add_child(lineContainer);
