extends RigidBody2D

var line: Line2D;
@onready var players: Array[Node] = get_parent().get_node("cursor").players;
var debug : bool = false;

@onready var centerOfMass: Sprite2D = $centerOfMassMarker;
@onready var masslabel: Label = $centerOfMassMarker/massLabel;


func enableAllCollision():
	for child in get_children():
		if child is CollisionShape2D:
			child.disabled = false;

func summonLine() -> Line2D:
	line = Line2D.new();
	line.default_color = Color(0.275, 1.0, 1.0, 0.8);
	add_child(line);
	
	return line;

func lineExitEditing():
	line.default_color = Color(1, 0.501961, 0.752941, 1);
	enableAllCollision();

func startTimer():
	$Timer.start();

func _on_timer_timeout() -> void:
	gravity_scale = 1.0;
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.editingExited.connect(startTimer);
	SignalBus.editingExited.connect(lineExitEditing);
	SignalBus.lineKill.connect(queue_free);
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if debug:
		centerOfMass.show();
		centerOfMass.position = center_of_mass;
		masslabel.text = "%sKG" % mass;
