extends Node2D

# @onready var parent = $".";
@export var lineTemplate: PackedScene = preload("res://scenes/Gameplay/linemaker/lineTemplate.tscn");
@export var collisionTemplate: PackedScene = preload("res://scenes/Gameplay/linemaker/hitbox.tscn");
@export var massPerLine : float = 1;
@export var debug : bool = false;

@export var drawingRadius: float = 250;

@onready var lineContainer := lineTemplate.instantiate();
@onready var players = get_parent().get_parent().get_node("players").get_children();

var editingPlayerNumber: int;

var line: Line2D;
var previewLine: Line2D;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lineContainer.name = "lineContainer";
	line = lineContainer.summonLine();
	
	previewLine = Line2D.new();
	previewLine.default_color = Color(0.275, 1.0, 1.0, 0.4);
	
	get_parent().add_child.call_deferred(previewLine);

	SignalBus.editingEntered.connect(setPlayerEditor);
	SignalBus.editingExited.connect(resetLineContainer);
	SignalBus.editingExited.connect(deletePreviewLine);
# Called every frame. 'delta' is the elapsed time since the previous frame.

func deletePreviewLine():
	previewLine.clear_points()
	

func setPlayerEditor(playerColor: String):
	if playerColor == "Orange":
		editingPlayerNumber = 1;
	elif playerColor == "Blue":
		editingPlayerNumber = 2;
	else:
		printerr("playerColor in setPlayerEditor() is not a valid type");

func _process(delta: float) -> void:
	position = get_global_mouse_position();
	
	if line.get_point_count() == 1:
		previewLine.points = PackedVector2Array();

		previewLine.add_point(line.points[0]);
		previewLine.add_point(position);
	elif line.get_point_count() > 1:
		previewLine.points[0] = line.points[line.get_point_count() - 1];
		previewLine.points[1] = position;
		
	if players[editingPlayerNumber - 1].global_position.distance_to(position) > drawingRadius:
		previewLine.default_color = Color(1.0, 0.247, 0.294);
	else:
		previewLine.default_color = Color(0.275, 1.0, 1.0, 0.4);
		
	
func _input(event: InputEvent) -> void:
	if players[0].playerState == players[0].states.editing or players[1].playerState == players[1].states.editing:
		if event.is_action_pressed("drawEvent"):
			addLinePoint(position);
		elif event.is_action_pressed("p%s_delete" % editingPlayerNumber) and line.get_point_count() > 1:
			GlobalVariables.totalLineDistance -= line.points[line.get_point_count() - 1].distance_to(line.points[line.get_point_count() - 2]);
			line.remove_point(line.get_point_count() - 1);
			lineContainer.get_node("Segment%sHitbox" % (line.get_point_count())).queue_free();
		
func addLinePoint(mousePosition: Vector2) -> void:
	if players[editingPlayerNumber - 1].global_position.distance_to(mousePosition) <= drawingRadius:
		line.add_point(mousePosition);
		if line.get_point_count() == 1 and !lineContainer.get_parent():
			get_parent().add_child(lineContainer);
		if line.get_point_count() > 1:
			var collision = CollisionShape2D.new();
			var newSegmentShape = SegmentShape2D.new();
			collision.disabled = true;
			newSegmentShape.a = line.get_point_position(line.get_point_count()-2);
			newSegmentShape.b = line.get_point_position(line.get_point_count()-1);
			
			GlobalVariables.totalLineDistance += newSegmentShape.a.distance_to(newSegmentShape.b);
			
			collision.name = "Segment%sHitbox" % (line.get_point_count()-1) ;
			collision.shape = newSegmentShape;
			
			var combinedPosition : Vector2
			var numberOfPoints : int = line.get_point_count();
			for lineIndex in numberOfPoints:
				combinedPosition += line.get_point_position(lineIndex);
			lineContainer.center_of_mass = combinedPosition/numberOfPoints;
			lineContainer.mass = (numberOfPoints-1) * massPerLine;
			lineContainer.debug = debug;
			lineContainer.add_child(collision);
		
func resetLineContainer():
	lineContainer = lineTemplate.instantiate();
	line = lineContainer.summonLine();
	get_parent().add_child(lineContainer);
