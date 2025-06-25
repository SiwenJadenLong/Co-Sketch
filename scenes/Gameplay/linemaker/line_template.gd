extends RigidBody2D

var line: Line2D;

func summonLine() -> Line2D:
	line = Line2D.new();
	line.default_color = Color(1, 0.501961, 0.752941, 1);
	
	add_child(line);
	
	return line;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
