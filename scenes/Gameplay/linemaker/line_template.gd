extends RigidBody2D

var line: Line2D;
@onready var players: Array[Node] = get_parent().get_node("cursor").players;

func summonLine() -> Line2D:
	line = Line2D.new();
	line.default_color = Color(1, 0.501961, 0.752941, 1);
	
	add_child(line);
	
	return line;

func startTimer():
	$Timer.start();

func _on_timer_timeout() -> void:
	gravity_scale = 1.0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.editingExited.connect(startTimer);
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ColorRect.position = center_of_mass;
